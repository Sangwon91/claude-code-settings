# React + TypeScript + Vite + Playwright E2E 테스트 가이드

## 스택 개요
- **기술들**: React 18/19 + TypeScript 5+ + Vite 5+ + Playwright 1.47+
- **사용 사례**: React 프론트엔드 애플리케이션의 End-to-End 테스트
- **복잡도**: 중급
- **최종 업데이트**: 2025-01-20

## 호환성 매트릭스
| 기술 | 버전 | 비고 | 충돌 |
|------|------|------|------|
| React | ^18.2.0 또는 ^19.0.0 | 최신 안정 버전, Concurrent Features 지원 | 없음 |
| TypeScript | ^5.0.0 | 향상된 타입 추론 기능 | 없음 |
| Vite | ^5.0.0 | 향상된 성능의 최신 버전 | 없음 |
| Playwright | ^1.47.0 | E2E 및 컴포넌트 테스트 완전 지원 | 없음 |
| @playwright/test | ^1.47.0 | 공식 테스트 러너 | 없음 |
| @types/react | ^18.2.0 또는 ^19.0.0 | React TypeScript 정의 | React 버전과 일치해야 함 |
| @types/react-dom | ^18.2.0 또는 ^19.0.0 | React DOM TypeScript 정의 | React 버전과 일치해야 함 |
| @types/node | latest | Node.js TypeScript 정의 | Vite 설정에 필요 |

## 빠른 시작 설정

### 필수 조건
- Node.js 18+ (권장: 20+)
- 기존 React + TypeScript + Vite 프로젝트
- VS Code 또는 TypeScript 지원 에디터
- 브라우저 테스트에 대한 기본 이해

### Playwright 설치 및 초기화
```bash
# 기존 React + TypeScript + Vite 프로젝트에서 시작
cd my-react-app

# Playwright 설치 및 초기화
npm init playwright@latest

# 또는 특정 옵션으로 설치
npx create-playwright@latest --template=typescript

# 브라우저 설치
npx playwright install
```

### 패키지 매니저별 설치
```bash
# yarn 사용
yarn create playwright

# pnpm 사용
pnpm create playwright

# bun 사용
bun create playwright
```

## 설정 파일

### playwright.config.ts
```typescript
import { defineConfig, devices } from '@playwright/test';

/**
 * @see https://playwright.dev/docs/test-configuration
 */
export default defineConfig({
  testDir: './tests/e2e',
  /* 병렬 테스트 실행 */
  fullyParallel: true,
  /* CI에서 실패한 테스트 재시도 방지 */
  forbidOnly: !!process.env.CI,
  /* CI에서 재시도 설정 */
  retries: process.env.CI ? 2 : 0,
  /* CI에서 병렬 워커 수 제한 */
  workers: process.env.CI ? 1 : undefined,
  /* 리포터 설정 */
  reporter: [
    ['html'],
    ['json', { outputFile: 'test-results/results.json' }],
    ['junit', { outputFile: 'test-results/results.xml' }]
  ],
  /* 공통 설정 */
  use: {
    /* Base URL로 개발 서버 설정 */
    baseURL: 'http://localhost:5173',
    
    /* 실패시 스크린샷 수집 */
    screenshot: 'only-on-failure',
    
    /* 첫 번째 재시도시 추적 수집 */
    trace: 'on-first-retry',
    
    /* 비디오 녹화 설정 */
    video: 'retain-on-failure',
  },

  /* 프로젝트별 브라우저 설정 */
  projects: [
    {
      name: 'chromium',
      use: { ...devices['Desktop Chrome'] },
    },
    {
      name: 'firefox',
      use: { ...devices['Desktop Firefox'] },
    },
    {
      name: 'webkit',
      use: { ...devices['Desktop Safari'] },
    },
    /* 모바일 뷰포트 테스트 */
    {
      name: 'Mobile Chrome',
      use: { ...devices['Pixel 5'] },
    },
    {
      name: 'Mobile Safari',
      use: { ...devices['iPhone 12'] },
    },
  ],

  /* 개발 서버 자동 시작 */
  webServer: {
    command: 'npm run dev',
    url: 'http://localhost:5173',
    reuseExistingServer: !process.env.CI,
    stdout: 'ignore',
    stderr: 'pipe',
  },
});
```

