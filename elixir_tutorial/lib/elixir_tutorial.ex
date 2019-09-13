defmodule M do
  def main do
    do_stuff()
  end

  def do_stuff do
    my_str = "Enlik Enlik"
    IO.puts "Length : #{String.length(my_str)}"
    longer_str = my_str <> " " <> "is longer"

    IO.inspect String.split(longer_str, " ") #print internal representation of a value

    IO.puts String.reverse(longer_str)
    IO.puts String.upcase(longer_str)
    IO.puts String.downcase(longer_str)
    IO.puts String.capitalize(longer_str)

    4 * 10 |> IO.puts
  end


end
