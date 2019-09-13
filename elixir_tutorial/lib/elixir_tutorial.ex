defmodule M do
  def main do
    do_stuff()
  end

  def do_stuff do
    my_str = "Enlik Enlik"
    IO.puts "Length : #{String.length(my_str)}"
    longer_str = my_str <> " " <> "is longer"
    IO.puts "Equal : #{"Egg" === "egg"}"
  end


end