### package.json 스크립트 추가
```json
{
  "scripts": {
    "dev": "vite",
    "build": "tsc && vite build",
    "preview": "vite preview",
    "test:e2e": "playwright test",
    "test:e2e:ui": "playwright test --ui",
    "test:e2e:debug": "playwright test --debug",
    "test:e2e:report": "playwright show-report",
    "test:e2e:codegen": "playwright codegen http://localhost:5173"
  }
}
```

### tsconfig.json 업데이트 (테스트용)
```json
{
  "compilerOptions": {
    "target": "ES2020",
    "useDefineForClassFields": true,
    "lib": ["ES2020", "DOM", "DOM.Iterable"],
    "module": "ESNext",
    "skipLibCheck": true,
    
    /* Bundler mode */
    "moduleResolution": "bundler",
    "allowImportingTsExtensions": true,
    "resolveJsonModule": true,
    "isolatedModules": true,
    "noEmit": true,
    "jsx": "react-jsx",
    
    /* Linting */
    "strict": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "noFallthroughCasesInSwitch": true,
    
    /* Path mapping */
    "baseUrl": ".",
    "paths": {
      "@/*": ["./src/*"],
      "@/tests/*": ["./tests/*"]
    }
  },
  "include": ["src", "tests"],
  "references": [{ "path": "./tsconfig.node.json" }]
}
```

## 통합 패턴

### React + TypeScript + Playwright 통합
```typescript
// tests/e2e/example.spec.ts
import { test, expect } from '@playwright/test';

// 페이지 객체 모델 패턴
class LoginPage {
  constructor(private page: any) {}

  async navigate() {
    await this.page.goto('/login');
  }

  async fillUsername(username: string) {
    await this.page.getByLabel('Username').fill(username);
  }

  async fillPassword(password: string) {
    await this.page.getByLabel('Password').fill(password);
  }

  async submit() {
    await this.page.getByRole('button', { name: 'Sign in' }).click();
  }

  async expectSuccessfulLogin() {
    await expect(this.page.getByRole('button', { name: 'Profile' })).toBeVisible();
  }
}

test.describe('사용자 인증', () => {
  test('올바른 자격 증명으로 로그인', async ({ page }) => {
    const loginPage = new LoginPage(page);
    
    await loginPage.navigate();
    await loginPage.fillUsername('test@example.com');
    await loginPage.fillPassword('password123');
    await loginPage.submit();
    await loginPage.expectSuccessfulLogin();
  });
});
```

### Vite + Playwright 환경 변수 통합
```typescript
// vite.config.ts에서 환경 변수 설정
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig({
  plugins: [react()],
  server: {
    port: 5173,
  },
  preview: {
    port: 4173,
  },
  define: {
    // 테스트 환경에서 사용할 변수들
    __APP_VERSION__: JSON.stringify(process.env.npm_package_version),
    __TEST_MODE__: JSON.stringify(process.env.NODE_ENV === 'test'),
  },
})
```

```typescript
// tests/e2e/helpers/test-data.ts
export const testUsers = {
  admin: {
    email: 'admin@test.com',
    password: 'admin123',
    role: 'admin'
  },
  user: {
    email: 'user@test.com', 
    password: 'user123',
    role: 'user'
  }
} as const;

export const apiEndpoints = {
  login: '/api/auth/login',
  logout: '/api/auth/logout',
  profile: '/api/user/profile'
} as const;
```

## E2E 테스트 모범 사례 (2025년)

### 1. 사용자 중심 테스트 작성
```typescript
// ❌ 구현 세부사항에 의존하는 테스트
test('counter state updates correctly', async ({ page }) => {
  await page.goto('/counter');
  await page.locator('#increment-btn').click();
  await expect(page.locator('#count-value')).toHaveText('1');
});

// ✅ 사용자 경험에 초점을 맞춘 테스트
test('사용자가 카운터를 증가시킬 수 있다', async ({ page }) => {
  await page.goto('/counter');
  await page.getByRole('button', { name: '증가' }).click();
  await expect(page.getByText('1')).toBeVisible();
});
```

