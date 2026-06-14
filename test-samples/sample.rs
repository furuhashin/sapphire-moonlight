// ============================================
// Theme Check: Rust
// ============================================
// - Keywords: fn, let, struct, enum, trait, impl, pub, mut
// - Lifetimes ('a) and generics <T>
// - Attributes (#[derive(...)]) and macros (println!)
// - Pattern matching
// - Traits and implementations
// - Result / Option / error handling

use std::collections::HashMap;
use std::fmt;

// --- Constants ---
const MAX_RETRIES: u32 = 3;
const PI: f64 = 3.14159;
static GREETING: &str = "Hello, World!";

// --- Struct with derive attributes ---
#[derive(Debug, Clone, PartialEq)]
struct User {
    id: u64,
    name: String,
    email: String,
    is_active: bool,
}

// --- Enum ---
#[derive(Debug)]
enum Shape {
    Circle(f64),
    Rectangle { width: f64, height: f64 },
    Triangle(f64, f64, f64),
}

// --- Trait ---
trait Area {
    fn area(&self) -> f64;
    fn name(&self) -> &str;
}

// --- Implementation ---
impl Area for Shape {
    fn area(&self) -> f64 {
        match self {
            Shape::Circle(r) => PI * r * r,
            Shape::Rectangle { width, height } => width * height,
            Shape::Triangle(a, b, c) => {
                let s = (a + b + c) / 2.0;
                (s * (s - a) * (s - b) * (s - c)).sqrt()
            }
        }
    }

    fn name(&self) -> &str {
        match self {
            Shape::Circle(_) => "circle",
            Shape::Rectangle { .. } => "rectangle",
            Shape::Triangle(..) => "triangle",
        }
    }
}

// --- Generic function with trait bound ---
fn largest<T: PartialOrd>(list: &[T]) -> &T {
    let mut largest = &list[0];
    for item in list {
        if item > largest {
            largest = item;
        }
    }
    largest
}

// --- Lifetimes ---
fn longest<'a>(x: &'a str, y: &'a str) -> &'a str {
    if x.len() > y.len() {
        x
    } else {
        y
    }
}

// --- Error handling with Result ---
fn safe_divide(a: f64, b: f64) -> Result<f64, String> {
    if b == 0.0 {
        Err(String::from("division by zero"))
    } else {
        Ok(a / b)
    }
}

// --- Display impl ---
impl fmt::Display for User {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "{} <{}>", self.name, self.email)
    }
}

// --- Main ---
fn main() {
    let user = User {
        id: 1,
        name: String::from("Alice"),
        email: String::from("alice@example.com"),
        is_active: true,
    };

    println!("User: {}", user);
    println!("Debug: {:?}", user);

    let shapes = vec![
        Shape::Circle(5.0),
        Shape::Rectangle { width: 3.0, height: 4.0 },
    ];

    for shape in &shapes {
        println!("{} area: {:.2}", shape.name(), shape.area());
    }

    let numbers = vec![34, 50, 25, 100, 65];
    println!("Largest: {}", largest(&numbers));

    let mut scores: HashMap<String, i32> = HashMap::new();
    scores.insert(String::from("Blue"), 10);

    match safe_divide(10.0, 3.0) {
        Ok(result) => println!("Result: {:.4}", result),
        Err(e) => eprintln!("Error: {}", e),
    }

    // Closure & iterator chain
    let sum: i32 = numbers.iter().filter(|&&x| x > 30).sum();
    println!("Sum: {}", sum);
}
