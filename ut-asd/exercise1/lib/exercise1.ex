defmodule Exercise1 do
    # def reverse(textInput) do
    #     Enum.reverse(textInput)
    # end

    def reverse(word) do
        reverse(word, [])
    end

    def reverse([], acc) do
        # IO.puts "here"
        acc
    end

    def reverse([head | tail], acc) do
        # IO.puts "here"
        IO.puts acc
        reverse(tail, [head | acc])
    end
end
