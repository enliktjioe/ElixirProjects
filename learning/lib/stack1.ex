defmodule Stack1 do
    use GenServer

    def init(state) do
        {:ok, state}
    end

    def push(pid, value), do: GenServer.cast(pid, {:push, value})
    def pop(pid), do: GenServer.call(pid, {:pop})

    def handle_cast({:push, value}, state) do
        {:noreply, [value | state]}
    end

    def handle_call({:pop}, _from, state) do
        {:reply, hd(state), tl(state)}
    end
end