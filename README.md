# Claude Code Settings Repository

이 레포지토리는 Claude Code를 위한 체계적이고 재사용 가능한 설정 관리 시스템입니다. 개발 가이드라인, 기술 스택별 베스트 프랙티스, 그리고 자동화된 연구 도구를 통해 AI 기반 개발의 품질과 일관성을 향상시킵니다.

## 🚀 Quick Start

### 1. 레포지토리 클론 및 글로벌 설정

```bash
# 1. 레포지토리 클론
git clone https://github.com/your-username/claude-code-settings.git
cd claude-code-settings

# 2. 심볼릭 링크로 글로벌 Claude Code 설정 연결
ln -sf "$(pwd)" ~/.claude

# 3. 설정 적용 확인
claude --version
```

이제 모든 프로젝트에서 이 레포지토리의 설정이 자동으로 적용됩니다.

### 2. 새 프로젝트에서 기술 스택 설정

```bash
# 1. 새 프로젝트 디렉토리로 이동
cd /path/to/your/new/project

# 2. 기존 스택 자동 감지 (기존 프로젝트인 경우)
/setup:detect-stack

# 3. 기술 스택 연구 및 가이드 생성
/research:tech-stack react+typescript+vite

# 4. 프로젝트별 CLAUDE.md에 자동 연결
# (research 명령어가 자동으로 수행)
```

## 📁 프로젝트 구조

```
claude-code-settings/
├── CLAUDE.md                          # 메인 설정 파일
├── README.md                          # 이 파일
├── commands/                          # 커스텀 명령어 정의
│   ├── research/
│   │   └── tech-stack.md             # 기술 스택 연구 명령어
│   └── setup/
│       └── detect-stack.md           # 스택 자동 감지 명령어
├── guides/                           # 개발 가이드라인
│   ├── core-principles/              # 핵심 개발 원칙
│   │   ├── task-decomposition.md     # 작업 분해 전략
│   │   ├── verification-protocol.md  # 검증 프로토콜
│   │   ├── self-documenting-code.md  # 자기 문서화 코드
│   │   ├── git-workflow.md           # Git 워크플로우
│   │   └── performance-optimization.md # 성능 최적화
│   ├── development-practices/        # 개발 실무 방법
│   │   ├── env-local.md              # 로컬 환경 설정
│   │   ├── testing-strategy.md       # 테스팅 전략
│   │   └── tech-stack-command-guide.md # 기술 스택 명령어 가이드
│   ├── technology-stacks/            # 기술 스택별 가이드
│   │   ├── react+typescript+vite.md
│   │   └── react+typescript+vite+shadcn-ui.md
│   └── workflows/
│       └── development-cycle.md      # 완전한 개발 사이클
└── [메타데이터 폴더들]               # Claude Code 자동 생성
    ├── ide/                          # IDE 통합 설정
    ├── projects/                     # 프로젝트별 대화 기록
    ├── shell-snapshots/              # 셸 명령어 스냅샷
    ├── statsig/                      # 통계 데이터
    └── todos/                        # 작업 추적 데이터
```

## 🔧 핵심 기능

### 1. 자동화된 기술 스택 연구 (`/research:tech-stack`)

가장 강력한 기능으로, 기술 스택을 자동으로 연구하고 구조화된 가이드를 생성합니다.

#### 기본 사용법
```bash
# 단일 기술 연구
/research:tech-stack react

# 기술 조합 연구 (순서 무관)
/research:tech-stack react+typescript+vite
/research:tech-stack typescript+vite+react  # 동일한 결과

# 복잡한 풀스택 조합
/research:tech-stack nextjs+typescript+tailwindcss+shadcn-ui+prisma
```

#### 지능형 정규화 시스템
- **자동 정렬**: 기술들이 의미론적 중요도에 따라 자동 정렬
- **별칭 해결**: `next` → `nextjs`, `ts` → `typescript` 등 자동 변환
- **일관성 보장**: 같은 조합은 항상 동일한 파일명으로 생성

#### 생성되는 가이드 내용
- **호환성 매트릭스**: 버전 호환성 및 충돌 정보
- **빠른 시작 가이드**: 설치부터 실행까지
- **통합 패턴**: 기술들 간의 실제 통합 방법
- **베스트 프랙티스**: 해당 조합에 특화된 권장사항
- **문제 해결**: 일반적인 이슈와 해결책

### 2. 스택 자동 감지 (`/setup:detect-stack`)

기존 프로젝트의 기술 스택을 자동으로 감지하고 CLAUDE.md에 연결합니다.

