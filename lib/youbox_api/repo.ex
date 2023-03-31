defmodule YouboxApi.Repo do
  use Ecto.Repo,
    otp_app: :youbox_api,
    adapter: Ecto.Adapters.Postgres
end
