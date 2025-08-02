# FastAPI + UV Development Guide

## Stack Overview
- **Technologies**: FastAPI 0.115+ + UV 0.8+
- **Use Case**: Modern Python API Development with Superior Package Management
- **Complexity**: Beginner to Intermediate
- **Last Updated**: 2025-01-20

## Compatibility Matrix
| Technology | Version | Notes | Conflicts |
|------------|---------|-------|-----------|
| FastAPI | ^0.115.0 | Latest stable with modern features | None |
| UV | ^0.8.0 | Extremely fast Python package manager | Replaces pip/poetry |
| Python | ^3.12 | Recommended for latest features | 3.8+ supported |
| Uvicorn | ^0.32.0 | ASGI server (included with fastapi[standard]) | None |
| Pydantic | ^2.10.0 | Data validation (FastAPI dependency) | V1 deprecated |

## Quick Start Setup

### Prerequisites
- Python 3.8+ (recommended: 3.12+)
- Basic understanding of APIs and Python type hints
- Terminal/Command line access

### Installation

#### Install UV
```bash
# macOS/Linux
curl -LsSf https://astral.sh/uv/install.sh | sh

# Windows
powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.sh | iex"

# Verify installation
uv --version
```

#### Create New FastAPI Project
```bash
# Initialize new project
uv init my-fastapi-app
cd my-fastapi-app

# Install FastAPI with standard dependencies
uv add "fastapi[standard]"

# Add development dependencies
uv add --dev pytest black ruff mypy httpx
```

### Project Structure
```
my-fastapi-app/
├── pyproject.toml          # Project metadata and dependencies
├── uv.lock                 # Locked dependency versions
├── README.md
├── .python-version         # Python version pin
├── app/
│   ├── __init__.py
│   ├── main.py            # FastAPI application
│   ├── models/            # Pydantic models
│   │   ├── __init__.py
│   │   └── user.py
│   ├── routers/           # API endpoints
│   │   ├── __init__.py
│   │   ├── users.py
│   │   └── items.py
│   ├── dependencies.py    # Dependency injection
│   └── config.py          # Configuration
├── tests/
│   ├── __init__.py
│   ├── test_main.py
│   └── test_users.py
└── docker/
    ├── Dockerfile
    └── docker-compose.yml
```

## Configuration Files

### pyproject.toml
```toml
[project]
name = "my-fastapi-app"
version = "0.1.0"
description = "FastAPI application with UV package management"
readme = "README.md"
requires-python = ">=3.12"
authors = [
    { name = "Your Name", email = "your.email@example.com" }
]
dependencies = [
    "fastapi[standard]>=0.115.0",
    "pydantic>=2.10.0",
    "pydantic-settings>=2.7.0",
]

[dependency-groups]
dev = [
    "pytest>=8.3.0",
    "httpx>=0.28.0",
    "black>=24.0.0",
    "ruff>=0.8.0",
    "mypy>=1.13.0",
]
test = [
    "pytest-asyncio>=0.24.0",
    "pytest-cov>=6.0.0",
]
docs = [
    "mkdocs>=1.6.0",
    "mkdocs-material>=9.5.0",
]

[project.scripts]
dev = "app.main:dev"
start = "app.main:start"

[build-system]
requires = ["hatchling"]
build-backend = "hatchling.build"

[tool.uv]
dev-dependencies = [
    "pre-commit>=4.0.0",
]

[tool.ruff]
target-version = "py312"
line-length = 88
select = ["E", "W", "F", "I", "B", "C4", "UP"]
ignore = ["E501", "B008", "C901"]

[tool.ruff.per-file-ignores]
"__init__.py" = ["F401"]

[tool.black]
line-length = 88
target-version = ['py312']

[tool.mypy]
python_version = "3.12"
warn_return_any = true
warn_unused_configs = true
disallow_untyped_defs = true

[tool.pytest.ini_options]
minversion = "6.0"
addopts = "-ra -q --cov=app"
testpaths = ["tests"]
asyncio_mode = "auto"
```

### .python-version
```
3.12
```

## Integration Patterns

