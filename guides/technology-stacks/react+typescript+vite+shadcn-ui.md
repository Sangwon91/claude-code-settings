# React + TypeScript + Vite + shadcn/ui Development Guide

## Stack Overview
- **Technologies**: React 18/19 + TypeScript 5+ + Vite 5+ + shadcn/ui + Tailwind CSS v4
- **Use Case**: Modern UI-focused SPA Development with Component Library
- **Complexity**: Intermediate
- **Last Updated**: 2025-01-20

## Compatibility Matrix
| Technology | Version | Notes | Conflicts |
|------------|---------|-------|-----------|
| React | ^18.2.0 or ^19.0.0 | React 19 supported with canary shadcn | None |
| TypeScript | ^5.0.0 | Latest with improved type inference | None |
| Vite | ^5.0.0 | Latest with enhanced performance | None |
| shadcn/ui | @canary | Component library and CLI tool | Use canary for v4 |
| Tailwind CSS | ^4.0.0 | v4 only - simpler setup, better performance | v3 not compatible |
| @tailwindcss/vite | latest | Official Vite plugin for Tailwind v4 | Required for v4 |
| @vitejs/plugin-react | ^4.0.0 | Official React plugin for Vite | Alternative: @vitejs/plugin-react-swc |
| @types/react | ^18.2.0 or ^19.0.0 | React TypeScript definitions | Must match React version |
| @types/react-dom | ^18.2.0 or ^19.0.0 | React DOM TypeScript definitions | Must match React version |
| @types/node | latest | Node.js TypeScript definitions for path resolution | Required for Vite config |

## Quick Start Setup

### Prerequisites
- Node.js 18+ (recommended: 20+)
- npm, yarn, pnpm, or bun
- VS Code or similar TypeScript-aware editor
- Basic knowledge of React, TypeScript, and Tailwind CSS

### Installation
```bash
# Create new React + TypeScript project with Vite
npm create vite@latest my-shadcn-app -- --template react-ts
cd my-shadcn-app

# Install base dependencies
npm install

# Install Node.js types for path resolution
npm install -D @types/node

# Install Tailwind CSS v4 with Vite plugin
npm install -D tailwindcss @tailwindcss/vite

# Initialize shadcn/ui with canary version (for v4 support)
npx shadcn@canary init

# Add your first components
npx shadcn@canary add button
npx shadcn@canary add card
npx shadcn@canary add form
```

### Alternative Package Managers
```bash
# Using yarn
yarn create vite my-shadcn-app --template react-ts

# Using pnpm
pnpm create vite my-shadcn-app --template react-ts

# Using bun
bun create vite my-shadcn-app --template react-ts
```

## Configuration Files

### vite.config.ts
```typescript
import path from "path"
import react from "@vitejs/plugin-react"
import tailwindcss from "@tailwindcss/vite"
import { defineConfig } from "vite"

// https://vite.dev/config/
export default defineConfig({
  plugins: [react(), tailwindcss()],
  resolve: {
    alias: {
      "@": path.resolve(__dirname, "./src"),
    },
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

### tsconfig.json
```json
{
  "files": [],
  "references": [
    {
      "path": "./tsconfig.app.json"
    },
    {
      "path": "./tsconfig.node.json"
    }
  ],
  "compilerOptions": {
    "baseUrl": ".",
    "paths": {
      "@/*": ["./src/*"]
    }
  }
}
```

### tsconfig.app.json
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
  "include": ["src"]
}
```

### tailwind.config.js (optional for v4)
```javascript
// Tailwind v4 doesn't require this file by default
// Only create if you need custom configuration
export default {
  // Custom theme extensions if needed
  theme: {
    extend: {
      // Your custom theme
    },
  },
}
```

### components.json
```json
{
  "$schema": "https://ui.shadcn.com/schema.json",
  "style": "new-york",
  "rsc": false,
  "tsx": true,
  "tailwind": {
    "config": "tailwind.config.js",
    "css": "src/index.css",
    "baseColor": "neutral",
    "cssVariables": true,
    "prefix": ""
  },
  "aliases": {
    "components": "@/components",
    "utils": "@/lib/utils",
    "ui": "@/components/ui",
    "lib": "@/lib",
    "hooks": "@/hooks"
  },
  "iconLibrary": "lucide"
}
```

