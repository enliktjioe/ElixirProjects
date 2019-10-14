defmodule TaksoWeb.BookingController do
  use TaksoWeb, :controller

  import Ecto.Query, only: [from: 2]
  alias Takso.Sales.Taxi
  alias Takso.Sales.Booking
  alias Takso.Repo

  def new(conn, _params) do
    changeset = Booking.changeset(%Booking{}, %{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"booking" => _booking_params}) do
    query = from t in Taxi, where: t.status == "available", select: t
    available_taxis = Repo.all(query)

    case length(available_taxis) > 0 do
      true -> conn
              |> put_flash(:info, "Your taxi will arrive in 5 minutes")
              |> redirect(to: booking_path(conn, :new))
      _    -> conn
              |> put_flash(:info, "At present, there is no taxi available!")
              |> redirect(to: booking_path(conn, :new))
    end

  end

end
