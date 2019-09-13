defmodule Exercise1 do
    # def reverse(textInput) do
    #     Enum.reverse(textInput)
    # end

    def reverse(word) do
        reverse(word, [])
    end

    def reverse([], acc) do
        # IO.puts "something to print"
        acc
    end

    def reverse([head | tail], acc) do
        # IO.puts "something to print"
        IO.puts acc
        reverse(tail, [head | acc])
    end

    # TODO
    # def reverse(word), do: word |> List.foldl(word, [], fn(ch, acc) -> ch | acc | end end)

    def upcase([]), do: []

    def upcase([head | tail]) when head in ?a..?z do
        # IO.puts
        [head - 32 | upcase(tail)]
    end

    def upcase([head | tail]) when head not in ?a..?z do
        [head | upcase(tail)]
    end

    def remove_non_alpha([head | tail]) when head in ?a..?z or head in ?A..?Z do
        [head | remove_non_alpha(tail)]
    end

    def remove_non_alpha([head | tail]) do
        remove_non_alpha(tail)
    end

    def remove_non_alpha(word), do: word |> Enum.filter(fn(x) -> if x in ?a..?z or in ?A..?Z end)

    # def palindrome(word) do
    #     upcased = word |> upcase

    # end

end
