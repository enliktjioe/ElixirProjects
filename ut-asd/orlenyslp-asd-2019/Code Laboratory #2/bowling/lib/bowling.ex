defmodule Bowling do

  def score(game) do
    List.flatten(game)
    |> Enum.filter(fn e -> is_number(e) end)    # &is_number/1
    |> count_points
  end





  defp count_points([]), do: 0
  defp count_points([h1, h2, h3]) when h1 == 10 or h1 + h2 == 10, do: h1 + h2 + h3
  defp count_points([10 | [h2 | tail]]), do: 10 + h2 + hd(tail) + count_points([h2 | tail])
  defp count_points([h1 | [h2 | tail]]) when h1 + h2 == 10, do: 10 + hd(tail) + count_points(tail)
  defp count_points([h1 | [h2 | tail]]), do: h1 + h2 + count_points(tail)


end
