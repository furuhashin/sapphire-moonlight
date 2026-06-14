// ============================================
// Theme Check: JavaScript
// ============================================
// - Keywords (if, const, let, function, class, return)
// - Functions (declaration, call)
// - Variables / Variable Parameters
// - Language Variables (this)
// - Strings / Escape Characters / Template literals
// - Regular Expressions
// - Numbers / Constants (true, false, null)
// - Operators (+, -, ===, =>, ??)
// - Punctuation ((), {}, [], ;)
// - Block Level Variables
// - JS methods, constructor, ES7 bind

// --- Comments (single line) ---
/* Block comment */

// --- Keywords & Constants ---
const MAX_COUNT = 100;
let isActive = true;
var legacy = false;
const nothing = null;
const missing = undefined;

// --- Function declaration & parameters ---
function greet(name, age) {
  return `Hello, ${name}! You are ${age} years old.\n`;
}

// --- Arrow function & operators ---
const add = (a, b) => a + b;
const result = add(10, 20);
const check = result === 30 ? "yes" : "no";
const fallback = nothing ?? "default";

// --- Class, constructor, this ---
class Animal {
  constructor(name, sound) {
    this.name = name;
    this.sound = sound;
  }

  speak() {
    return `${this.name} says ${this.sound}`;
  }

  static create(name) {
    return new Animal(name, "...");
  }
}

// --- Regular expressions ---
const pattern = /^hello\s+world$/gi;
const email = /[\w.-]+@[\w.-]+\.\w+/;

// --- Numbers ---
const integer = 42;
const float = 3.14;
const hex = 0xff;
const binary = 0b1010;
const octal = 0o777;

// --- String escape characters ---
const escaped = "line1\nline2\ttab\\backslash";
const single = 'single quotes';
const template = `template ${integer + float}`;

// --- Destructuring & spread ---
const { name: animalName, ...rest } = { name: "Cat", sound: "Meow", legs: 4 };
const [first, second, ...others] = [1, 2, 3, 4, 5];

// --- Block level variables ---
if (isActive) {
  let blockVar = "inside block";
  const blockConst = 42;
  console.log(blockVar, blockConst);
}

// --- Async/Await ---
async function fetchData(url) {
  try {
    const response = await fetch(url);
    const data = await response.json();
    return data;
  } catch (error) {
    throw new Error(`Failed: ${error.message}`);
  } finally {
    console.log("done");
  }
}

// --- Switch/Case ---
switch (check) {
  case "yes":
    console.log("correct");
    break;
  case "no":
    console.log("wrong");
    break;
  default:
    console.log("unknown");
}

// --- Import/Export ---
// import { useState } from 'react';
// export default Animal;
// export { greet, add };
