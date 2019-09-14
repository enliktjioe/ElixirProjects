defmodule M do
  def main do
    do_stuff()
  end

  def do_stuff do
    
    # IO.puts "Even list: #{Enum.any?([1,2,3],
    # fn(n) -> rem(n, 2) == 0 end)}"

    Enum.each([1,2,3], fn(n) -> IO.puts n end)

    dbl_list = Enum.map([1,2,3], fn(n) -> n * 2 end)
    IO.inspect dbl_list

    sum_vals = Enum.reduce([1,2,3], fn(n, sum) -> n + sum end)
    IO.puts "Sum : #{sum_vals}"
    
    IO.inspect Enum.uniq([1,2,2])
  end

  def display_list([word|words]) do
    IO.puts word
    display_list(words)
  end

  def display_list([]), do: nil

end