<?php
// ============================================
// Theme Check: PHP
// ============================================
// - Keywords: class, function, interface, trait, namespace
// - Variables ($var), properties, visibility modifiers
// - Type declarations and nullable types
// - Comments (single line, block, docblock)
// - Operators / Numbers / Strings (single, double, heredoc)
// - Match expression / arrow functions
// - Exception handling

declare(strict_types=1);

namespace App\Models;

use App\Contracts\Identifiable;
use Exception;

// --- Constants ---
const MAX_RETRIES = 3;
const PI = 3.14159;
const HEX_VALUE = 0xFF;
const BINARY = 0b1010;
const GREETING = "Hello, World!";

// --- Interface ---
interface Area
{
    public function area(): float;
    public function name(): string;
}

// --- Trait ---
trait Timestamps
{
    protected ?string $createdAt = null;

    public function touch(): void
    {
        $this->createdAt = date('Y-m-d H:i:s');
    }
}

/**
 * Represents a user in the system.
 *
 * @property int    $id
 * @property string $name
 */
class User implements Identifiable
{
    use Timestamps;

    public function __construct(
        public readonly int $id,
        public string $name,
        private string $email,
        public bool $isActive = true,
        public array $tags = [],
    ) {
        $this->email = strtolower($email);
    }

    public function getDisplayName(): string
    {
        return "{$this->name} <{$this->email}>";
    }

    public static function validateEmail(string $email): bool
    {
        return str_contains($email, '@') && str_contains($email, '.');
    }
}

// --- Enum (PHP 8.1+) ---
enum Status: string
{
    case Active = 'active';
    case Inactive = 'inactive';
    case Pending = 'pending';

    public function label(): string
    {
        return match ($this) {
            Status::Active => 'Active user',
            Status::Inactive => 'Disabled user',
            Status::Pending => 'Awaiting approval',
        };
    }
}

// --- Generic-ish repository ---
class Repository
{
    /** @var array<int, User> */
    private array $items = [];

    public function add(int $id, User $item): void
    {
        $this->items[$id] = $item;
    }

    public function get(int $id): ?User
    {
        return $this->items[$id] ?? null;
    }

    public function all(): array
    {
        return array_values($this->items);
    }
}

// --- Arrow functions & higher-order ---
$transform = fn (int $x): int => $x * 2 + 1;
$numbers = array_map($transform, range(0, 4));
$filtered = array_filter($numbers, fn ($x) => $x > 5);

// --- String types ---
$rawString = 'no $interpolation here';
$doubleString = "Interpolated: {$numbers[0]}";
$heredoc = <<<EOT
This is a
multiline heredoc with $rawString
EOT;
$nowdoc = <<<'EOT'
No $interpolation in nowdoc
EOT;

// --- Exception handling ---
try {
    $value = (int) "not a number";
    if ($value === 0) {
        throw new Exception("Invalid value");
    }
} catch (Exception $e) {
    echo "Error: {$e->getMessage()}" . PHP_EOL;
} finally {
    echo "Cleanup" . PHP_EOL;
}

// --- Main ---
$user = new User(1, "Alice", "Alice@Example.com");
echo $user->getDisplayName() . PHP_EOL;
echo Status::Active->label() . PHP_EOL;
var_dump($user instanceof User);
