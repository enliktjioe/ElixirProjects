defmodule M do
  def main do
    do_stuff()
  end

  def do_stuff do
    IO.puts "5 + 4 = #{5+4}"
    IO.puts "5 - 4 = #{5-4}"
    IO.puts "5 * 4 = #{5*4}"
    IO.puts "5 / 4 = #{5/4}"
    IO.puts "7 div 4 = #{div(7,4)}"
    IO.puts "7 rem 4 = #{rem(7,4)}"
  end


end
