defmodule YouboxApiWeb.Auth.Guardian do
  use Guardian, otp_app: :youbox_api
  alias YouboxApi.Users

  def subject_for_token(%{id: id}, _claims), do: {:ok, to_string(id)}

  def subject_for_token(_, _), do: {:error, :no_id_provided}

  def resource_from_claims(%{"sub" => id}) do
    {:ok, Users.get_user!(id)}
  rescue
    Ecto.NoResultsError -> {:error, :not_found}
  end

  def authenticate(email, password) do
    case Users.get_user_by_email(email) do
      nil -> {:error, :unauthorized}
      user ->
        case Bcrypt.verify_pass(password, user.hash_password) do
          true -> create_token(user)
          false -> {:error, :unauthorized}
        end
    end
  end

  defp create_token(user) do
    {:ok, token, _claims} = encode_and_sign(user)
    {:ok, user, token}
  end
end
