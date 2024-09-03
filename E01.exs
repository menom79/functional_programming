# Home Assignment 1

## Part 1

### Declare a variable and set its value to 123.
my_variable = 123

### 2. Print the value of the variable to the console.
IO.puts("The value of the variable is #{my_variable}")

### 3. Add code that asks a text line from the user (use IO.gets).
IO.puts("Hello user! please enter a text:")
text = IO.gets("") |> String.trim()

### 4. Add text <- You said that to the text that user entered.
combined_text = "You said that #{text}"

### 5. Print the combined text into the console
IO.puts("Combined text: #{combined_text}")

## Part 2

### 1. Write an Elixir script that calculates the result of 154 divided by 78 and prints it to the console.
result = 154 / 78
IO.puts("Result of 154 divided by 78: #{result}")

### 2. Get the result of calculation (step 1) rounded to nearest integer and print it to console.
rounded_result = round(result)
IO.puts("Rounded result: #{rounded_result}")

### 3. Get the result of calculation (step 1) and print only the integer part of it into the console.
integer_part = trunc(result)
IO.puts("Integer part of the result: #{integer_part}")

## Part 3

### 1. Ask a line of text from the user (use IO.gets).
IO.puts("Please enter a line of text:")
user_input = IO.gets("")

### 2. Print the number of characters in string that user entered.
char_count = String.length(user_input)
IO.puts("Number of characters in the entered text: #{char_count}")

### 3. Print the entered text in reverse.
reversed_text = String.reverse(user_input)
IO.puts("Reversed text: #{reversed_text}")

### 4. Replace the word foo in entered text with bar and print resulted string into the console.
modified_text = String.replace(user_input, "foo", "bar")
IO.puts("Modified text: #{modified_text}")

## Part 4

### 1. Write an anonymous function that takes three parameters and calculates a product (multiplication) of those three values.
product_function = fn a, b, c -> a * b * c end

### 2. Ask three numbers from user (use IO.gets and String.to_integer) and pass them to your function created in step 1.
IO.puts("Please enter the first number:")
number1 = String.to_integer(IO.gets(""))

IO.puts("Please enter the second number:")
number2 = String.to_integer(IO.gets(""))

IO.puts("Please enter the third number:")
number3 = String.to_integer(IO.gets(""))

### 3. Print the result to the console.
result = product_function.(number1, number2, number3)
IO.puts("The product of the three numbers is: #{result}")

### 4. Write an anonymous function that concats two lists and returns the result.
concat_lists = fn list1, list2 -> list1 ++ list2 end

### 5. Call the list concat function and print the results.
list1 = [1, 2, 3]
list2 = [4, 5, 6]
concatenated_list = concat_lists.(list1, list2)
IO.puts("Concatenated list: #{inspect(concatenated_list)}")

### 6. Declare a tuple with atoms ok and fail.
result_tuple = {:ok, :fail}

### 7. Add new atom canceled and print the combined tuple.
result_tuple_with_canceled = elem(result_tuple, 0) == :ok ? {:ok, :canceled} : {:fail, :canceled}
IO.puts("Combined tuple with 'canceled': #{inspect(result_tuple_with_canceled)}")
