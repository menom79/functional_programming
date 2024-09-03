# Part 1

# Declare a keyword list that contains name of the color and color html value.

# See html color values here

# Add at least 10 colors to the keyword list


# Create a loop that asks user the color name or color html value.

# If entered text begins with '#', print the corresponding color name.
# Otherwise print the corresponding html color value.
# If neither is found in keyword list, exit the loop.

defmodule ColorFinder do
  def start do
    IO.puts("Enter a color name or HTML value (or 'exit' to quit):")
    input = String.trim(IO.gets(""))
    find_color_info(input)
  end

  defp find_color_info("exit") do
    IO.puts("Exiting the loop.")
  end

  defp find_color_info(input) do
    colors = [
      red: "#FF0000",
      green: "#00FF00",
      blue: "#0000FF",
      yellow: "#FFFF00",
      purple: "#800080",
      orange: "#FFA500",
      pink: "#FFC0CB",
      brown: "#A52A2A",
      cyan: "#00FFFF",
      black: "#000000"
    ]

    input_lowercase = String.downcase(input)

    color_info =
      case {String.at(input, 0), String.length(input)} do
        {"#", _} -> Enum.find_value(colors, fn {_, html} -> String.downcase(html) == input_lowercase end)
        {_, _} -> Enum.find_value(colors, fn {name, _} -> String.downcase(name) == input_lowercase end)
      end

    case color_info do
      nil -> IO.puts("Color not found.")
      {name, _} -> IO.puts("Corresponding color name: #{name}")
      {_, html} -> IO.puts("Corresponding HTML color value: #{html}")
    end

    IO.puts("Enter a color name or HTML value (or 'exit' to quit):")
    new_input = String.trim(IO.gets(""))
    find_color_info(new_input)
  end
end

ColorFinder.start()

# Part 2

# Declare a map that contains book ISBN as a key and book name as a value.

# Add at least 5 books into the map


# Create a loop that reads commands from the user:


# list lists all books in the map.

# search ISBN searches a book with specified ISBN and prints book info.

# add ISBN,NAME adds new book into the map.

# remove ISBN removes book with ISBN if found on map.

# quit exits the loop.

defmodule BookManager do
  def start do
    IO.puts("Enter a command (list, search ISBN, add ISBN,NAME, remove ISBN, quit):")
    loop(%{
      "ISBN123": "Book 1",
      "ISBN456": "Book 2",
      "ISBN789": "Book 3",
      "ISBN101": "Book 4",
      "ISBN202": "Book 5"
    })
  end

  defp loop(books) do
    IO.puts("Enter a command:")
    command = String.trim(IO.gets(""))

    case String.split(command, ~r/\s+/, trim: true) do
      ["list"] ->
        Enum.each(books, fn {isbn, name} -> IO.puts("#{isbn}: #{name}") end)
        loop(books)

      ["search", isbn] ->
        case Map.get(books, isbn) do
          nil -> IO.puts("Book not found.")
          name -> IO.puts("Book found: #{isbn}: #{name}")
        end
        loop(books)

      ["add", isbn, name] ->
        updated_books = Map.put(books, isbn, name)
        IO.puts("Book added: #{isbn}: #{name}")
        loop(updated_books)

      ["remove", isbn] ->
        updated_books =
          case Map.delete(books, isbn) do
            {nil, _} -> IO.puts("Book not found.")
            {_, updated} -> updated
          end
        IO.puts("Book removed: #{isbn}")
        loop(updated_books)

      ["quit"] ->
        IO.puts("Exiting the program.")

      _ ->
        IO.puts("Invalid command. Please try again.")
        loop(books)
    end
  end
end

BookManager.start()