### FastAPI + UV Project Management Integration
```python
# app/main.py
from typing import List
from fastapi import FastAPI, Depends, HTTPException, status
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
import uvicorn

from app.config import settings
from app.routers import users, items
from app.dependencies import get_current_user

app = FastAPI(
    title=settings.app_name,
    description="FastAPI application with UV package management",
    version="0.1.0",
    docs_url="/docs",
    redoc_url="/redoc",
)

# CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=settings.allowed_hosts,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Include routers
app.include_router(users.router, prefix="/api/v1")
app.include_router(items.router, prefix="/api/v1")

@app.get("/")
async def root():
    return {"message": "FastAPI + UV Application", "version": "0.1.0"}

@app.get("/health")
async def health_check():
    return {"status": "healthy", "package_manager": "uv"}

def dev():
    """Development server entry point"""
    uvicorn.run(
        "app.main:app",
        host="127.0.0.1",
        port=8000,
        reload=True,
        log_level="debug"
    )

def start():
    """Production server entry point"""
    uvicorn.run(
        "app.main:app",
        host="0.0.0.0",
        port=8000,
        log_level="info"
    )

if __name__ == "__main__":
    dev()
```

### UV + FastAPI Configuration Management
```python
# app/config.py
from typing import List
from pydantic_settings import BaseSettings, SettingsConfigDict

class Settings(BaseSettings):
    model_config = SettingsConfigDict(
        env_file=".env",
        env_file_encoding="utf-8",
        case_sensitive=False
    )
    
    # Application settings
    app_name: str = "FastAPI + UV App"
    debug: bool = False
    version: str = "0.1.0"
    
    # Server settings
    host: str = "127.0.0.1"
    port: int = 8000
    allowed_hosts: List[str] = ["*"]
    
    # Database settings
    database_url: str = "sqlite:///./app.db"
    
    # Security settings
    secret_key: str = "your-secret-key-here"
    algorithm: str = "HS256"
    access_token_expire_minutes: int = 30

settings = Settings()
```

### UV Development Workflow Integration
```python
# app/dependencies.py
from typing import Annotated
from fastapi import Depends, HTTPException, status
from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials
from pydantic import BaseModel

security = HTTPBearer()

class User(BaseModel):
    id: int
    username: str
    email: str

async def get_current_user(
    credentials: Annotated[HTTPAuthorizationCredentials, Depends(security)]
) -> User:
    """
    Dependency to get current authenticated user
    Used throughout the FastAPI application
    """
    # Implement your authentication logic here
    # This is a simplified example
    if credentials.credentials == "valid-token":
        return User(id=1, username="testuser", email="test@example.com")
    
    raise HTTPException(
        status_code=status.HTTP_401_UNAUTHORIZED,
        detail="Invalid authentication credentials",
        headers={"WWW-Authenticate": "Bearer"},
    )

async def get_admin_user(
    current_user: Annotated[User, Depends(get_current_user)]
) -> User:
    """
    Dependency for admin-only endpoints
    """
    # Add admin check logic here
    if current_user.username != "admin":
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Not enough permissions"
        )
    return current_user
```

## Best Practices for This Combination

### Development Workflow
1. **UV-First Development**: Use UV for all package management operations
2. **Lock File Management**: Always commit `uv.lock` for reproducible environments
3. **Dependency Groups**: Organize dependencies by purpose (dev, test, docs)
4. **Python Version Pinning**: Use `.python-version` for consistent environments
5. **Fast Iteration**: Leverage UV's speed for rapid dependency changes

### Project Organization
```python
# app/routers/users.py
from typing import List, Annotated
from fastapi import APIRouter, Depends, HTTPException, status
from pydantic import BaseModel

from app.dependencies import get_current_user, User

router = APIRouter(prefix="/users", tags=["users"])

class UserCreate(BaseModel):
    username: str
    email: str
    password: str

class UserResponse(BaseModel):
    id: int
    username: str
    email: str

@router.get("/me", response_model=UserResponse)
async def read_users_me(
    current_user: Annotated[User, Depends(get_current_user)]
):
    """Get current user information"""
    return current_user

@router.get("/", response_model=List[UserResponse])
async def read_users(
    current_user: Annotated[User, Depends(get_current_user)],
    skip: int = 0,
    limit: int = 100
):
    """Get list of users"""
    # Implement user retrieval logic
    return []

@router.post("/", response_model=UserResponse, status_code=status.HTTP_201_CREATED)
async def create_user(user: UserCreate):
    """Create new user"""
    # Implement user creation logic
    return UserResponse(id=1, username=user.username, email=user.email)
```