### src/index.css
```css
@import "tailwindcss";

@layer base {
  :root {
    --background: 0 0% 100%;
    --foreground: 240 10% 3.9%;
    --card: 0 0% 100%;
    --card-foreground: 240 10% 3.9%;
    --popover: 0 0% 100%;
    --popover-foreground: 240 10% 3.9%;
    --primary: 240 9% 9%;
    --primary-foreground: 0 0% 98%;
    --secondary: 240 4.8% 95.9%;
    --secondary-foreground: 240 5.9% 10%;
    --muted: 240 4.8% 95.9%;
    --muted-foreground: 240 3.8% 46.1%;
    --accent: 240 4.8% 95.9%;
    --accent-foreground: 240 5.9% 10%;
    --destructive: 0 84.2% 60.2%;
    --destructive-foreground: 0 0% 98%;
    --border: 240 5.9% 90%;
    --input: 240 5.9% 90%;
    --ring: 240 5.9% 10%;
    --chart-1: 12 76% 61%;
    --chart-2: 173 58% 39%;
    --chart-3: 197 37% 24%;
    --chart-4: 43 74% 66%;
    --chart-5: 27 87% 67%;
    --radius: 0.5rem;
  }

  .dark {
    --background: 240 10% 3.9%;
    --foreground: 0 0% 98%;
    --card: 240 10% 3.9%;
    --card-foreground: 0 0% 98%;
    --popover: 240 10% 3.9%;
    --popover-foreground: 0 0% 98%;
    --primary: 0 0% 98%;
    --primary-foreground: 240 5.9% 10%;
    --secondary: 240 3.7% 15.9%;
    --secondary-foreground: 0 0% 98%;
    --muted: 240 3.7% 15.9%;
    --muted-foreground: 240 5% 64.9%;
    --accent: 240 3.7% 15.9%;
    --accent-foreground: 0 0% 98%;
    --destructive: 0 62.8% 30.6%;
    --destructive-foreground: 0 0% 98%;
    --border: 240 3.7% 15.9%;
    --input: 240 3.7% 15.9%;
    --ring: 240 4.9% 83.9%;
    --chart-1: 220 70% 50%;
    --chart-2: 160 60% 45%;
    --chart-3: 30 80% 55%;
    --chart-4: 280 65% 60%;
    --chart-5: 340 75% 55%;
  }
}

@layer base {
  * {
    @apply border-border;
  }
  body {
    @apply bg-background text-foreground;
  }
}
```

## Integration Patterns

### React + TypeScript + shadcn/ui Integration
```typescript
// Component with shadcn/ui integration
import { Button } from "@/components/ui/button"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import { Input } from "@/components/ui/input"
import { Label } from "@/components/ui/label"
import { useState } from "react"

interface UserFormProps {
  onSubmit: (data: { name: string; email: string }) => void
  loading?: boolean
}

const UserForm: React.FC<UserFormProps> = ({ onSubmit, loading = false }) => {
  const [formData, setFormData] = useState({ name: '', email: '' })

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault()
    onSubmit(formData)
  }

  return (
    <Card className="w-full max-w-md">
      <CardHeader>
        <CardTitle>User Information</CardTitle>
        <CardDescription>Enter your details below</CardDescription>
      </CardHeader>
      <CardContent>
        <form onSubmit={handleSubmit} className="space-y-4">
          <div className="space-y-2">
            <Label htmlFor="name">Name</Label>
            <Input
              id="name"
              value={formData.name}
              onChange={(e) => setFormData(prev => ({ ...prev, name: e.target.value }))}
              required
            />
          </div>
          <div className="space-y-2">
            <Label htmlFor="email">Email</Label>
            <Input
              id="email"
              type="email"
              value={formData.email}
              onChange={(e) => setFormData(prev => ({ ...prev, email: e.target.value }))}
              required
            />
          </div>
          <Button type="submit" disabled={loading} className="w-full">
            {loading ? "Submitting..." : "Submit"}
          </Button>
        </form>
      </CardContent>
    </Card>
  )
}

export default UserForm
```

