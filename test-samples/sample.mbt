// ============================================
// Theme Check: MoonBit
// ============================================
// - Keywords: fn, let, struct, enum, trait, type, pub, priv, mut
// - Method syntax: fn method(self : Type) -> Unit
// - Pattern matching
// - Pipeline operator |>
// - Types and generics

// --- Struct ---
struct Point {
  x : Double
  y : Double
}

// --- Enum ---
enum Shape {
  Circle(Double)
  Rectangle(Double, Double)
  Triangle(Point, Point, Point)
}

// --- Trait ---
trait Area {
  area(Self) -> Double
}

// --- Methods ---
fn Point::new(x : Double, y : Double) -> Point {
  { x, y }
}

fn Point::distance(self : Point, other : Point) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  (dx * dx + dy * dy).sqrt()
}

fn Point::to_string(self : Point) -> String {
  "(\{self.x}, \{self.y})"
}

// --- Impl trait ---
impl Area for Shape with area(self) {
  match self {
    Circle(r) => 3.14159 * r * r
    Rectangle(w, h) => w * h
    Triangle(a, b, c) => {
      let s = (a.distance(b) + b.distance(c) + c.distance(a)) / 2.0
      (s * (s - a.distance(b)) * (s - b.distance(c)) * (s - c.distance(a))).sqrt()
    }
  }
}

// --- Generic function ---
fn identity[T](x : T) -> T {
  x
}

// --- Pipeline operator ---
fn process(input : Int) -> String {
  input
  |> fn(x) { x * 2 }
  |> fn(x) { x + 1 }
  |> fn(x) { x.to_string() }
}

// --- Let bindings and pattern matching ---
fn describe(shape : Shape) -> String {
  match shape {
    Circle(r) => "Circle with radius \{r}"
    Rectangle(w, h) => "Rectangle \{w}x\{h}"
    Triangle(..) => "Triangle"
  }
}

// --- Array and loop ---
fn sum(arr : Array[Int]) -> Int {
  let mut total = 0
  for i = 0; i < arr.length(); i = i + 1 {
    total = total + arr[i]
  }
  total
}

// --- Option and error handling ---
fn safe_divide(a : Double, b : Double) -> Double? {
  if b == 0.0 {
    None
  } else {
    Some(a / b)
  }
}

// --- Test ---
test "point distance" {
  let p1 = Point::new(0.0, 0.0)
  let p2 = Point::new(3.0, 4.0)
  assert_eq!(p1.distance(p2), 5.0)
}

// --- Main ---
fn main {
  let circle = Circle(5.0)
  let rect = Rectangle(3.0, 4.0)
  println(describe(circle))
  println(describe(rect))
  println("Area: \{circle.area()}")

  let result = safe_divide(10.0, 3.0)
  match result {
    Some(v) => println("Result: \{v}")
    None => println("Division by zero")
  }
}
