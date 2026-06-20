// ============================================
// Theme Check: Go
// ============================================
// - Keywords: func, type, struct, interface, package, import
// - Variables (var, :=), constants (const, iota)
// - Comments (single line, block)
// - Operators / Numbers / Strings (interpreted, raw)
// - Goroutines, channels, defer
// - Error handling, generics (Go 1.18+)
// - Struct tags

package main

import (
	"errors"
	"fmt"
	"strings"
	"sync"
)

// --- Constants ---
const (
	MaxRetries = 3
	Pi         = 3.14159
	HexValue   = 0xFF
	Binary     = 0b1010
	Greeting   = "Hello, World!"
)

// --- iota enum ---
type Status int

const (
	StatusActive Status = iota
	StatusInactive
	StatusPending
)

func (s Status) String() string {
	switch s {
	case StatusActive:
		return "active"
	case StatusInactive:
		return "inactive"
	default:
		return "pending"
	}
}

// --- Interface ---
type Area interface {
	Area() float64
	Name() string
}

// --- Struct with tags ---
type User struct {
	ID       uint64   `json:"id"`
	Name     string   `json:"name"`
	Email    string   `json:"email"`
	IsActive bool     `json:"is_active"`
	Tags     []string `json:"tags,omitempty"`
}

func NewUser(id uint64, name, email string) *User {
	return &User{
		ID:       id,
		Name:     name,
		Email:    strings.ToLower(email),
		IsActive: true,
	}
}

func (u *User) DisplayName() string {
	return fmt.Sprintf("%s <%s>", u.Name, u.Email)
}

func ValidateEmail(email string) bool {
	return strings.Contains(email, "@") && strings.Contains(email, ".")
}

// --- Generics (Go 1.18+) ---
type Repository[T any] struct {
	mu    sync.RWMutex
	items map[uint64]T
}

func NewRepository[T any]() *Repository[T] {
	return &Repository[T]{items: make(map[uint64]T)}
}

func (r *Repository[T]) Add(id uint64, item T) {
	r.mu.Lock()
	defer r.mu.Unlock()
	r.items[id] = item
}

func (r *Repository[T]) Get(id uint64) (T, bool) {
	r.mu.RLock()
	defer r.mu.RUnlock()
	item, ok := r.items[id]
	return item, ok
}

func Largest[T int | float64](list []T) T {
	largest := list[0]
	for _, item := range list {
		if item > largest {
			largest = item
		}
	}
	return largest
}

// --- Error handling ---
var ErrDivideByZero = errors.New("division by zero")

func safeDivide(a, b float64) (float64, error) {
	if b == 0 {
		return 0, ErrDivideByZero
	}
	return a / b, nil
}

// --- Goroutines & channels ---
func fetchAll(urls []string) []string {
	results := make(chan string, len(urls))
	var wg sync.WaitGroup

	for _, url := range urls {
		wg.Add(1)
		go func(u string) {
			defer wg.Done()
			results <- fmt.Sprintf("fetched: %s", u)
		}(url)
	}

	go func() {
		wg.Wait()
		close(results)
	}()

	var collected []string
	for r := range results {
		collected = append(collected, r)
	}
	return collected
}

// --- Main ---
func main() {
	user := NewUser(1, "Alice", "Alice@Example.com")
	fmt.Println(user.DisplayName())
	fmt.Printf("Status: %v\n", StatusActive)

	// Raw string literal
	pattern := `\A[\w]+@[\w]+\z`
	fmt.Println(pattern)

	repo := NewRepository[*User]()
	repo.Add(user.ID, user)
	if got, ok := repo.Get(1); ok {
		fmt.Println("Found:", got.Name)
	}

	numbers := []int{34, 50, 25, 100, 65}
	fmt.Println("Largest:", Largest(numbers))

	if result, err := safeDivide(10.0, 3.0); err != nil {
		fmt.Println("Error:", err)
	} else {
		fmt.Printf("Result: %.4f\n", result)
	}

	// Map & slice
	scores := map[string]int{"Blue": 10, "Red": 20}
	for k, v := range scores {
		fmt.Printf("%s: %d\n", k, v)
	}
}