### TypeScript + Vite + shadcn/ui Utils Integration
```typescript
// lib/utils.ts - Enhanced utility functions
import { type ClassValue, clsx } from "clsx"
import { twMerge } from "tailwind-merge"

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs))
}

// Type-safe theme configuration
export type Theme = "dark" | "light" | "system"

export interface AppConfig {
  apiUrl: string
  isDev: boolean
  theme: Theme
}

export const getAppConfig = (): AppConfig => ({
  apiUrl: import.meta.env.VITE_API_URL || 'http://localhost:3001',
  isDev: import.meta.env.DEV,
  theme: (localStorage.getItem('theme') as Theme) || 'system'
})

// Type-safe asset imports
export const getAssetUrl = (path: string): string => {
  return new URL(`../assets/${path}`, import.meta.url).href
}
```

### Tailwind v4 + Vite Optimized Configuration
```typescript
// vite.config.ts - Optimized for Tailwind v4
import path from "path"
import react from "@vitejs/plugin-react"
import tailwindcss from "@tailwindcss/vite"
import { defineConfig } from "vite"

export default defineConfig({
  plugins: [
    react(),
    tailwindcss() // Tailwind v4 Vite plugin
  ],
  resolve: {
    alias: {
      "@": path.resolve(__dirname, "./src"),
    },
  },
  optimizeDeps: {
    include: [
      "@radix-ui/react-accordion",
      "@radix-ui/react-alert-dialog",
      "@radix-ui/react-dropdown-menu",
      "@radix-ui/react-dialog",
      "@radix-ui/react-select",
      "@radix-ui/react-tabs",
      "lucide-react",
      "react-hook-form",
      "@hookform/resolvers",
      "zod"
    ],
  },
  server: {
    port: 3000,
    open: true,
  },
  build: {
    outDir: 'dist',
    sourcemap: true,
    rollupOptions: {
      output: {
        manualChunks: {
          'ui-components': ['@radix-ui/react-accordion', '@radix-ui/react-alert-dialog'],
          'ui-forms': ['@radix-ui/react-select', '@radix-ui/react-dialog'],
          'icons': ['lucide-react'],
          'form-utils': ['react-hook-form', '@hookform/resolvers', 'zod'],
        },
      },
    },
  },
})
```

## Best Practices for This Combination

### Project Structure
```
src/
├── components/           # Custom components
│   ├── ui/              # shadcn/ui components (auto-generated)
│   ├── forms/           # Form components
│   ├── layout/          # Layout components
│   └── feature/         # Feature-specific components
├── hooks/               # Custom React hooks
├── lib/                 # Utility functions and configurations
│   ├── utils.ts         # shadcn/ui utility functions
│   ├── validations.ts   # Zod schemas
│   └── api.ts           # API service functions
├── types/               # TypeScript type definitions
├── providers/           # Context providers
├── assets/              # Static assets
├── styles/              # Global styles
└── App.tsx              # Main application component
```

### Development Workflow
1. **Component-First Approach**: Use shadcn/ui components as building blocks
2. **Type Safety First**: Define interfaces before implementation
3. **Composition Pattern**: Build complex UIs by composing shadcn/ui primitives
4. **CSS Variables**: Leverage Tailwind v4's CSS variables for theming
5. **Performance**: Use Vite's build optimization with proper chunking

### Tailwind v4 Specific Best Practices
```css
/* Using Tailwind v4 features */
@import "tailwindcss";

/* Custom theme with CSS variables */
@theme {
  --color-brand: #5b21b6;
  --font-display: "Inter var", sans-serif;
}

/* Component-specific styles with v4 syntax */
@layer components {
  .btn-brand {
    @apply bg-[--color-brand] text-white hover:bg-[--color-brand]/90;
  }
}
```

