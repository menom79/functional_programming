# Exercise 1: Simple Pattern Matching with Variables

# Assign the value 42 to a variable x
x = 42

# Use pattern matching to check if x is equal to 42
case x do
  42 ->
    IO.puts("x is equal to 42.")
  _ ->
    IO.puts("x is not equal to 42.")
end

# Use pattern matching to check if x is equal to 41
case x do
  41 ->
    IO.puts("x is equal to 41.")
  _ ->
    IO.puts("x is not equal to 41.")
end

# Exercise 2: Matching on Lists

# Define the list
list = [1, 2, 3, 4]

# a. Retrieve the first element
[first | _] = list
IO.puts("First element: #{first}")

# b. Retrieve the first two elements
[first, second | _] = list
IO.puts("First two elements: [#{first}, #{second}]")

# c. Retrieve the last element
[last | _] = Enum.reverse(list)
IO.puts("Last element: #{last}")

# Exercise 3: Matching on Tuples

# Define the tuple
tuple = {:ok, "Hello World!"}

# Use pattern matching to retrieve the value
{:ok, retrieved_value} = tuple
IO.puts("Retrieved value: #{retrieved_value}")

# Exercise 4: Function Pattern Matching

# Create a function with multiple clauses that uses pattern matching to: Return "zero" if the input is 0, Return "one" if the input is 1, Return "other" for any other input

defmodule NumberToWord do
  def convert(0), do: "zero"
  def convert(1), do: "one"
  def convert(_), do: "other"
end

IO.puts(NumberToString.convert(0))  # Output: "zero"
IO.puts(NumberToString.convert(1))  # Output: "one"
IO.puts(NumberToString.convert(42)) # Output: "other"

# Exercise 5: The Pin Operator

# Assign the value 42 to a variable x. Then, using the pin operator (^), write a pattern matching expression that matches only if a given value is equal to 42.

# Assign the value 42 to a variable x
x = 42

# Use pattern matching with the pin operator to check if a value is equal to 42
value_to_check = 42

case value_to_check do
  ^x ->
    IO.puts("The value matches 42.")
  _ ->
    IO.puts("The value does not match 42.")
end

# Exercise 6: Working with Atoms

# Create a function with multiple clauses that uses pattern matching to return the string representation of the following atoms: :ok, :error, :unknown.

defmodule AtomToString do
  def convert(:ok), do: "Success"
  def convert(:error), do: "Error"
  def convert(:unknown), do: "Unknown"
  def convert(_), do: "Other" # Catch-all clause for any other atom
end

IO.puts(AtomToString.convert(:ok))       # Output: "Success"
IO.puts(AtomToString.convert(:error))    # Output: "Error"
IO.puts(AtomToString.convert(:unknown))  # Output: "Unknown"

# Exercise 7: Pattern Matching on Strings

# Given a string "hello world", use pattern matching to: Check if the string starts with "hello", Check if the string ends with "world"

# Define the string
string = "hello world"

# Check if the string starts with "hello"
case String.match?(string, ~r/^hello/) do
  true ->
    IO.puts("The string starts with 'hello'.")
  false ->
    IO.puts("The string does not start with 'hello'.")
end

# Check if the string ends with "world"
case String.match?(string, ~r/world$/) do
  true ->
    IO.puts("The string ends with 'world'.")
  false ->
    IO.puts("The string does not end with 'world'.")
end

# Exercise 8: Working with List Head and Tail

# Given a list, use pattern matching to: Retrieve the head of the list, Retrieve the tail of the list, Check if the list is empty

# Define a list
my_list = [1, 2, 3, 4]

# Retrieve the head of the list
[head | _tail] = my_list
IO.puts("Head of the list: #{head}")

# Retrieve the tail of the list
[_head | tail] = my_list
IO.puts("Tail of the list: #{inspect(tail)}")

# Check if the list is empty
case my_list do
  [] ->
    IO.puts("The list is empty.")
  [_ | _] ->
    IO.puts("The list is not empty.")
end
