defmodule M do
  def main do
    do_stuff()
  end

  def do_stuff do
    my_str = "Enlik Enlik"
    IO.puts "Length : #{String.length(my_str)}"
    longer_str = my_str <> " " <> "is longer"
    IO.puts "En ? #{String.contains?(my_str, "En")}"

    IO.puts "First : #{String.first(my_str)}"

    IO.puts "Index 4 : #{String.at(my_str, 4)}"

    IO.puts "Substring : #{String.slice(my_str, 3, 8)}"
  end


end
