// ============================================
// Theme Check: TypeScript
// ============================================
// - Types / Interfaces / Enums
// - Classes with generics
// - Namespace / Modules
// - Decorators and Annotations
// - Built-in types (string, number, boolean)
// - Type assertions / Type guards

// --- Interfaces ---
interface User {
  id: number;
  name: string;
  email: string;
  isActive: boolean;
}

interface Repository<T> {
  findById(id: number): Promise<T | null>;
  findAll(): Promise<T[]>;
  save(entity: T): Promise<void>;
  delete(id: number): Promise<boolean>;
}

// --- Type aliases ---
type StringOrNumber = string | number;
type Callback<T> = (data: T) => void;
type ReadonlyUser = Readonly<User>;

// --- Enums ---
enum Direction {
  Up = "UP",
  Down = "DOWN",
  Left = "LEFT",
  Right = "RIGHT",
}

const enum Color {
  Red = 0xff0000,
  Green = 0x00ff00,
  Blue = 0x0000ff,
}

// --- Namespace ---
namespace Validation {
  export interface Validator {
    validate(value: string): boolean;
  }

  export class EmailValidator implements Validator {
    validate(value: string): boolean {
      return /^[\w.-]+@[\w.-]+\.\w+$/.test(value);
    }
  }
}

// --- Decorators ---
function sealed(constructor: Function) {
  Object.seal(constructor);
  Object.seal(constructor.prototype);
}

function log(target: any, key: string, descriptor: PropertyDescriptor) {
  const original = descriptor.value;
  descriptor.value = function (...args: any[]) {
    console.log(`Calling ${key} with`, args);
    return original.apply(this, args);
  };
}

// --- Class with generics, decorators ---
@sealed
class UserService implements Repository<User> {
  private users: Map<number, User> = new Map();

  @log
  async findById(id: number): Promise<User | null> {
    return this.users.get(id) ?? null;
  }

  async findAll(): Promise<User[]> {
    return Array.from(this.users.values());
  }

  async save(user: User): Promise<void> {
    this.users.set(user.id, user);
  }

  async delete(id: number): Promise<boolean> {
    return this.users.delete(id);
  }
}

// --- Type guards ---
function isUser(obj: unknown): obj is User {
  return (
    typeof obj === "object" &&
    obj !== null &&
    "id" in obj &&
    "name" in obj
  );
}

// --- Generics ---
function identity<T>(arg: T): T {
  return arg;
}

// --- Mapped types ---
type Optional<T> = {
  [K in keyof T]?: T[K];
};

// --- Module import/export ---
// import type { User } from './types';
// export type { Repository };
// export { UserService, Direction };
