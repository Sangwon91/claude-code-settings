# uv + pytest Development Guide

## Stack Overview
- **Technologies**: uv (Python Package Manager) + pytest (Testing Framework)
- **Use Case**: Modern Python Testing with Fast Package Management
- **Complexity**: Beginner to Intermediate
- **Last Updated**: 2025-01-20

## Compatibility Matrix
| Technology | Version | Notes | Conflicts |
|------------|---------|-------|-----------|
| uv | ^0.8.0+ | Latest with automatic Python installation to PATH | None |
| pytest | ^8.0.0+ | Leading Python testing framework | None |
| Python | ^3.8+ | Both tools support modern Python versions | Recommend 3.11+ |
| pyproject.toml | Standard | Modern Python project configuration | None |

## Quick Start Setup

### Prerequisites
- Python 3.8+ (recommended: 3.11+)
- Basic knowledge of Python testing concepts

### Installation

#### Method 1: Using uv 0.8.0+ (Recommended)
```bash
# Install uv (if not already installed)
curl -LsSf https://astral.sh/uv/install.sh | sh

# Install Python (uv 0.8.0+ automatically adds to PATH)
uv python install 3.12

# Create new project with uv
uv init my-test-project
cd my-test-project

# Add pytest as a development dependency
uv add --dev pytest

# Create virtual environment and sync dependencies
uv sync
```

#### Method 2: Existing Project Migration
```bash
# If you have an existing project
cd existing-project

# Initialize uv project (preserves existing files)
uv init --no-readme .

# Add pytest and common testing tools
uv add --dev pytest pytest-cov pytest-mock

# Sync environment
uv sync
```

### Project Initialization with uv 0.8.0 + pytest

```bash
# Initialize project with uv's new build backend (0.8.0 feature)
uv init --package my-project
cd my-project

# Add pytest and testing ecosystem
uv add --dev pytest pytest-cov pytest-mock pytest-xdist

# Add application dependencies
uv add requests click

# Create test structure
mkdir tests
touch tests/__init__.py
touch tests/test_main.py
```

## Configuration Files

### pyproject.toml (uv 0.8.0 with new build backend)
```toml
[project]
name = "my-project"
version = "0.1.0"
description = "My Python project with uv 0.8.0 and pytest"
readme = "README.md"
requires-python = ">=3.8"
dependencies = [
    "requests>=2.31.0",
    "click>=8.1.0",
]

[project.optional-dependencies]
dev = [
    "pytest>=8.0.0",
    "pytest-cov>=4.1.0",
    "pytest-mock>=3.12.0",
    "pytest-xdist>=3.5.0",
    "ruff>=0.1.0",
]

# uv 0.8.0+ uses its own build backend by default for new projects
[build-system]
requires = ["uv>=0.8.0"]
build-backend = "uv"

[tool.pytest.ini_options]
minversion = "8.0"
addopts = [
    "-ra",
    "--strict-markers",
    "--strict-config",
    "--cov=src",
    "--cov-report=term-missing",
    "--cov-report=html",
    "-n", "auto",  # Parallel testing with pytest-xdist
]
testpaths = ["tests"]
python_files = ["test_*.py"]
python_classes = ["Test*"]
python_functions = ["test_*"]
markers = [
    "slow: marks tests as slow (deselect with '-m \"not slow\"')",
    "integration: marks tests as integration tests",
    "unit: marks tests as unit tests",
]

[tool.coverage.run]
source = ["src"]
parallel = true
omit = [
    "*/tests/*",
    "*/test_*.py",
]

[tool.coverage.report]
exclude_lines = [
    "pragma: no cover",
    "def __repr__",
    "raise AssertionError",
    "raise NotImplementedError",
]
```

### uv.lock Benefits (uv 0.8.0+)
```bash
# uv 0.8.0 improves lockfile generation and resolution
uv lock  # Creates reproducible uv.lock file

# Fast, deterministic installs from lockfile
uv sync  # Uses uv.lock for exact versions

# Update specific packages
uv lock --upgrade-package pytest

# Check for outdated packages
uv tree --outdated
```

## Integration Patterns