### Form Integration with React Hook Form + Zod
```typescript
// Form component using shadcn/ui + react-hook-form + zod
import { useForm } from "react-hook-form"
import { zodResolver } from "@hookform/resolvers/zod"
import * as z from "zod"
import { Button } from "@/components/ui/button"
import {
  Form,
  FormControl,
  FormDescription,
  FormField,
  FormItem,
  FormLabel,
  FormMessage,
} from "@/components/ui/form"
import { Input } from "@/components/ui/input"
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select"

const formSchema = z.object({
  username: z.string().min(2, "Username must be at least 2 characters"),
  email: z.string().email("Invalid email address"),
  role: z.enum(["admin", "user", "guest"]),
})

type FormData = z.infer<typeof formSchema>

interface UserFormProps {
  onSubmit: (data: FormData) => void
}

const UserForm: React.FC<UserFormProps> = ({ onSubmit }) => {
  const form = useForm<FormData>({
    resolver: zodResolver(formSchema),
    defaultValues: {
      username: "",
      email: "",
      role: "user",
    },
  })

  return (
    <Form {...form}>
      <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-8">
        <FormField
          control={form.control}
          name="username"
          render={({ field }) => (
            <FormItem>
              <FormLabel>Username</FormLabel>
              <FormControl>
                <Input placeholder="Enter username" {...field} />
              </FormControl>
              <FormDescription>
                This is your public display name.
              </FormDescription>
              <FormMessage />
            </FormItem>
          )}
        />
        <FormField
          control={form.control}
          name="email"
          render={({ field }) => (
            <FormItem>
              <FormLabel>Email</FormLabel>
              <FormControl>
                <Input type="email" placeholder="Enter email" {...field} />
              </FormControl>
              <FormMessage />
            </FormItem>
          )}
        />
        <FormField
          control={form.control}
          name="role"
          render={({ field }) => (
            <FormItem>
              <FormLabel>Role</FormLabel>
              <Select onValueChange={field.onChange} defaultValue={field.value}>
                <FormControl>
                  <SelectTrigger>
                    <SelectValue placeholder="Select a role" />
                  </SelectTrigger>
                </FormControl>
                <SelectContent>
                  <SelectItem value="admin">Admin</SelectItem>
                  <SelectItem value="user">User</SelectItem>
                  <SelectItem value="guest">Guest</SelectItem>
                </SelectContent>
              </Select>
              <FormMessage />
            </FormItem>
          )}
        />
        <Button type="submit">Submit</Button>
      </form>
    </Form>
  )
}

export default UserForm
```

## Common Patterns

### Theme Provider with Tailwind v4
```typescript
// providers/theme-provider.tsx
import { createContext, useContext, useEffect, useState } from "react"

type Theme = "dark" | "light" | "system"

type ThemeProviderProps = {
  children: React.ReactNode
  defaultTheme?: Theme
  storageKey?: string
}

type ThemeProviderState = {
  theme: Theme
  setTheme: (theme: Theme) => void
}

const initialState: ThemeProviderState = {
  theme: "system",
  setTheme: () => null,
}

const ThemeProviderContext = createContext<ThemeProviderState>(initialState)

export function ThemeProvider({
  children,
  defaultTheme = "system",
  storageKey = "vite-ui-theme",
  ...props
}: ThemeProviderProps) {
  const [theme, setTheme] = useState<Theme>(
    () => (localStorage.getItem(storageKey) as Theme) || defaultTheme
  )

  useEffect(() => {
    const root = window.document.documentElement

    root.classList.remove("light", "dark")

    if (theme === "system") {
      const systemTheme = window.matchMedia("(prefers-color-scheme: dark)")
        .matches
        ? "dark"
        : "light"

      root.classList.add(systemTheme)
      return
    }

    root.classList.add(theme)
  }, [theme])

  const value = {
    theme,
    setTheme: (theme: Theme) => {
      localStorage.setItem(storageKey, theme)
      setTheme(theme)
    },
  }

  return (
    <ThemeProviderContext.Provider {...props} value={value}>
      {children}
    </ThemeProviderContext.Provider>
  )
}

export const useTheme = () => {
  const context = useContext(ThemeProviderContext)

  if (context === undefined)
    throw new Error("useTheme must be used within a ThemeProvider")

  return context
}
```

