defmodule ExamprepWeb.PageController do
  use ExamprepWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
