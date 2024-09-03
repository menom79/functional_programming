# Part 1

# Defining string
string = "99 bottles of beer on the wall"

# Spliting the string into words using whitespace as the delimiter
words = String.split(string, " ")

# Calculating the number of words
num_words = length(words)

# Result
IO.puts("Number of words in the string: #{num_words}")


# Part 2

# Function to translate a word to Pig Latin
defmodule PigLatin do
  def translate_word(word) when String.match?(word, ~r/^[aeiou]/i), do: word <> "ay"
  def translate_word(word) when String.match?(word, ~r/^(ch|qu|squ|th|thr|sch)/i), do: String.slice(word, 2, String.length(word) - 2) <> String.slice(word, 0, 2) <> "ay"
  def translate_word(word) when String.match?(word, ~r/^(yt|xr)/i), do: word <> "ay"
  def translate_word(word), do: String.slice(word, 1, String.length(word) - 1) <> String.at(word, 0) <> "ay"
end

# Defining the input phrase
phrase = "Pattern Matching with Elixir. Remember that equals sign is a match operator, not an assignment."

# Splitting the phrase into words
words = String.split(phrase, ~r/\s+/)

# Translating each word to Pig Latin
translated_words = Enum.map(words, &PigLatin.translate_word/1)

# Joining the translated words back into a phrase
translated_phrase = Enum.join(translated_words, " ")

# Printing the translated phrase
IO.puts("Translated Pig Latin phrase: #{translated_phrase}")