### Data Fetching Pattern with TypeScript
```typescript
// hooks/use-api.ts
import { useState, useEffect } from 'react'
import { toast } from "sonner"

interface ApiState<T> {
  data: T | null
  loading: boolean
  error: string | null
}

interface ApiOptions {
  onSuccess?: (data: any) => void
  onError?: (error: Error) => void
  autoFetch?: boolean
}

export function useApi<T>(
  fetchFn: () => Promise<T>,
  deps: React.DependencyList = [],
  options: ApiOptions = {}
): ApiState<T> & { refetch: () => Promise<void> } {
  const { onSuccess, onError, autoFetch = true } = options
  const [state, setState] = useState<ApiState<T>>({
    data: null,
    loading: autoFetch,
    error: null,
  })

  const fetchData = async () => {
    try {
      setState(prev => ({ ...prev, loading: true, error: null }))
      const result = await fetchFn()
      
      setState({ data: result, loading: false, error: null })
      onSuccess?.(result)
    } catch (error) {
      const errorMessage = error instanceof Error ? error.message : 'Unknown error'
      setState({ data: null, loading: false, error: errorMessage })
      onError?.(error as Error)
      toast.error(errorMessage)
    }
  }

  useEffect(() => {
    if (autoFetch) {
      fetchData()
    }
  }, deps)

  return { ...state, refetch: fetchData }
}
```

### Custom Component Library Extension
```typescript
// components/ui/loading-button.tsx
import { forwardRef } from "react"
import { Button, ButtonProps } from "@/components/ui/button"
import { Loader2 } from "lucide-react"
import { cn } from "@/lib/utils"

export interface LoadingButtonProps extends ButtonProps {
  loading?: boolean
  loadingText?: string
}

const LoadingButton = forwardRef<HTMLButtonElement, LoadingButtonProps>(
  ({ children, loading = false, loadingText = "Loading...", disabled, className, ...props }, ref) => {
    return (
      <Button
        ref={ref}
        disabled={disabled || loading}
        className={cn(className)}
        {...props}
      >
        {loading && <Loader2 className="mr-2 h-4 w-4 animate-spin" />}
        {loading ? loadingText : children}
      </Button>
    )
  }
)

LoadingButton.displayName = "LoadingButton"

export { LoadingButton }
```

## Testing Strategy

### Vitest Configuration
```typescript
// vitest.config.ts
import { defineConfig } from 'vitest/config'
import react from '@vitejs/plugin-react'
import path from 'path'

export default defineConfig({
  plugins: [react()],
  resolve: {
    alias: {
      '@': path.resolve(__dirname, './src'),
    },
  },
  test: {
    globals: true,
    environment: 'jsdom',
    setupFiles: ['./src/test/setup.ts'],
    coverage: {
      provider: 'v8',
      reporter: ['text', 'json', 'html'],
    },
  },
})
```

### Component Testing
```typescript
// __tests__/components/LoadingButton.test.tsx
import { render, screen } from '@testing-library/react'
import { describe, it, expect } from 'vitest'
import { LoadingButton } from '@/components/ui/loading-button'

describe('LoadingButton', () => {
  it('renders loading state correctly', () => {
    render(<LoadingButton loading loadingText="Processing...">Submit</LoadingButton>)
    
    expect(screen.getByText('Processing...')).toBeInTheDocument()
    expect(screen.getByRole('button')).toBeDisabled()
  })

  it('renders normal state correctly', () => {
    render(<LoadingButton>Submit</LoadingButton>)
    
    expect(screen.getByText('Submit')).toBeInTheDocument()
    expect(screen.getByRole('button')).not.toBeDisabled()
  })
})
```

## Troubleshooting This Stack

### Common Integration Issues

#### Tailwind v4 Issues
- **Issue**: Styles not applying
- **Solution**: Ensure `@import "tailwindcss"` is at the top of your CSS file and `@tailwindcss/vite` plugin is configured

#### Path Resolution Errors
- **Issue**: `Cannot resolve module '@/components/ui/button'`
- **Solution**: Ensure both `tsconfig.json` and `tsconfig.app.json` have correct `baseUrl` and `paths` configuration

#### shadcn/ui CLI Issues
- **Issue**: Components not installing with v4
- **Solution**: Use `npx shadcn@canary` commands for Tailwind v4 compatibility

#### React 19 Compatibility
- **Issue**: Peer dependency warnings
- **Solution**: Use `npm install --legacy-peer-deps` when necessary

