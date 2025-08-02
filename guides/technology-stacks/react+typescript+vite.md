# React + TypeScript + Vite Development Guide

## Stack Overview
- **Technologies**: React 18+ + TypeScript 5+ + Vite 5+
- **Use Case**: Modern SPA (Single Page Application) Development
- **Complexity**: Beginner to Intermediate
- **Last Updated**: 2025-01-20

## Compatibility Matrix
| Technology | Version | Notes | Conflicts |
|------------|---------|-------|-----------|
| React | ^18.2.0 | Latest stable with Concurrent Features | None |
| TypeScript | ^5.0.0 | Latest with improved type inference | None |
| Vite | ^5.0.0 | Latest with enhanced performance | None |
| @vitejs/plugin-react | ^4.0.0 | Official React plugin for Vite | Alternative: @vitejs/plugin-react-swc |
| @types/react | ^18.2.0 | React TypeScript definitions | Must match React version |
| @types/react-dom | ^18.2.0 | React DOM TypeScript definitions | Must match React version |

## Quick Start Setup

### Prerequisites
- Node.js 18+ (recommended: 20+)
- npm, yarn, pnpm, or bun
- VS Code or similar TypeScript-aware editor

### Installation
```bash
# Create new project
npm create vite@latest my-react-app -- --template react-ts
cd my-react-app

# Install dependencies
npm install

# Start development server
npm run dev
```

### Alternative Package Managers
```bash
# Using yarn
yarn create vite my-react-app --template react-ts

# Using pnpm
pnpm create vite my-react-app --template react-ts

# Using bun
bun create vite my-react-app --template react-ts
```

### Project Initialization
```bash
# Install additional type definitions if needed
npm install --save-dev @types/node

# Optional: Install ESLint and Prettier
npm install --save-dev eslint @typescript-eslint/parser @typescript-eslint/eslint-plugin
npm install --save-dev prettier eslint-config-prettier eslint-plugin-prettier
```

### Configuration Files

#### vite.config.ts
```typescript
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig({
  plugins: [react()],
  resolve: {
    alias: {
      '@': '/src',
    },
  },
  esbuild: {
    jsxInject: `import React from 'react'`,
  },
  server: {
    port: 3000,
    open: true,
  },
  build: {
    outDir: 'dist',
    sourcemap: true,
  },
})
```

#### tsconfig.json
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
      "@/*": ["./src/*"]
    }
  },
  "include": ["src"],
  "references": [{ "path": "./tsconfig.node.json" }]
}
```

#### tsconfig.node.json
```json
{
  "compilerOptions": {
    "composite": true,
    "skipLibCheck": true,
    "module": "ESNext",
    "moduleResolution": "bundler",
    "allowSyntheticDefaultImports": true
  },
  "include": ["vite.config.ts"]
}
```

#### vite-env.d.ts
```typescript
/// <reference types="vite/client" />

interface ImportMetaEnv {
  readonly VITE_APP_TITLE: string
  readonly VITE_API_URL: string
  // Add more custom env variables here
}

interface ImportMeta {
  readonly env: ImportMetaEnv
}
```

## Integration Patterns

### React + TypeScript Integration
```typescript
// Component with TypeScript interface
interface ButtonProps {
  children: React.ReactNode
  onClick: () => void
  variant?: 'primary' | 'secondary'
  disabled?: boolean
}

const Button: React.FC<ButtonProps> = ({ 
  children, 
  onClick, 
  variant = 'primary',
  disabled = false 
}) => {
  return (
    <button 
      className={`btn btn-${variant}`}
      onClick={onClick}
      disabled={disabled}
    >
      {children}
    </button>
  )
}

export default Button
```

### TypeScript + Vite Integration
```typescript
// Type-safe environment variables
const API_URL = import.meta.env.VITE_API_URL
const isDev = import.meta.env.DEV
const isProd = import.meta.env.PROD

// Type-safe asset imports
import logoUrl from '@/assets/logo.svg'
import styles from '@/styles/component.module.css'

// Dynamic imports with proper typing
const LazyComponent = React.lazy(() => import('@/components/LazyComponent'))
```

### Vite + React Integration
```typescript
// HMR (Hot Module Replacement) API
if (import.meta.hot) {
  import.meta.hot.accept()
}

