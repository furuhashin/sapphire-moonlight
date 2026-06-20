# ============================================
# Theme Check: Ruby
# ============================================
# - Keywords: def, class, module, do/end, require
# - Symbols (:symbol) and instance/class variables (@var, @@var)
# - Comments (single line, =begin/=end block)
# - Operators / Numbers / Strings (single, double, heredoc)
# - Blocks, procs, lambdas
# - String interpolation and regex
# - Exception handling

require 'set'
require 'json'

# --- Constants ---
MAX_RETRIES = 3
PI = 3.14159
HEX_VALUE = 0xFF
BINARY = 0b1010
GREETING = "Hello, World!"

# --- Module (mixin) ---
module Timestamps
  attr_reader :created_at

  def touch
    @created_at = Time.now
  end
end

=begin
Represents a user in the system.
Demonstrates attr accessors, keyword args, and mixins.
=end
class User
  include Timestamps

  attr_accessor :name
  attr_reader :id, :email

  @@count = 0

  def initialize(id:, name:, email:, is_active: true, tags: [])
    @id = id
    @name = name
    @email = email.downcase
    @is_active = is_active
    @tags = tags
    @@count += 1
  end

  def display_name
    "#{@name} <#{@email}>"
  end

  def self.count
    @@count
  end

  def self.validate_email(email)
    email.include?("@") && email.include?(".")
  end

  def active?
    @is_active
  end

  def to_s
    display_name
  end
end

# --- Class with comparable ---
class Repository
  include Enumerable

  def initialize
    @items = {}
  end

  def add(id, item)
    @items[id] = item
  end

  def get(id)
    @items.fetch(id, nil)
  end

  def each(&block)
    @items.values.each(&block)
  end
end

# --- Blocks, procs, lambdas ---
transform = ->(x) { x * 2 + 1 }
square = proc { |x| x ** 2 }
numbers = (0..4).map { |x| transform.call(x) }
filtered = numbers.select { |x| x > 5 }
total = numbers.reduce(0) { |sum, x| sum + x }

# --- Symbols & hashes ---
config = {
  host: "localhost",
  port: 8080,
  enabled: true,
}
status_labels = {
  active: "Active user",
  inactive: "Disabled user",
}

# --- String types & interpolation ---
raw_string = 'no #{interpolation} here'
double_string = "Result: #{42 * 2}"
heredoc = <<~TEXT
  This is a
  multiline heredoc with #{GREETING}
TEXT

# --- Regex ---
email_pattern = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
puts "valid" if "alice@example.com" =~ email_pattern

# --- Case / when ---
def handle_command(command)
  case command
  when "quit", "exit"
    "Goodbye"
  when "help"
    "Available commands: quit, help, status"
  when /\Aecho /
    command[5..]
  else
    "Unknown: #{command}"
  end
end

# --- Exception handling ---
begin
  value = Integer("not a number")
rescue ArgumentError => e
  puts "Error: #{e.message}"
rescue TypeError
  puts "Type error"
else
  puts "Success"
ensure
  puts "Cleanup"
end

# --- Main guard ---
if __FILE__ == $PROGRAM_NAME
  user = User.new(id: 1, name: "Alice", email: "Alice@Example.com")
  puts user.display_name
  puts user.is_a?(User)
  puts User.count
end
