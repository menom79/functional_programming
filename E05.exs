defmodule Math do
  def add(x, y) do
    info("Adding #{x} and #{y}")
    x + y
  end

  def sub(x, y) do
    info("Subtracting #{x} from #{y}")
    x - y
  end

  def mul(x, y) do
    info("Multiplying #{x} and #{y}")
    x * y
  end

  def div(x, y) do
    info("Dividing #{x} by #{y}")
    x / y
  end

  defp info(msg) do
    IO.puts(msg)
  end
end

defmodule Calculator do
  def calc(input) do
    {x, op, y} = parse_input(input)
    case op do
      "+" -> Math.add(x, y)
      "-" -> Math.sub(x, y)
      "*" -> Math.mul(x, y)
      "/" -> Math.div(x, y)
      _ -> {:error, "Invalid operator"}
    end
  end

  defp parse_input(input) do
    [x_str, op_str, y_str] = String.split(input, ~r/[\+\-\*\/]/)
    x = String.to_float(String.replace(x_str, ",", "."))
    y = String.to_float(String.replace(y_str, ",", "."))
    {x, op_str, y}
  end
end

defmodule Main do
  def start do
    loop()
  end

  defp loop do
    IO.puts("Enter a math expression (e.g., 123+456) or 'exit' to quit:")
    input = String.trim(IO.gets(""))
    case input do
      "exit" -> IO.puts("Exiting the calculator.")
      _ ->
        case Calculator.calc(input) do
          {:error, message} -> IO.puts("Error: #{message}")
          result -> IO.puts("Result: #{result}")
        end
        loop()
    end
  end
end

Main.start()