```bash
# 프로젝트 루트에서 실행
/setup:detect-stack

# package.json, requirements.txt 등을 분석하여
# 사용 중인 기술 스택을 자동으로 감지하고
# 해당하는 기술 스택 가이드를 CLAUDE.md에 자동 추가
```

### 3. 점진적 개선 워크플로우

#### Step 1: 초기 설정
```bash
# 1. 새 프로젝트 생성 또는 기존 프로젝트로 이동
cd my-new-project

# 2. Claude Code 초기화
claude init

# 3. 기본 기술 스택 연구
/research:tech-stack react+typescript+vite
```

#### Step 2: 기능 추가 시마다 확장
```bash
# 상태 관리 라이브러리 추가 고려 시
/research:tech-stack react+typescript+vite+zustand
/research:tech-stack react+typescript+vite+redux

# UI 라이브러리 추가 고려 시
/research:tech-stack react+typescript+vite+shadcn-ui
/research:tech-stack react+typescript+vite+mui

# 각 가이드를 비교하여 최적의 선택 결정
```

#### Step 3: 선택한 스택으로 가이드 업데이트
```bash
# 최종 선택한 스택으로 종합 가이드 생성
/research:tech-stack react+typescript+vite+zustand+shadcn-ui

# 프로젝트 CLAUDE.md에 자동으로 해당 가이드 연결됨
```

## 🎯 주요 장점

### 1. **일관성 있는 개발 환경**
- 모든 프로젝트에서 동일한 코딩 원칙과 베스트 프랙티스 적용
- 팀 멤버 간 코드 품질 표준화

### 2. **자동화된 기술 연구**
- 수동으로 문서를 찾아볼 필요 없이 최신 정보 자동 수집
- 기술 조합별 실제 통합 방법과 문제 해결책 제공

### 3. **점진적 학습과 개선**
- 프로젝트가 성장함에 따라 기술 스택도 점진적으로 확장
- 각 단계에서 최적의 선택을 위한 비교 자료 제공

### 4. **시간 절약**
- 프로젝트 초기 설정 시간 대폭 단축
- 기술 스택 선택과 설정에 대한 의사결정 지원

## 🔄 고급 활용 방안

### 1. 팀 표준화
```bash
# 팀의 표준 스택들을 미리 연구해두기
/research:tech-stack nextjs+typescript+tailwindcss+shadcn-ui+prisma  # Frontend
/research:tech-stack express+typescript+postgresql+redis             # Backend
/research:tech-stack jest+playwright                                 # Testing

# 새 팀원 온보딩 시 해당 가이드들 즉시 활용
```

### 2. 기술 스택 마이그레이션
```bash
# 현재 스택
/research:tech-stack react+javascript+webpack

# 목표 스택
/research:tech-stack react+typescript+vite

# 두 가이드를 비교하여 마이그레이션 계획 수립
```

### 3. 성능 최적화 연구
```bash
# 성능에 초점을 맞춘 연구
/research:tech-stack react+typescript+vite focus on performance optimization and bundle size

# 특정 요구사항에 맞춘 연구
/research:tech-stack nextjs+prisma --template=fullstack include deployment strategies and scalability considerations
```

### 4. 컨텍스트 기반 학습
```bash
# 특정 컨텍스트에서의 라이브러리 사용법 연구
/research:tech-stack zustand --context=react+typescript
/research:tech-stack prisma --context=nextjs+typescript

# 생성된 가이드는 해당 컨텍스트에 특화된 사용법 포함
```

## 🛠️ 커스터마이징

### 1. 새로운 기술 스택 추가
`commands/research/tech-stack.md`에서 정규화 규칙을 수정하여 새로운 기술들을 추가할 수 있습니다.

### 2. 커스텀 가이드라인 추가
`guides/` 디렉토리에 프로젝트 특화 가이드라인을 추가할 수 있습니다.

### 3. 팀별 설정 확장
이 레포지토리를 포크하여 팀만의 설정과 가이드라인을 추가하세요.

## 🤝 기여하기

1. 이 레포지토리를 포크합니다
2. 새로운 기능이나 개선사항을 개발합니다
3. Pull Request를 생성합니다

### 기여 아이디어
- 새로운 기술 스택 가이드 추가
- 기존 가이드의 최신 정보 업데이트
- 새로운 자동화 명령어 개발
- 문서화 개선

## 📝 라이선스

MIT License - 자유롭게 사용, 수정, 배포하세요.

## 🔗 관련 링크

- [Claude Code 공식 문서](https://docs.anthropic.com/en/docs/claude-code)
- [Claude Code GitHub](https://github.com/anthropics/claude-code)

---

**이 설정을 통해 AI 기반 개발의 품질과 효율성을 극대화하세요! 🚀**