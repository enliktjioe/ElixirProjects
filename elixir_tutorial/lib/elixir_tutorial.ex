defmodule M do
  def main do
    do_stuff()
  end

  def do_stuff do
    IO.puts "Factorial of 3 : #{factorial(3)}"

  end

  def display_list([word|words]) do
    IO.puts word
    display_list(words)
  end

  def display_list([]), do: nil

  def factorial(num) do
    if num <= 1 do
      1
    else
      result = num * factorial(num - 1)
      result
    end
  end 

end