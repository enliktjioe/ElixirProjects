defmodule Takso.BookingController do
  use Takso.Web, :controller
  import Ecto.Query, only: [from: 2]

  alias Takso.{Taxi,Booking,Repo}

  def index(conn, _params) do
    render conn, "index.html"
  end

  def new(conn, _params) do
    render conn, "new.html", changeset: Booking.changeset(%Booking{})
  end

  def create(conn, %{"booking" => _booking_params}) do
    query = from t in Taxi, where: t.status == "available", select: t
    available_taxis = Repo.all(query)
    if length(available_taxis) > 0 do
      conn
      |> put_flash(:info, "Your taxi will arrive in 5 minutes")
      |> redirect(to: booking_path(conn, :index))
    else
      conn
      |> put_flash(:error, "We apologize, we cannot serve your request in this moment")
      |> redirect(to: booking_path(conn, :index))
    end
  end
end
