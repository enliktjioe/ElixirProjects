defmodule Takso.Authentication do
    import Plug.Conn
    
    def init(_opts) do 
        opts[:repo]
    end

    def call(conn, repo) do
        IO.puts "HI THERE ..."
        user = repo.get(Takso.User, 1)
        assign(conn, :current_user, user)
    end    
end  