
case {1, 2, 3} do
  {4, 5, 6} -> IO.puts "This will not match"
  {1, x, 3} -> IO.puts "Will match and bind value 2 to x"
  _ -> IO.puts "This would match any value"
end

x = 1
case 10 do
  ^x -> IO.puts "Won't match"
  _ -> IO.puts "Will match"
end

case {1, 2, 3} do
  {1, x, 3} when x > 0 -> IO.puts "Will match"
  _ -> IO.puts "Would ,atch if guard is not satisfied"
end


hd([1])
case 1 do
  x when hd(x) -> IO.puts "Won't match"
  x -> IO.puts "Got #{x}"
end


f = fn
  x, y when x > 0 -> x + y
  x, y -> x * y
end

IO.puts f.(1, 3)
IO.puts f.(-1, 3)


cond do
  2 + 2 == 5 -> IO.puts "This will not be true"
  2 * 2 == 3 -> IO.puts "Nor this"
  true -> IO.puts "This is always true"
end


cond do
  hd([1, 2, 3]) -> IO.puts "1 is considered as true"
end


if 2 do
  IP.puts "This works"
end

unless true do
  IO.puts "This will never be seen"
end


if nil do
  IO.puts "Nono"
else
  IO.puts "Hello"
end


if true, do: IO.puts 1 + 2

if false, do: IO.puts(:this), else: IO.puts(:that)


if true do
  a = 1 + 2
  a = a + 10
  IO.puts a
end

if true, do: (
  a = 1 + 2
  a = a + 10
  IO.puts a
)

is_number if true do
  IO.puts 1 + 2
end