// Environment-specific configuration
const config = {
  apiUrl: import.meta.env.VITE_API_URL || 'http://localhost:3001',
  enableDevtools: import.meta.env.DEV,
}
```

## Best Practices for This Combination

### Project Structure
```
src/
├── components/           # Reusable UI components
│   ├── ui/              # Basic UI elements
│   └── common/          # Shared components
├── pages/               # Route components
├── hooks/               # Custom React hooks
├── utils/               # Utility functions
├── types/               # TypeScript type definitions
├── services/            # API calls and external services
├── stores/              # State management
├── assets/              # Static assets
├── styles/              # CSS/SCSS files
└── tests/               # Test files
```

### Development Workflow
1. **Type-First Development**: Define TypeScript interfaces before implementation
2. **Component-Driven**: Build components in isolation with proper typing
3. **Hot Reloading**: Leverage Vite's instant HMR for rapid development
4. **Static Analysis**: Use TypeScript compiler for early error detection

### TypeScript Best Practices
```typescript
// Use proper typing for React hooks
const [count, setCount] = useState<number>(0)
const [user, setUser] = useState<User | null>(null)

// Type custom hooks properly
function useLocalStorage<T>(key: string, initialValue: T) {
  const [storedValue, setStoredValue] = useState<T>(() => {
    try {
      const item = window.localStorage.getItem(key)
      return item ? JSON.parse(item) : initialValue
    } catch (error) {
      return initialValue
    }
  })

  const setValue = (value: T | ((val: T) => T)) => {
    try {
      const valueToStore = value instanceof Function ? value(storedValue) : value
      setStoredValue(valueToStore)
      window.localStorage.setItem(key, JSON.stringify(valueToStore))
    } catch (error) {
      console.error(error)
    }
  }

  return [storedValue, setValue] as const
}
```

### Performance Optimization
```typescript
// Use React.memo with proper typing
const ExpensiveComponent = React.memo<{ data: ComplexData }>(({ data }) => {
  return <div>{/* Complex rendering logic */}</div>
})

// Use useCallback and useMemo effectively
const memoizedCallback = useCallback(
  (id: string) => {
    doSomething(id)
  },
  [dependency]
)

const memoizedValue = useMemo(() => {
  return expensiveCalculation(props.items)
}, [props.items])
```

## Common Patterns

### API Integration Pattern
```typescript
// types/api.ts
interface ApiResponse<T> {
  data: T
  message: string
  success: boolean
}

interface User {
  id: string
  name: string
  email: string
}

// services/api.ts
class ApiService {
  private baseUrl = import.meta.env.VITE_API_URL

  async get<T>(endpoint: string): Promise<ApiResponse<T>> {
    const response = await fetch(`${this.baseUrl}${endpoint}`)
    return response.json()
  }

  async post<T>(endpoint: string, data: unknown): Promise<ApiResponse<T>> {
    const response = await fetch(`${this.baseUrl}${endpoint}`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(data),
    })
    return response.json()
  }
}

export const apiService = new ApiService()

