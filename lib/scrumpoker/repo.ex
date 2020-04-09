defmodule Scrumpoker.Repo do
  use Ecto.Repo,
    otp_app: :scrumpoker,
    adapter: Ecto.Adapters.Postgres
end
