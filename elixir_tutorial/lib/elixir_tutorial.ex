defmodule M do
  def main do
    do_stuff()
  end

  def do_stuff do
    
    err = try do
      5 / 0

    rescue
      ArithmeticError -> "Can't Divide by Zero"
    end

    IO.puts err
  end

  def display_list([word|words]) do
    IO.puts word
    display_list(words)
  end

  def display_list([]), do: nil

end