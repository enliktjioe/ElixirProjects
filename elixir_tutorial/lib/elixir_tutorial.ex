defmodule M do
  def main do
    do_stuff()
  end

  def do_stuff do
    IO.puts "4 == 4.0 : #{4 == 4.0}" # comparing the value, so it will be TRUE
    IO.puts "4 === 4.0 : #{4 === 4.0}" # comparing the data type, so it will be FALSE
    IO.puts "4 != 4.0 : #{4 != 4.0}" # comparing the value, so it will be FALSE
    IO.puts "4 !== 4.0 : #{4 !== 4.0}" # comparing the value, so it will be TRUE

    IO.puts "5 > 4 : #{5 > 4}"
    IO.puts "5 >= 4 : #{5 >= 4}"
    IO.puts "5 < 4 : #{5 < 4}"
    IO.puts "5 <= 4 : #{5 <= 4}"
  end


end
