defmodule Examprep.Repo do
  use Ecto.Repo,
    otp_app: :examprep,
    adapter: Ecto.Adapters.Postgres
end