### 2. TypeScript 데코레이터 활용
```typescript
// tests/e2e/decorators/step.ts
import { test } from '@playwright/test';

function step(target: Function, context: ClassMethodDecoratorContext) {
  return function replacementMethod(...args: any) {
    const name = this.constructor.name + '.' + (context.name as string);
    return test.step(name, async () => {
      return await target.call(this, ...args);
    });
  };
}

class ECommerceFlow {
  constructor(private page: any) {}

  @step
  async 상품_검색(searchTerm: string) {
    await this.page.getByPlaceholder('상품 검색').fill(searchTerm);
    await this.page.getByRole('button', { name: '검색' }).click();
  }

  @step
  async 장바구니에_추가() {
    await this.page.getByRole('button', { name: '장바구니에 추가' }).first().click();
    await expect(this.page.getByText('장바구니에 추가되었습니다')).toBeVisible();
  }

  @step
  async 결제_진행() {
    await this.page.getByRole('link', { name: '장바구니' }).click();
    await this.page.getByRole('button', { name: '결제하기' }).click();
  }
}
```

### 3. 재사용 가능한 픽스처 정의
```typescript
// tests/e2e/fixtures/index.ts
import { test as base } from '@playwright/test';
import { LoginPage } from '../pages/LoginPage';
import { DashboardPage } from '../pages/DashboardPage';

type TestFixtures = {
  loginPage: LoginPage;
  dashboardPage: DashboardPage;
  authenticatedUser: void;
};

export const test = base.extend<TestFixtures>({
  loginPage: async ({ page }, use) => {
    await use(new LoginPage(page));
  },

  dashboardPage: async ({ page }, use) => {
    await use(new DashboardPage(page));
  },

  authenticatedUser: async ({ loginPage }, use) => {
    await loginPage.navigate();
    await loginPage.login('user@test.com', 'password123');
    await use();
  },
});

export { expect } from '@playwright/test';
```

### 4. API 요청 모킹 및 가로채기
```typescript
// tests/e2e/api-mocking.spec.ts
import { test, expect } from './fixtures';

test('API 응답 모킹으로 에러 상황 테스트', async ({ page }) => {
  // API 요청 가로채기
  await page.route('**/api/products', async route => {
    await route.fulfill({
      status: 500,
      contentType: 'application/json',
      body: JSON.stringify({ error: 'Internal Server Error' })
    });
  });

  await page.goto('/products');
  await expect(page.getByText('상품을 불러오는 중 오류가 발생했습니다')).toBeVisible();
});

test('성공적인 API 응답 모킹', async ({ page }) => {
  const mockProducts = [
    { id: 1, name: '상품 1', price: 10000 },
    { id: 2, name: '상품 2', price: 20000 }
  ];

  await page.route('**/api/products', async route => {
    await route.fulfill({
      status: 200,
      contentType: 'application/json',
      body: JSON.stringify(mockProducts)
    });
  });

  await page.goto('/products');
  await expect(page.getByText('상품 1')).toBeVisible();
  await expect(page.getByText('상품 2')).toBeVisible();
});
```

### 5. 시각적 회귀 테스트
```typescript
// tests/e2e/visual.spec.ts
import { test, expect } from '@playwright/test';

test('메인 페이지 시각적 회귀 테스트', async ({ page }) => {
  await page.goto('/');
  
  // 전체 페이지 스크린샷
  await expect(page).toHaveScreenshot('homepage.png');
  
  // 특정 컴포넌트 스크린샷
  await expect(page.getByTestId('hero-section')).toHaveScreenshot('hero-section.png');
});

test('반응형 디자인 테스트', async ({ page }) => {
  // 모바일 뷰포트
  await page.setViewportSize({ width: 375, height: 667 });
  await page.goto('/');
  await expect(page).toHaveScreenshot('homepage-mobile.png');
  
  // 태블릿 뷰포트
  await page.setViewportSize({ width: 768, height: 1024 });
  await expect(page).toHaveScreenshot('homepage-tablet.png');
  
  // 데스크톱 뷰포트
  await page.setViewportSize({ width: 1920, height: 1080 });
  await expect(page).toHaveScreenshot('homepage-desktop.png');
});
```

## 실제 사용 시나리오

