defmodule M do
  def main do
    do_stuff()
  end

  def do_stuff do
    age = 16

    case 2 do
      1 -> IO.puts "Entered 1"
      2 -> IO.puts "Entered 2"
      _ -> IO.puts "Default"
    end

    IO.puts "Ternary #{if age > 18, do: "Can Vote", else: "Can't vote"}"
  end


end
