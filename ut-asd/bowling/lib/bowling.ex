defmodule Bowling do
  def score(game) do
    List.flatten(game)
    |> Enum.filter(fn e -> is_number(e) end)    # &is_number/1
    # |> Enum.reduce(0, fn n, acc -> n + acc end) # &+/2
    |> count()

    # Enum.reduce(0, fn n, acc -> n + acc end)
    # 0 is the initial value, acc = accumulator -> n + acc
  end

  # gutter game
  defp count([]) do
    0
  end

  # perfect game
  defp count([h1, h2, h3]) when h1 == 10 or h2 == 10 or h1 + h2 == 10 do
    h1 + h2 + h3
  end

  # one strike
  # defp count([h1 | [h2 | tail]]) when h1 == 10 do
  defp count([10 | [h2 | tail]]) do
    10 + h2 + hd(tail) + count([h2 | tail])
  end
  # nil value removed by Enum.filter()

  # one spare
  defp count([h1 | [h2 | tail]]) when h1 + h2 == 10 do
    10 + hd(tail) + count(tail)
  end

  # all one games
  defp count([h1 | [h2 | tail]]) do
    h1 + h2 + count(tail)
  end


  # hd(tail) = head of tail
  # defp = define private function
end
