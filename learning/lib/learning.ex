defmodule Learning do
  # def factorial(0), do: 1
  # def factorial(n) when n > 0, do: n * factorial(n-1)

  def print([h|t]) do
    IO.puts h
    print t
  end

  def print([]) do
    IO.puts "<done>"
  end
end