### Performance Optimization
- **Bundle Size**: Configure proper code splitting in `vite.config.ts`
- **Development Speed**: Pre-bundle heavy dependencies in `optimizeDeps`
- **Build Performance**: Use `@vitejs/plugin-react-swc` for faster builds

## Alternative Combinations
- **React + TypeScript + Next.js + shadcn/ui**: For SSR/SSG applications
- **React + TypeScript + Vite + Ark UI**: Alternative component library
- **React + TypeScript + Vite + Radix UI**: Direct Radix primitives usage
- **React + TypeScript + Remix + shadcn/ui**: Full-stack alternative

## Migration Paths

### From Tailwind v3 to v4
1. Update dependencies: `npm install tailwindcss@latest @tailwindcss/vite`
2. Replace PostCSS config with Vite plugin
3. Update CSS: Change `@tailwind` directives to `@import "tailwindcss"`
4. Remove `tailwind.config.js` unless custom config needed
5. Update any deprecated utilities

### From Other UI Libraries
1. Install shadcn/ui: `npx shadcn@canary init`
2. Gradually replace components with shadcn/ui equivalents
3. Migrate styling to Tailwind utility classes
4. Update theme system to CSS variables

## React 19 Specific Configuration

### Installation
```bash
# Install React 19
npm install react@19 react-dom@19 --legacy-peer-deps

# Update types
npm install -D @types/react@19 @types/react-dom@19

# Use canary shadcn
npx shadcn@canary init
```

### Updated Dependencies
```json
{
  "dependencies": {
    "react": "^19.0.0",
    "react-dom": "^19.0.0",
    "react-hook-form": "^7.48.0",
    "@hookform/resolvers": "^3.3.0",
    "zod": "^3.22.0",
    "sonner": "^1.3.0",
    "lucide-react": "^0.300.0"
  },
  "devDependencies": {
    "@types/react": "^19.0.0",
    "@types/react-dom": "^19.0.0",
    "tailwindcss": "^4.0.0",
    "@tailwindcss/vite": "^4.0.0"
  }
}
```

## Advanced Tailwind v4 Features

### Custom Theme Configuration
```css
/* Using Tailwind v4's new theme system */
@import "tailwindcss";

@theme {
  --color-primary: #8b5cf6;
  --color-secondary: #ec4899;
  
  --font-sans: "Inter var", system-ui, sans-serif;
  --font-mono: "JetBrains Mono", monospace;
  
  --spacing-gap: 2rem;
  --radius-card: 0.75rem;
}

/* Using custom properties in components */
.card-gradient {
  background: linear-gradient(135deg, var(--color-primary), var(--color-secondary));
  border-radius: var(--radius-card);
  gap: var(--spacing-gap);
}
```

### Container Queries with v4
```css
/* Tailwind v4 container queries */
@layer components {
  .responsive-card {
    @container (min-width: 400px) {
      @apply grid-cols-2;
    }
    
    @container (min-width: 768px) {
      @apply grid-cols-3;
    }
  }
}
```

## Production Deployment

### Build Optimization
```typescript
// vite.config.ts - Production optimizations
export default defineConfig({
  build: {
    target: 'esnext',
    minify: 'terser',
    terserOptions: {
      compress: {
        drop_console: true,
        drop_debugger: true,
      },
    },
    rollupOptions: {
      output: {
        manualChunks: (id) => {
          if (id.includes('node_modules')) {
            if (id.includes('@radix-ui')) return 'radix-ui';
            if (id.includes('react')) return 'react-vendor';
            if (id.includes('lucide')) return 'icons';
          }
        },
      },
    },
  },
})
```

## Research Metadata
- **Research Sources**: Context7 (shadcn/ui official docs), WebSearch (2025 Tailwind v4 integration)
- **Validation Status**: Verified with official documentation and latest releases
- **Next Review**: 2025-07-20 (6 months from creation)
- **Community Resources**: 
  - [shadcn/ui Documentation](https://ui.shadcn.com/)
  - [Tailwind CSS v4 Documentation](https://tailwindcss.com/blog/tailwindcss-v4)
  - [Vite Guide](https://vite.dev/guide/)
  - [React TypeScript Cheatsheet](https://react-typescript-cheatsheet.netlify.app/)
  - [Radix UI Documentation](https://www.radix-ui.com/)