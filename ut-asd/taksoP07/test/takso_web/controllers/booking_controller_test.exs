defmodule TaksoWeb.BookingControllerTest do
  use TaksoWeb.ConnCase

  alias Takso.Guardian
  alias Takso.Accounts.User
  alias Takso.{Repo,Sales.Taxi}

  import Ecto.Query, only: [from: 2]

  setup do
    user = Repo.get!(User, 1)
    conn = build_conn()
           |> bypass_through(Takso.Router, [:browser, :browser_auth, :ensure_auth])
           |> get("/")
           |> Map.update!(:state, fn (_) -> :set end)
           |> Guardian.Plug.sign_in(user)
           |> send_resp(200, "Flush the session")
           |> recycle
    {:ok, conn: conn}
  end

  # Tests fail if you don't provide a valid Bing Key on the
  # file: /takso_web/services/geolocation.ex
  ###

  test "Booking rejection", %{conn: conn} do
    Repo.insert!(%Taxi{status: "busy"})
    conn = post conn, "/bookings", %{booking: [pickup_address: "Juhan Liivi 2, Tartu", dropoff_address: "Lõunakeskus, Tartu"]}
    conn = get conn, redirected_to(conn)
    assert html_response(conn, 200) =~ ~r/At present, there is no taxi available!/
  end

  test "Booking aceptance", %{conn: conn} do
    Repo.insert!(%Taxi{status: "available", location: "Raatuse 22, 51009 Tartu"})
    conn = post conn, "/bookings", %{booking: [pickup_address: "Juhan Liivi 2, Tartu", dropoff_address: "Lõunakeskus, Tartu"]}
    conn = get conn, redirected_to(conn)
    assert html_response(conn, 200) =~ ~r/Your taxi will arrive in \d+ minutes/
  end

  test "Booking Acceptance by shortest distance", %{conn: conn} do
    Repo.insert!(%Taxi{status: "available", location: "Ringtee 75, 50501 Tartu"})
    Repo.insert!(%Taxi{status: "available", location: "Raatuse 22, 51009 Tartu"})

    query = from t in Taxi, where: t.status == "available", select: t
    [t1, _] = Repo.all(query)
    assert t1.location == "Ringtee 75, 50501 Tartu"

    conn = post conn, "/bookings", %{booking: [pickup_address: "Juhan Liivi 2, Tartu", dropoff_address: "Lõunakeskus, Tartu"]}
    conn = get conn, redirected_to(conn)

    query = from t in Taxi, where: t.status == "busy", select: t
    [t2] = Repo.all(query)

    response = html_response(conn, 200)
    matches = Regex.named_captures(~r/Your taxi will arrive in (?<dur>\d+) minutes/, response)

    assert matches["dur"] == "8"
    assert t2.location == "Raatuse 22, 51009 Tartu"
  end
end
