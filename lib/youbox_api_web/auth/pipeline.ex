defmodule YouboxApiWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :youbox_api,
  module: YouboxApiWeb.Auth.Guardian,
  error_handler: YouboxApiWeb.Auth.GuardianErrorHandler

  plug Guardian.Plug.VerifySession
  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
