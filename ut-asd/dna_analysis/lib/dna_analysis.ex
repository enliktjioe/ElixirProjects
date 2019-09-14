defmodule DnaAnalysis do
  def count('', _), do: 0

  def count([head | tail], n) when head == n, do: 1 + count(tail, n)

  def count([_ | tail], n), do: count(tail, n)

  def histogram(chain) do
    %{
      ?A => count(chain, ?A),
      ?T => count(chain, ?T),
      ?C => count(chain, ?C),
      ?G => count(chain, ?G)
    }
  end

end