### uv 0.8.0 Python Management + pytest
```python
# tests/test_python_version.py
import sys
import subprocess


def test_python_version_management():
    """Test that we're using uv-managed Python."""
    result = subprocess.run([
        "uv", "python", "list", "--only-installed"
    ], capture_output=True, text=True)
    
    assert result.returncode == 0
    assert "python" in result.stdout.lower()


def test_python_in_path():
    """Test that uv 0.8.0 Python is available in PATH."""
    # uv 0.8.0+ automatically adds Python to PATH
    result = subprocess.run([
        "python3.12", "--version"
    ], capture_output=True, text=True)
    
    assert result.returncode == 0
    assert "Python 3.12" in result.stdout
```

### Fast Test Environment Setup with uv 0.8.0
```bash
# uv 0.8.0 performance improvements
time uv sync  # Much faster dependency resolution

# Parallel test execution (leveraging uv's speed)
uv run pytest -n auto

# Test with specific Python version (0.8.0 feature)
uv run --python 3.12 pytest

# Run tests with coverage in parallel
uv run pytest --cov=src --cov-report=html -n auto
```

## Best Practices for uv 0.8.0 + pytest

### 1. Python Version Management (New in 0.8.0)
```bash
# Install and automatically add Python to PATH
uv python install 3.11 3.12 3.13

# Check installed Python versions
uv python list

# Pin Python version for project
uv python pin 3.12

# Remove global Python pin (requires --global flag in 0.8.0+)
uv python pin --rm --global
```

### 2. Enhanced Dependency Management
```bash
# Add dependencies with uv 0.8.0 improved resolution
uv add requests  # Production dependency
uv add --dev pytest pytest-asyncio  # Development dependencies

# Lock dependencies for reproducible builds
uv lock

# Sync with exact versions from lockfile
uv sync --frozen

# Update specific packages
uv lock --upgrade-package pytest
```

### 3. Project Structure (uv 0.8.0 build backend)
```
my-project/
├── src/
│   └── my_project/
│       ├── __init__.py
│       ├── main.py
│       └── utils.py
├── tests/
│   ├── __init__.py
│   ├── conftest.py
│   ├── unit/
│   │   ├── test_main.py
│   │   └── test_utils.py
│   ├── integration/
│   │   └── test_api.py
│   └── fixtures/
│       └── sample_data.py
├── pyproject.toml     # With uv build backend
├── uv.lock           # Lockfile for reproducible builds
├── README.md
└── .gitignore
```

## Advanced Testing Patterns

### 1. Async Testing with pytest-asyncio
```python
# tests/test_async.py
import pytest
import asyncio
from my_project.async_client import AsyncAPIClient


@pytest.mark.asyncio
async def test_async_api_call():
    """Test asynchronous API calls."""
    client = AsyncAPIClient()
    
    result = await client.fetch_data("test-endpoint")
    
    assert result is not None
    assert "data" in result


@pytest.fixture(scope="session")
def event_loop():
    """Create event loop for async tests."""
    loop = asyncio.new_event_loop()
    yield loop
    loop.close()
```

### 2. Parallel Testing Configuration
```python
# conftest.py
import pytest
from pytest_xdist import is_xdist_worker


@pytest.fixture(scope="session")
def shared_resource():
    """Shared resource that works with parallel testing."""
    if is_xdist_worker():
        # Different setup for parallel workers
        return create_worker_resource()
    else:
        # Setup for single-process testing
        return create_main_resource()


def pytest_configure(config):
    """Configure parallel testing markers."""
    config.addinivalue_line(
        "markers", 
        "parallel_safe: mark test as safe to run in parallel"
    )
```

### 3. Performance Testing Integration
```python
# tests/test_performance.py
import pytest
import time
from my_project.performance import heavy_computation


@pytest.mark.slow
@pytest.mark.parametrize("data_size", [100, 1000, 10000])
def test_performance_scaling(data_size):
    """Test performance scaling with different data sizes."""
    start_time = time.perf_counter()
    
    result = heavy_computation(size=data_size)
    
    execution_time = time.perf_counter() - start_time
    
    # Performance should scale linearly
    expected_max_time = data_size * 0.001  # 1ms per item
    assert execution_time < expected_max_time
    assert result is not None


# Run performance tests separately
# uv run pytest -m slow --durations=10
```

