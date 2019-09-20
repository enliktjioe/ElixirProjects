defmodule Bowling do
  def score(game) do
    List.flatten(game)
    |> Enum.filter(fn e -> is_number(e) end)    # &is_number/1
    # |> Enum.reduce(0, fn n, acc -> n + acc end) # &+/2
    |> count()

    # Enum.reduce(0, fn n, acc -> n + acc end)
    # 0 is the initial value, acc = accumulator -> n + acc
  end


  defp count([]) do
    0
  end

  defp count([h1 | [h2 | tail]]) when h1 + h2 == 10 do
    10 + hd(tail) + count(tail)
  end

  defp count([h1 | [h2 | tail]]) do
    h1 + h2 + count(tail)
  end


  # hd(tail) = head of tail
  # defp = define private function
end
