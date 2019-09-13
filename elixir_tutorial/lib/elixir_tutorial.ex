defmodule M do
  def main do
    do_stuff()
  end

  def do_stuff do
    age = 16

    if age >= 18 do
      IO.puts "Can Vote"
    else
      IO.puts "Can't Vote"
    end

    unless age === 18 do
      IO.puts "You're not 18"
    else
      IO.puts "You are 18"
    end

    cond do
      age >= 18 -> IO.puts "Can Vote"
      age >= 16 -> IO.puts "You can drive"
      age >= 14 -> IO.puts "You can wait"
      true -> IO.puts "Default"
    end
  end


end