## Testing Strategy with uv 0.8.0

### Multi-Python Testing
```bash
# Test across multiple Python versions (uv 0.8.0 feature)
uv python install 3.9 3.10 3.11 3.12

# Create test matrix
for version in 3.9 3.10 3.11 3.12; do
    echo "Testing with Python $version"
    uv run --python $version pytest
done
```

### CI/CD Integration (GitHub Actions)
```yaml
# .github/workflows/test.yml
name: Test with uv 0.8.0

on: [push, pull_request]

jobs:
  test:
    runs-on: ${{ matrix.os }}
    strategy:
      matrix:
        os: [ubuntu-latest, windows-latest, macos-latest]
        python-version: ["3.9", "3.10", "3.11", "3.12"]
    
    steps:
    - uses: actions/checkout@v4
    
    - name: Install uv
      uses: astral-sh/setup-uv@v3
      with:
        version: "0.8.0"
        enable-cache: true
    
    - name: Set up Python ${{ matrix.python-version }}
      run: uv python install ${{ matrix.python-version }}
    
    - name: Install dependencies
      run: uv sync --all-extras --dev
    
    - name: Run tests
      run: uv run pytest --cov=src --cov-report=xml -n auto
    
    - name: Upload coverage
      uses: codecov/codecov-action@v3
      with:
        file: ./coverage.xml
```

## Common Patterns and Recipes

### 1. Test Data Factories
```python
# tests/factories.py
import pytest
from dataclasses import dataclass
from datetime import datetime, timezone
from typing import Dict, Any, List


@dataclass
class TestDataFactory:
    """Factory for creating consistent test data."""
    
    @staticmethod
    def user(name: str = "Test User", email: str = None) -> Dict[str, Any]:
        email = email or f"{name.lower().replace(' ', '')}@test.com"
        return {
            "id": hash(name) % 10000,
            "name": name,
            "email": email,
            "created_at": datetime.now(timezone.utc).isoformat(),
            "active": True
        }
    
    @staticmethod
    def users_batch(count: int = 5) -> List[Dict[str, Any]]:
        return [
            TestDataFactory.user(f"User {i}")
            for i in range(1, count + 1)
        ]


# Usage in tests
def test_user_creation():
    user_data = TestDataFactory.user("John Doe")
    user = create_user(user_data)
    assert user.name == "John Doe"
```

### 2. Database Testing with Transactions
```python
# tests/test_database.py
import pytest
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from my_project.database import Base, User


@pytest.fixture(scope="session")
def test_engine():
    """Create test database engine."""
    engine = create_engine("sqlite:///:memory:")
    Base.metadata.create_all(engine)
    return engine


@pytest.fixture
def db_session(test_engine):
    """Create database session with transaction rollback."""
    Session = sessionmaker(bind=test_engine)
    session = Session()
    
    # Start transaction
    transaction = session.begin()
    
    yield session
    
    # Rollback transaction (clean state for next test)
    transaction.rollback()
    session.close()


class TestUserModel:
    """Test user database operations."""
    
    def test_create_user(self, db_session):
        """Test user creation."""
        user = User(name="Test User", email="test@example.com")
        db_session.add(user)
        db_session.commit()
        
        assert user.id is not None
        assert user.name == "Test User"
    
    def test_user_query(self, db_session):
        """Test user querying."""
        # Create test user
        user = User(name="Query Test", email="query@test.com")
        db_session.add(user)
        db_session.commit()
        
        # Query user
        found_user = db_session.query(User).filter_by(
            email="query@test.com"
        ).first()
        
        assert found_user is not None
        assert found_user.name == "Query Test"
```

## Troubleshooting uv 0.8.0 + pytest

### Common Issues and Solutions

#### Python Path Issues (0.8.0 specific)
```bash
# Issue: Python not found in PATH after installation
# Solution: Verify uv 0.8.0 PATH installation
uv python list --only-installed

# Check if Python is in PATH
which python3.12

# Manual PATH setup if needed
export PATH="$HOME/.local/bin:$PATH"

# Windows: Check if Python is registered (0.8.0 feature)
py -0  # Should list uv-installed Python versions
```

