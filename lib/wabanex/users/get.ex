defmodule Wabanex.Users.Get do
  alias Wabanex.{User, Repo}
  alias Ecto.UUID

  def call(uuid) do
    uuid
    |> UUID.cast()
    |> handle_response()
  end

  defp handle_response(:error), do: {:erro, "Invalid ID"}
  defp handle_response({:ok, uuid}) do
    case Repo.get(User, uuid) do
      nil -> {:error, "User not found"}
      user -> {:ok, user}
    end
  end
end
