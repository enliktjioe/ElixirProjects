defmodule Stack do
    def create() do
        loop([])
    end

    defp loop(state) do
        receive do
            {:push, value} -> loop([value|state])
            {:pop} -> IO.puts(hd(state)); loop(tl(state))
        end
    end
end