#### Build System Issues (0.8.0 changes)
```bash
# Issue: Build failures with path dependencies
# Solution: uv 0.8.0 now builds path dependencies by default

# Check if build system is properly configured
uv build --dry-run

# Force specific build backend if needed
[build-system]
requires = ["hatchling"]  # Instead of uv build backend
build-backend = "hatchling.build"
```

#### Test Discovery Problems
```bash
# Issue: pytest not finding tests
# Verify test discovery with verbose output
uv run pytest --collect-only -v

# Check pytest configuration
uv run pytest --help | grep testpaths

# Verify project structure matches pytest expectations
tree tests/  # Should show test_*.py files
```

#### Performance Issues
```bash
# Issue: Slow test execution
# Solution: Leverage uv 0.8.0 speed improvements

# Use parallel testing
uv run pytest -n auto

# Profile test execution
uv run pytest --durations=10

# Check dependency resolution time
time uv sync
```

#### Dependency Conflicts
```bash
# Issue: Conflicting package versions
# Use uv's enhanced conflict resolution

# Check dependency tree
uv tree

# Resolve conflicts with overrides
[tool.uv]
override-dependencies = [
    "requests==2.31.0",
]

# Lock with conflict resolution
uv lock --resolution highest
```

## Performance Optimization

### uv 0.8.0 Speed Features
```bash
# Fast environment setup
time uv sync  # Should be 10-100x faster than pip

# Parallel operations
uv run pytest -n auto  # Parallel test execution

# Cache optimization
uv cache info  # Check cache status
uv cache clean  # Clean cache if needed

# Concurrent dependency resolution
uv add --dev pytest pytest-cov  # Resolves dependencies concurrently
```

### Test Performance Best Practices
```python
# Use session-scoped fixtures for expensive setup
@pytest.fixture(scope="session")
def expensive_setup():
    """Setup that runs once per test session."""
    setup_data = perform_expensive_operation()
    return setup_data

# Parameterize tests efficiently
@pytest.mark.parametrize("input_data,expected", [
    ({"name": "test1"}, "result1"),
    ({"name": "test2"}, "result2"),
], ids=["case1", "case2"])
def test_with_parameters(input_data, expected):
    result = process_data(input_data)
    assert result == expected

# Use markers to skip expensive tests during development
@pytest.mark.slow
def test_full_integration():
    # Expensive test that can be skipped with -m "not slow"
    pass
```

## Migration Guide

### From poetry + pytest to uv 0.8.0 + pytest
```bash
# 1. Install uv 0.8.0
curl -LsSf https://astral.sh/uv/install.sh | sh

# 2. Backup existing configuration
cp pyproject.toml pyproject.toml.backup

# 3. Initialize with uv (preserves most settings)
uv init --no-readme .

# 4. Migrate dependencies
uv sync  # uv can read poetry dependencies from pyproject.toml

# 5. Update build system (optional)
# Change from poetry-core to uv build backend in pyproject.toml

# 6. Test migration
uv run pytest
```

### From pip + pytest to uv 0.8.0 + pytest
```bash
# 1. Install uv
curl -LsSf https://astral.sh/uv/install.sh | sh

# 2. Create pyproject.toml from requirements
uv init .
uv add $(cat requirements.txt)
uv add --dev $(cat requirements-dev.txt)

# 3. Migrate pytest configuration
# Move pytest.ini settings to [tool.pytest.ini_options] in pyproject.toml

# 4. Test the setup
uv sync
uv run pytest
```

## Research Metadata
- **Research Sources**: Context7 (uv and pytest official docs), WebSearch (uv 0.8.0 release notes), GitHub releases
- **Validation Status**: Verified with uv 0.8.0 official release notes and pytest 8.x documentation
- **Next Review**: 2025-07-20 (6 months from creation)
- **Community Resources**: 
  - [uv 0.8.0 Release Notes](https://github.com/astral-sh/uv/releases/tag/0.8.0)
  - [uv Documentation](https://docs.astral.sh/uv/)
  - [pytest Documentation](https://docs.pytest.org/)
  - [Python Testing Guide](https://realpython.com/pytest-python-testing/)
  - [uv vs Poetry Comparison](https://blog.astral.sh/uv-unified-python-packaging/)