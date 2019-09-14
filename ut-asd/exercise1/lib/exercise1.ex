defmodule Exercise1 do

    def reverse(word) do
        reverse(word, [])
    end

    def reverse([], acc) do
        acc
    end

    def reverse([head | tail], acc) do
        # IO.puts "something to print"
        # IO.puts acc
        reverse(tail, [head | acc])
    end

    def upcase([]) do
        []
    end

    def upcase([head | tail]) when head in ?a..?z do
        # IO.puts
        [head - 32 | upcase(tail)]
    end

    def upcase([head | tail]) when head not in ?a..?z do
        [head | upcase(tail)]
    end

    def remove_non_alpha([]) do
        []
    end

    def remove_non_alpha([head | tail]) when head not in ?a..?z and head not in ?A..?Z do
        remove_non_alpha(tail)
    end

    def remove_non_alpha([head | tail]) do
        [head | remove_non_alpha(tail)]
    end

    def palindrome(word) do
        remove_non_alpha(word)
        |> upcase
        |> verify

    end

    def verify(word) do
        word == reverse(word)
    end


end