### UV Package Management Best Practices
```bash
# Development workflow commands

# Start development with hot reload
uv run fastapi dev app/main.py

# Run tests
uv run pytest

# Run linting and formatting
uv run ruff check .
uv run black .
uv run mypy .

# Add new dependencies
uv add requests httpx
uv add --dev pytest-mock

# Update dependencies
uv sync --upgrade

# Export for deployment
uv export --format requirements-txt > requirements.txt
```

## Common Patterns

### API Testing Pattern
```python
# tests/test_main.py
import pytest
from httpx import AsyncClient, ASGITransport
from app.main import app

@pytest.fixture
async def client():
    """Test client fixture"""
    async with AsyncClient(
        transport=ASGITransport(app=app),
        base_url="http://test"
    ) as ac:
        yield ac

@pytest.mark.asyncio
async def test_root_endpoint(client: AsyncClient):
    """Test root endpoint returns correct message"""
    response = await client.get("/")
    assert response.status_code == 200
    assert response.json() == {
        "message": "FastAPI + UV Application",
        "version": "0.1.0"
    }

@pytest.mark.asyncio
async def test_health_check(client: AsyncClient):
    """Test health check endpoint"""
    response = await client.get("/health")
    assert response.status_code == 200
    data = response.json()
    assert data["status"] == "healthy"
    assert data["package_manager"] == "uv"

@pytest.mark.asyncio
async def test_users_endpoint_requires_auth(client: AsyncClient):
    """Test that users endpoint requires authentication"""
    response = await client.get("/api/v1/users/me")
    assert response.status_code == 403  # No auth header
```

### Database Integration Pattern
```python
# app/models/user.py
from typing import Optional
from pydantic import BaseModel, EmailStr, ConfigDict

class UserBase(BaseModel):
    username: str
    email: EmailStr

class UserCreate(UserBase):
    password: str

class UserUpdate(BaseModel):
    username: Optional[str] = None
    email: Optional[EmailStr] = None
    password: Optional[str] = None

class UserInDB(UserBase):
    model_config = ConfigDict(from_attributes=True)
    
    id: int
    is_active: bool = True
    hashed_password: str

class User(UserBase):
    model_config = ConfigDict(from_attributes=True)
    
    id: int
    is_active: bool = True
```

### Async Background Tasks Pattern
```python
# app/routers/items.py
from typing import List
from fastapi import APIRouter, BackgroundTasks, Depends
from pydantic import BaseModel

from app.dependencies import get_current_user, User

router = APIRouter(prefix="/items", tags=["items"])

class ItemCreate(BaseModel):
    name: str
    description: str
    price: float

class Item(BaseModel):
    id: int
    name: str
    description: str
    price: float
    owner_id: int

def send_notification(email: str, message: str):
    """Background task to send notifications"""
    # Implement notification logic
    print(f"Sending notification to {email}: {message}")

@router.post("/", response_model=Item)
async def create_item(
    item: ItemCreate,
    background_tasks: BackgroundTasks,
    current_user: User = Depends(get_current_user)
):
    """Create new item with background notification"""
    # Create item logic here
    new_item = Item(
        id=1,
        name=item.name,
        description=item.description,
        price=item.price,
        owner_id=current_user.id
    )
    
    # Add background task
    background_tasks.add_task(
        send_notification,
        current_user.email,
        f"Item '{item.name}' created successfully"
    )
    
    return new_item
```

## Docker Integration

### Dockerfile
```dockerfile
FROM python:3.12-slim

# Install UV
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

# Set working directory
WORKDIR /app

# Copy dependency files
COPY pyproject.toml uv.lock ./

# Install dependencies
RUN uv sync --frozen --no-cache --no-dev

# Copy application code
COPY . .

# Create non-root user
RUN useradd --create-home --shell /bin/bash app
USER app

# Expose port
EXPOSE 8000

# Health check
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:8000/health || exit 1

# Run application
CMD ["/app/.venv/bin/uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
```

### Docker Compose
```yaml
# docker/docker-compose.yml
version: '3.8'

services:
  api:
    build: .
    ports:
      - "8000:8000"
    environment:
      - DEBUG=false
      - DATABASE_URL=postgresql://user:password@db:5432/myapp
    depends_on:
      - db
      - redis
    volumes:
      - ./logs:/app/logs
    networks:
      - app-network

  db:
    image: postgres:16
    environment:
      - POSTGRES_DB=myapp
      - POSTGRES_USER=user
      - POSTGRES_PASSWORD=password
    volumes:
      - postgres_data:/var/lib/postgresql/data
    networks:
      - app-network

  redis:
    image: redis:7-alpine
    networks:
      - app-network

volumes:
  postgres_data:

networks:
  app-network:
    driver: bridge
```