### 복잡한 사용자 플로우 테스트
```typescript
// tests/e2e/user-journey.spec.ts
import { test, expect } from './fixtures';

test.describe('전자상거래 사용자 여정', () => {
  test('신규 사용자 완전한 구매 플로우', async ({ page }) => {
    // 1. 홈페이지 방문
    await page.goto('/');
    await expect(page.getByRole('heading', { name: '환영합니다' })).toBeVisible();

    // 2. 상품 검색
    await page.getByPlaceholder('상품 검색').fill('노트북');
    await page.getByRole('button', { name: '검색' }).click();
    
    // 3. 검색 결과 확인
    await expect(page.getByText('검색 결과')).toBeVisible();
    
    // 4. 상품 선택
    await page.getByRole('link', { name: 'MacBook Pro' }).first().click();
    
    // 5. 상품 상세 페이지에서 장바구니 추가
    await expect(page.getByRole('heading', { name: 'MacBook Pro' })).toBeVisible();
    await page.getByRole('button', { name: '장바구니에 추가' }).click();
    await expect(page.getByText('장바구니에 추가되었습니다')).toBeVisible();
    
    // 6. 장바구니로 이동
    await page.getByRole('link', { name: '장바구니' }).click();
    await expect(page.getByText('MacBook Pro')).toBeVisible();
    
    // 7. 결제 페이지로 이동
    await page.getByRole('button', { name: '결제하기' }).click();
    
    // 8. 회원가입 (신규 사용자)
    await page.getByRole('link', { name: '회원가입' }).click();
    await page.getByLabel('이메일').fill('newuser@test.com');
    await page.getByLabel('비밀번호').fill('password123');
    await page.getByLabel('비밀번호 확인').fill('password123');
    await page.getByRole('button', { name: '가입하기' }).click();
    
    // 9. 배송 정보 입력
    await page.getByLabel('받는 사람').fill('홍길동');
    await page.getByLabel('주소').fill('서울시 강남구 테헤란로 123');
    await page.getByLabel('전화번호').fill('010-1234-5678');
    
    // 10. 결제 정보 입력
    await page.getByLabel('카드번호').fill('4111-1111-1111-1111');
    await page.getByLabel('만료일').fill('12/28');
    await page.getByLabel('CVV').fill('123');
    
    // 11. 주문 완료
    await page.getByRole('button', { name: '주문하기' }).click();
    await expect(page.getByText('주문이 완료되었습니다')).toBeVisible();
    
    // 12. 주문 확인 페이지
    await expect(page.getByText('주문번호')).toBeVisible();
  });
});
```

### 접근성 테스트 통합
```typescript
// tests/e2e/accessibility.spec.ts
import { test, expect } from '@playwright/test';
import AxeBuilder from '@axe-core/playwright';

test.describe('접근성 테스트', () => {
  test('메인 페이지 접근성 검사', async ({ page }) => {
    await page.goto('/');
    
    const accessibilityScanResults = await new AxeBuilder({ page })
      .withTags(['wcag2a', 'wcag2aa', 'wcag21a', 'wcag21aa'])
      .analyze();
    
    expect(accessibilityScanResults.violations).toEqual([]);
  });

  test('폼 접근성 검사', async ({ page }) => {
    await page.goto('/contact');
    
    const accessibilityScanResults = await new AxeBuilder({ page })
      .include('#contact-form')
      .analyze();
    
    expect(accessibilityScanResults.violations).toEqual([]);
  });
});
```

## CI/CD 통합

### GitHub Actions 워크플로우
```yaml
# .github/workflows/e2e-tests.yml
name: E2E Tests
on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main ]

jobs:
  test:
    timeout-minutes: 60
    runs-on: ubuntu-latest
    strategy:
      matrix:
        browser: [chromium, firefox, webkit]
    
    steps:
    - uses: actions/checkout@v4
    
    - uses: actions/setup-node@v4
      with:
        node-version: '20'
        cache: 'npm'
    
    - name: Install dependencies
      run: npm ci
    
    - name: Install Playwright Browsers
      run: npx playwright install --with-deps ${{ matrix.browser }}
    
    - name: Build application
      run: npm run build
    
    - name: Run Playwright tests
      run: npx playwright test --project=${{ matrix.browser }}
      env:
        CI: true
    
    - uses: actions/upload-artifact@v4
      if: always()
      with:
        name: playwright-report-${{ matrix.browser }}
        path: playwright-report/
        retention-days: 30
    
    - uses: actions/upload-artifact@v4
      if: always()
      with:
        name: test-results-${{ matrix.browser }}
        path: test-results/
        retention-days: 30
```