// hooks/useUsers.ts
function useUsers() {
  const [users, setUsers] = useState<User[]>([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)

  useEffect(() => {
    const fetchUsers = async () => {
      try {
        const response = await apiService.get<User[]>('/users')
        setUsers(response.data)
      } catch (err) {
        setError(err instanceof Error ? err.message : 'Unknown error')
      } finally {
        setLoading(false)
      }
    }

    fetchUsers()
  }, [])

  return { users, loading, error }
}
```

### State Management Pattern
```typescript
// stores/useAppStore.ts (using Zustand as example)
interface AppState {
  theme: 'light' | 'dark'
  user: User | null
  toggleTheme: () => void
  setUser: (user: User | null) => void
}

const useAppStore = create<AppState>((set) => ({
  theme: 'light',
  user: null,
  toggleTheme: () => set((state) => ({ 
    theme: state.theme === 'light' ? 'dark' : 'light' 
  })),
  setUser: (user) => set({ user }),
}))
```

## Testing Strategy

### Vitest Configuration
```typescript
// vitest.config.ts
import { defineConfig } from 'vitest/config'
import react from '@vitejs/plugin-react'

export default defineConfig({
  plugins: [react()],
  test: {
    globals: true,
    environment: 'jsdom',
    setupFiles: ['./src/test/setup.ts'],
  },
})
```

### Testing Examples
```typescript
// Component test
import { render, screen, fireEvent } from '@testing-library/react'
import { describe, it, expect, vi } from 'vitest'
import Button from './Button'

describe('Button', () => {
  it('renders correctly', () => {
    const handleClick = vi.fn()
    render(<Button onClick={handleClick}>Click me</Button>)
    
    expect(screen.getByRole('button')).toBeInTheDocument()
    expect(screen.getByText('Click me')).toBeInTheDocument()
  })

  it('calls onClick when clicked', () => {
    const handleClick = vi.fn()
    render(<Button onClick={handleClick}>Click me</Button>)
    
    fireEvent.click(screen.getByRole('button'))
    expect(handleClick).toHaveBeenCalledTimes(1)
  })
})
```

## Troubleshooting This Stack

### Common Integration Issues

#### TypeScript Errors
- **TS2307: Cannot find module 'react'**: Install `@types/react` and `@types/react-dom`
- **TS18003: No inputs were found**: Add files to `tsconfig.json` include array
- **TS2322: Type errors with props**: Define proper interfaces for component props

#### Vite Issues
- **Module not found**: Check import paths and aliases in `vite.config.ts`
- **HMR not working**: Ensure React plugin is properly configured
- **Build failures**: Check for dynamic imports and ensure proper TypeScript configuration

#### React + TypeScript Issues
- **JSX element implicitly has type 'any'**: Configure `jsx` in `tsconfig.json`
- **Cannot use JSX without React**: Add `jsxInject` to Vite config or import React

### Version Conflicts
- **React 17 vs 18**: Update all React-related packages together
- **TypeScript 4 vs 5**: Update `@types/*` packages to match TypeScript version
- **Vite 4 vs 5**: Check plugin compatibility and update accordingly

### Performance Issues
- **Slow development server**: Enable `esbuild` optimizations in Vite config
- **Large bundle size**: Configure code splitting and tree shaking
- **Memory usage**: Adjust TypeScript memory settings or use `skipLibCheck`

## Alternative Combinations
- **React + TypeScript + Webpack**: Traditional but slower setup
- **React + TypeScript + Parcel**: Good alternative with zero config
- **React + TypeScript + Next.js**: For full-stack applications with SSR
- **React + TypeScript + SWC**: For even faster builds (use `@vitejs/plugin-react-swc`)

## Migration Paths

### From Create React App
1. Install Vite and plugins: `npm install vite @vitejs/plugin-react`
2. Create `vite.config.ts` configuration
3. Update `package.json` scripts
4. Move `index.html` to root and update paths
5. Update imports to use explicit extensions where needed

### From Webpack
1. Replace webpack config with `vite.config.ts`
2. Update build scripts in `package.json`
3. Migrate environment variables to `VITE_` prefix
4. Update asset handling to use Vite's conventions

### To Next.js
1. Install Next.js: `npm install next react react-dom`
2. Create `pages/` directory
3. Update TypeScript config for Next.js
4. Migrate components to Next.js conventions
5. Update routing to use Next.js router

## Advanced Configuration

### ESLint Integration
```javascript
// eslint.config.js
import tseslint from '@typescript-eslint/eslint-plugin'
import reactHooks from 'eslint-plugin-react-hooks'
import reactRefresh from 'eslint-plugin-react-refresh'

export default tseslint.config([
  {
    files: ['**/*.{ts,tsx}'],
    extends: [
      ...tseslint.configs.recommendedTypeChecked,
      ...tseslint.configs.stylisticTypeChecked,
    ],
    languageOptions: {
      parserOptions: {
        project: ['./tsconfig.node.json', './tsconfig.app.json'],
        tsconfigRootDir: import.meta.dirname,
      },
    },
    plugins: {
      'react-hooks': reactHooks,
      'react-refresh': reactRefresh,
    },
    rules: {
      ...reactHooks.configs.recommended.rules,
      'react-refresh/only-export-components': [
        'warn',
        { allowConstantExport: true },
      ],
    },
  },
])
```

### Prettier Configuration
```json
{
  "semi": false,
  "trailingComma": "es5",
  "singleQuote": true,
  "printWidth": 100,
  "tabWidth": 2,
  "useTabs": false
}
```

## Research Metadata
- **Research Sources**: Context7 (React, TypeScript, Vite official docs), WebSearch (2025 best practices)
- **Validation Status**: Verified with official documentation and community practices
- **Next Review**: 2025-07-20 (6 months from creation)
- **Community Resources**: 
  - [Vite Guide](https://vite.dev/guide/)
  - [React TypeScript Cheatsheet](https://react-typescript-cheatsheet.netlify.app/)
  - [TypeScript Handbook](https://www.typescriptlang.org/docs/)