## Performance Optimization

### UV Performance Benefits
```bash
# UV vs traditional pip performance comparison

# Traditional pip workflow (slow)
python -m venv venv
source venv/bin/activate  # or venv\Scripts\activate on Windows
pip install -r requirements.txt
# Time: 30-60 seconds for moderate dependencies

# UV workflow (fast)
uv sync
# Time: 2-5 seconds for same dependencies

# Installing new packages
pip install fastapi uvicorn  # 10-20 seconds
uv add fastapi uvicorn       # 1-3 seconds
```

### FastAPI Performance Configuration
```python
# app/main.py - Production optimizations
import asyncio
from contextlib import asynccontextmanager
from fastapi import FastAPI
from fastapi.middleware.gzip import GZipMiddleware
from fastapi.middleware.trustedhost import TrustedHostMiddleware
import uvicorn

@asynccontextmanager
async def lifespan(app: FastAPI):
    # Startup
    print("Starting up...")
    # Initialize resources, database connections, etc.
    yield
    # Shutdown
    print("Shutting down...")
    # Cleanup resources

app = FastAPI(
    lifespan=lifespan,
    title="FastAPI + UV App",
    docs_url="/docs" if settings.debug else None,  # Disable docs in production
    redoc_url="/redoc" if settings.debug else None,
)

# Add performance middleware
app.add_middleware(GZipMiddleware, minimum_size=1000)
app.add_middleware(
    TrustedHostMiddleware,
    allowed_hosts=settings.allowed_hosts
)

# Optimize uvicorn settings for production
if __name__ == "__main__":
    uvicorn.run(
        "app.main:app",
        host="0.0.0.0",
        port=8000,
        workers=4,  # Number of worker processes
        access_log=False,  # Disable access logs for performance
        use_colors=False,  # Disable colors in production
    )
```

## Testing Strategy

### Test Configuration
```python
# tests/conftest.py
import pytest
import asyncio
from httpx import AsyncClient, ASGITransport
from app.main import app
from app.config import settings

@pytest.fixture(scope="session")
def event_loop():
    """Create an instance of the default event loop for the test session."""
    loop = asyncio.get_event_loop_policy().new_event_loop()
    yield loop
    loop.close()

@pytest.fixture
async def client():
    """Test client with test database"""
    async with AsyncClient(
        transport=ASGITransport(app=app),
        base_url="http://test"
    ) as ac:
        yield ac

@pytest.fixture
def auth_headers():
    """Authentication headers for testing"""
    return {"Authorization": "Bearer valid-token"}
```

### Running Tests
```bash
# Run all tests
uv run pytest

# Run tests with coverage
uv run pytest --cov=app --cov-report=html

# Run specific test file
uv run pytest tests/test_users.py

# Run tests with markers
uv run pytest -m "not slow"

# Run tests in parallel
uv add --dev pytest-xdist
uv run pytest -n auto
```

## Troubleshooting This Stack

### Common UV Issues

#### UV Installation Problems
- **Issue**: UV command not found after installation
- **Solution**: Ensure UV is in your PATH or restart terminal
```bash
# Check UV installation
which uv
uv --version

# Reinstall if needed
curl -LsSf https://astral.sh/uv/install.sh | sh
```

#### Dependency Resolution Conflicts
- **Issue**: UV cannot resolve dependency conflicts
- **Solution**: Check dependency constraints and use override if needed
```bash
# Debug dependency resolution
uv sync --verbose

# Override specific versions
uv add "package-name==1.2.3" --override
```

#### Lock File Issues
- **Issue**: `uv.lock` conflicts or corruption
- **Solution**: Regenerate lock file
```bash
# Remove lock file and regenerate
rm uv.lock
uv sync
```

### Common FastAPI Issues

#### Import Errors
- **Issue**: ModuleNotFoundError when running FastAPI app
- **Solution**: Ensure proper PYTHONPATH and project structure
```bash
# Run from project root
uv run python -m app.main

# Or use the defined script
uv run dev
```

#### Async/Await Issues
- **Issue**: RuntimeWarning about async functions
- **Solution**: Properly handle async endpoints and dependencies
```python
# Correct async endpoint
@app.get("/async-endpoint")
async def async_endpoint():
    result = await some_async_function()
    return result

# Sync endpoint (no async needed)
@app.get("/sync-endpoint")
def sync_endpoint():
    return {"message": "sync response"}
```

