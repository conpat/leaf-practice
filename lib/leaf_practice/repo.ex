defmodule LeafPractice.Repo do
  use Ecto.Repo,
    otp_app: :leaf_practice,
    adapter: Ecto.Adapters.Postgres
end