### Docker 기반 테스트 환경
```dockerfile
# Dockerfile.e2e
FROM mcr.microsoft.com/playwright:v1.47.0-focal

WORKDIR /app

# 의존성 복사 및 설치
COPY package*.json ./
RUN npm ci

# 소스 코드 복사
COPY . .

# 애플리케이션 빌드
RUN npm run build

# 테스트 실행
CMD ["npm", "run", "test:e2e"]
```

```yaml
# docker-compose.test.yml
version: '3.8'
services:
  e2e-tests:
    build:
      context: .
      dockerfile: Dockerfile.e2e
    volumes:
      - ./test-results:/app/test-results
      - ./playwright-report:/app/playwright-report
    environment:
      - CI=true
    depends_on:
      - app
  
  app:
    build: .
    ports:
      - "5173:5173"
    environment:
      - NODE_ENV=test
```

## 성능 테스트

### Core Web Vitals 측정
```typescript
// tests/e2e/performance.spec.ts
import { test, expect } from '@playwright/test';

test.describe('성능 테스트', () => {
  test('Core Web Vitals 측정', async ({ page }) => {
    await page.goto('/');
    
    // First Contentful Paint
    const fcp = await page.evaluate(() => {
      return new Promise((resolve) => {
        new PerformanceObserver((list) => {
          list.getEntries().forEach((entry) => {
            if (entry.name === 'first-contentful-paint') {
              resolve(entry.startTime);
            }
          });
        }).observe({ entryTypes: ['paint'] });
      });
    });
    
    expect(fcp).toBeLessThan(2000); // 2초 이내
    
    // Largest Contentful Paint
    const lcp = await page.evaluate(() => {
      return new Promise((resolve) => {
        new PerformanceObserver((list) => {
          const entries = list.getEntries();
          const lastEntry = entries[entries.length - 1];
          resolve(lastEntry.startTime);
        }).observe({ entryTypes: ['largest-contentful-paint'] });
      });
    });
    
    expect(lcp).toBeLessThan(2500); // 2.5초 이내
  });

  test('번들 크기 확인', async ({ page }) => {
    const response = await page.goto('/');
    const resources = await page.evaluate(() => {
      return performance.getEntriesByType('resource').map(resource => ({
        name: resource.name,
        size: resource.transferSize
      }));
    });

    const jsFiles = resources.filter(r => r.name.includes('.js'));
    const totalJsSize = jsFiles.reduce((sum, file) => sum + file.size, 0);
    
    // JavaScript 총 크기가 500KB 이하인지 확인
    expect(totalJsSize).toBeLessThan(500 * 1024);
  });
});
```

## 문제 해결

### 공통 문제점과 해결책

#### Playwright 설치 문제
```bash
# 권한 문제 해결
sudo npx playwright install-deps

# 특정 브라우저만 설치
npx playwright install chromium

# 시스템 의존성 설치
npx playwright install --with-deps
```

#### TypeScript 컴파일 오류
```typescript
// playwright.config.ts에서 TypeScript 설정 지정
export default defineConfig({
  // TypeScript 설정 파일 지정
  tsconfig: './tests/tsconfig.json',
  
  // TypeScript 오류 무시 (권장하지 않음)
  // projects: [
  //   {
  //     name: 'setup',
  //     testMatch: /.*\.setup\.ts/,
  //     use: { tsconfig: undefined }
  //   }
  // ]
});
```

#### Vite 개발 서버 연결 문제
```typescript
// playwright.config.ts
export default defineConfig({
  webServer: {
    command: 'npm run dev',
    url: 'http://localhost:5173',
    reuseExistingServer: !process.env.CI,
    // 서버 시작 대기 시간 증가
    timeout: 120 * 1000,
    // stdout 로그 표시
    stdout: 'pipe',
    stderr: 'pipe',
  },
});
```

