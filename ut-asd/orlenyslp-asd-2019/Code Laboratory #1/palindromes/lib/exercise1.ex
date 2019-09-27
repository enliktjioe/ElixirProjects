defmodule Exercise1 do

  def reverse(list), do: reverse(list, [])
  def reverse([], reversed), do: reversed
  def reverse([head | tail], reversed), do: reverse(tail, [head | reversed])

  def upcase(list), do: MList.map(list,
    fn
      x when x in ?a..?z -> x - 32
      x -> x
    end
  )

  ## Full recursive implementation without using the function MAP
  #def upcase([]), do: []
  #def upcase([head | tail]) when head in ?a..?z, do: [head - 32 | upcase(tail)]
  #def upcase([head | tail]), do: [head | upcase(tail)]

  #def remove_non_alpha(list), do: MList.filter(list, fn x -> x in ?a..?z or x in ?A..?Z end)
  def remove_non_alpha(list), do: MList.filter(list, &(&1 in ?a..?z or &1 in ?A..?Z))

  ## Full recursive implementation without using the function FILTER
  #def remove_non_alpha([]), do: []
  #def remove_non_alpha([head | tail]) when head not in ?a..?z and head not in ?A..?Z, do: remove_non_alpha(tail)
  #def remove_non_alpha([head | tail]), do: [head | remove_non_alpha(tail)]

  def palindrome(word) do
    remove_non_alpha(word)
    |> upcase
    |> verify
  end

  def verify(word), do: word == reverse(word)

end
