defmodule M do
  def main do
    do_stuff()
  end

  def do_stuff do
    age = 16

    IO.puts "Vote and Drive : #{(age >= 16) and (age >= 18)}"
    IO.puts "Vote or Drive : #{(age >= 16) or (age >= 18)}"

    IO.puts not true
  end


end
