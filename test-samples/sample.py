# ============================================
# Theme Check: Python
# ============================================
# - Keywords / Functions / Classes
# - Decorators (@decorator)
# - Comments (single line, docstring)
# - Built-in Variables (__name__)
# - Language Variables (self, cls)
# - Operators / Numbers / Strings
# - Type hints
# - List/Dict comprehensions
# - Exception handling
# - f-strings

import os
from typing import List, Dict, Optional, TypeVar, Generic
from dataclasses import dataclass, field
from functools import wraps

# --- Constants ---
MAX_RETRIES = 3
PI = 3.14159
HEX_VALUE = 0xFF
BINARY = 0b1010
GREETING = "Hello, World!"

# --- Decorator ---
def retry(max_attempts: int = 3):
    def decorator(func):
        @wraps(func)
        def wrapper(*args, **kwargs):
            for attempt in range(max_attempts):
                try:
                    return func(*args, **kwargs)
                except Exception as e:
                    if attempt == max_attempts - 1:
                        raise
                    print(f"Retry {attempt + 1}/{max_attempts}: {e}")
        return wrapper
    return decorator


# --- Dataclass ---
@dataclass
class User:
    """Represents a user in the system."""
    id: int
    name: str
    email: str
    is_active: bool = True
    tags: List[str] = field(default_factory=list)

    def __post_init__(self):
        self.email = self.email.lower()

    @property
    def display_name(self) -> str:
        return f"{self.name} <{self.email}>"

    @classmethod
    def from_dict(cls, data: Dict[str, any]) -> "User":
        return cls(**data)

    @staticmethod
    def validate_email(email: str) -> bool:
        return "@" in email and "." in email


# --- Generic class ---
T = TypeVar("T")

class Repository(Generic[T]):
    def __init__(self):
        self._items: Dict[int, T] = {}

    def add(self, id: int, item: T) -> None:
        self._items[id] = item

    def get(self, id: int) -> Optional[T]:
        return self._items.get(id, None)

    def all(self) -> List[T]:
        return list(self._items.values())

    def __len__(self) -> int:
        return len(self._items)

    def __repr__(self) -> str:
        return f"Repository({len(self)} items)"


# --- Async ---
async def fetch_users(url: str) -> List[User]:
    """Fetch users from API."""
    pass


# --- Comprehensions ---
squares = [x ** 2 for x in range(10)]
even_squares = [x ** 2 for x in range(10) if x % 2 == 0]
user_map = {u.id: u for u in []}
unique = {x for x in [1, 2, 2, 3, 3]}

# --- String types ---
raw_string = r"no \n escape here"
byte_string = b"bytes"
multiline = """
This is a
multiline string
"""
f_string = f"Result: {42 * 2} and {GREETING!r}"

# --- Exception handling ---
try:
    value = int("not a number")
except ValueError as e:
    print(f"Error: {e}")
except (TypeError, KeyError):
    print("Type or Key error")
else:
    print("Success")
finally:
    print("Cleanup")

# --- Match statement (Python 3.10+) ---
def handle_command(command: str) -> str:
    match command:
        case "quit" | "exit":
            return "Goodbye"
        case "help":
            return "Available commands: quit, help, status"
        case str(s) if s.startswith("echo "):
            return s[5:]
        case _:
            return f"Unknown: {command}"

# --- Lambda & built-ins ---
transform = lambda x: x * 2 + 1
numbers = list(map(transform, range(5)))
filtered = list(filter(lambda x: x > 5, numbers))

# --- Main guard ---
if __name__ == "__main__":
    user = User(1, "Alice", "Alice@Example.com")
    print(user.display_name)
    print(isinstance(user, User))
    print(type(user).__name__)
