# Par 1

defmodule DivisibilityChecker do
  def main do
    IO.puts("Enter a number:")
    input = IO.gets("") |> String.trim()

    case String.to_integer(input) do
      {:ok, number} ->
        if rem(number, 3) == 0 do
          IO.puts("Divisible by 3.")
        elsif rem(number, 5) == 0 do
          IO.puts("Divisible by 5.")
        elsif rem(number, 7) == 0 do
          IO.puts("Divisible by 7.")
        else
          smallest_divisor = find_smallest_divisor(number, 2)
          IO.puts("Smallest divisor (excluding 1): #{smallest_divisor}.")
        end
      {:error, _} ->
        IO.puts("Invalid input. Please enter a valid number.")
    end
  end

  defp find_smallest_divisor(number, divisor) when divisor > number, do: number
  defp find_smallest_divisor(number, divisor) do
    if rem(number, divisor) == 0 do
      divisor
    else
      find_smallest_divisor(number, divisor + 1)
    end
  end
end

DivisibilityChecker.main()


# Part 2

combined_or_sum = fn
  a when is_binary(a) ->
    fn b when is_binary(b) -> "#{a}#{b}"
    b -> a <> to_string(b)
  end
  a -> fn b -> a + b end
end

IO.puts(combined_or_sum.("Hello", "World"))
IO.puts(combined_or_sum.(10, 20))