### Version Conflicts
- **FastAPI 0.11x vs 0.10x**: Update all FastAPI-related packages together
- **Pydantic V1 vs V2**: Use Pydantic V2 for FastAPI 0.100+
- **Python 3.8 vs 3.12**: Some features require newer Python versions

### Performance Issues
- **Slow startup**: Check for synchronous operations in startup events
- **Memory usage**: Monitor async connection pools and background tasks
- **Package installation**: Use UV's caching for faster rebuilds

## Alternative Combinations
- **FastAPI + Poetry**: Traditional Python package management
- **FastAPI + pip + virtualenv**: Classic Python development approach
- **FastAPI + PDM**: Another modern Python package manager
- **Django + UV**: Full-featured framework with UV package management
- **Flask + UV**: Lightweight web framework with UV

## Migration Paths

### From pip to UV
```bash
# Export current pip dependencies
pip freeze > requirements.txt

# Initialize UV project
uv init .

# Import dependencies
uv add $(cat requirements.txt | sed 's/==.*//')

# Clean up
rm requirements.txt
```

### From Poetry to UV
```bash
# Export poetry dependencies
poetry export --without-hashes -f requirements.txt > requirements.txt

# Initialize UV project
uv init .

# Import dependencies
uv add $(cat requirements.txt | sed 's/==.*//')

# Migrate scripts and metadata from pyproject.toml manually
```

### To Docker Production
```bash
# Build optimized Docker image
docker build -t my-fastapi-app .

# Run with proper production settings
docker run -p 8000:8000 \
  -e DEBUG=false \
  -e DATABASE_URL=postgresql://... \
  my-fastapi-app
```

## Advanced Configuration

### Pre-commit Hooks
```yaml
# .pre-commit-config.yaml
repos:
  - repo: https://github.com/astral-sh/ruff-pre-commit
    rev: v0.8.2
    hooks:
      - id: ruff
        args: [--fix]
      - id: ruff-format

  - repo: https://github.com/pre-commit/mirrors-mypy
    rev: v1.13.0
    hooks:
      - id: mypy
        additional_dependencies: [types-all]
```

### GitHub Actions CI/CD
```yaml
# .github/workflows/test.yml
name: Test

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        python-version: ["3.10", "3.11", "3.12"]

    steps:
    - uses: actions/checkout@v4

    - name: Install uv
      uses: astral-sh/setup-uv@v6

    - name: Set up Python ${{ matrix.python-version }}
      run: uv python install ${{ matrix.python-version }}

    - name: Install dependencies
      run: uv sync --all-extras --dev

    - name: Run tests
      run: uv run pytest --cov=app --cov-report=xml

    - name: Upload coverage
      uses: codecov/codecov-action@v3
```

## Production Deployment

### Environment Variables
```bash
# .env.production
DEBUG=false
SECRET_KEY=your-production-secret-key
DATABASE_URL=postgresql://user:password@db:5432/myapp
ALLOWED_HOSTS=["yourdomain.com", "api.yourdomain.com"]
```

### Kubernetes Deployment
```yaml
# k8s/deployment.yml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: fastapi-app
spec:
  replicas: 3
  selector:
    matchLabels:
      app: fastapi-app
  template:
    metadata:
      labels:
        app: fastapi-app
    spec:
      containers:
      - name: fastapi-app
        image: my-fastapi-app:latest
        ports:
        - containerPort: 8000
        env:
        - name: DATABASE_URL
          valueFrom:
            secretKeyRef:
              name: app-secrets
              key: database-url
        livenessProbe:
          httpGet:
            path: /health
            port: 8000
          initialDelaySeconds: 30
          periodSeconds: 10
```

## Research Metadata
- **Research Sources**: Context7 (FastAPI, UV official docs), WebSearch (2025 best practices and integration guides)
- **Validation Status**: Verified with official documentation and community practices
- **Next Review**: 2025-07-20 (6 months from creation)
- **Community Resources**: 
  - [FastAPI Documentation](https://fastapi.tiangolo.com/)
  - [UV Documentation](https://docs.astral.sh/uv/)
  - [FastAPI + UV Integration Guide](https://docs.astral.sh/uv/guides/integration/fastapi/)
  - [Python Type Hints Guide](https://docs.python.org/3/library/typing.html)
  - [Pydantic Documentation](https://docs.pydantic.dev/)