#### 테스트 불안정성 해결
```typescript
// 더 안정적인 대기 조건 사용
await page.waitForLoadState('networkidle');
await page.waitForFunction(() => window.document.readyState === 'complete');

// 타임아웃 증가
await expect(page.getByText('로딩 완료')).toBeVisible({ timeout: 10000 });

// 재시도 로직 추가
test.describe.configure({ retries: 2 });
```

#### MSW (Mock Service Worker) 충돌
```typescript
// vite.config.ts에서 MSW 비활성화
export default defineConfig({
  define: {
    // E2E 테스트 시 MSW 비활성화
    'process.env.VITE_API_MOCK': process.env.NODE_ENV === 'test' ? '"false"' : '"true"'
  }
});
```

## 대안적 조합
- **React + TypeScript + Next.js + Playwright**: SSR/SSG 애플리케이션용
- **React + TypeScript + Webpack + Playwright**: 기존 Webpack 프로젝트용
- **React + TypeScript + Vite + Cypress**: Cypress 선호시
- **React + TypeScript + Vite + Testing Library + Playwright**: 단위 테스트와 E2E 테스트 결합

## 마이그레이션 경로

### Cypress에서 Playwright로 마이그레이션
```typescript
// Cypress 스타일
cy.visit('/login');
cy.get('[data-testid="username"]').type('user@test.com');
cy.get('[data-testid="password"]').type('password');
cy.get('[data-testid="submit"]').click();
cy.url().should('include', '/dashboard');

// Playwright 스타일로 변환
await page.goto('/login');
await page.getByTestId('username').fill('user@test.com');
await page.getByTestId('password').fill('password');
await page.getByTestId('submit').click();
await expect(page).toHaveURL(/.*dashboard/);
```

### Jest에서 Playwright로 E2E 테스트 마이그레이션
```typescript
// Jest + Puppeteer 스타일
describe('Login Flow', () => {
  it('should login successfully', async () => {
    await page.goto('/login');
    await page.type('#username', 'user@test.com');
    await page.type('#password', 'password');
    await page.click('#submit');
    await page.waitForSelector('#dashboard');
  });
});

// Playwright 스타일로 변환
test.describe('Login Flow', () => {
  test('should login successfully', async ({ page }) => {
    await page.goto('/login');
    await page.locator('#username').fill('user@test.com');
    await page.locator('#password').fill('password');
    await page.locator('#submit').click();
    await expect(page.locator('#dashboard')).toBeVisible();
  });
});
```

## 고급 기능

### 병렬 테스트 최적화
```typescript
// playwright.config.ts
export default defineConfig({
  // 완전 병렬 실행
  fullyParallel: true,
  
  // 워커 수 설정
  workers: process.env.CI ? 2 : undefined,
  
  // 테스트 분할
  shard: process.env.SHARD ? { 
    current: parseInt(process.env.SHARD_INDEX), 
    total: parseInt(process.env.SHARD_TOTAL) 
  } : undefined,
});
```

### 테스트 태그 및 애노테이션
```typescript
import { test, expect } from '@playwright/test';

test('중요한 기능 테스트', { tag: '@critical' }, async ({ page }) => {
  // 중요한 테스트 로직
});

test('느린 테스트', { tag: '@slow' }, async ({ page }) => {
  // 시간이 오래 걸리는 테스트
});

// 특정 태그만 실행: npx playwright test --grep "@critical"
// 특정 태그 제외: npx playwright test --grep-invert "@slow"
```

## 연구 메타데이터
- **연구 소스**: Context7 (Playwright 공식 문서), WebSearch (2025년 모범 사례)
- **검증 상태**: 공식 문서 및 최신 커뮤니티 사례로 검증됨
- **다음 검토**: 2025-07-20 (생성일로부터 6개월)
- **커뮤니티 자료**: 
  - [Playwright 공식 문서](https://playwright.dev/)
  - [Playwright TypeScript 가이드](https://playwright.dev/docs/test-typescript)
  - [Vite 가이드](https://vite.dev/guide/)
  - [React E2E 테스트 모범 사례](https://react.dev/learn/writing-tests)
  - [2025년 E2E 테스트 트렌드](https://dev.to/juan_deto/configure-vitest-msw-and-playwright-in-a-react-project-with-vite-and-ts-part-3-32pe)