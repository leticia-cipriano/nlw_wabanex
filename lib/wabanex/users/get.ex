defmodule Wabanex.Users.Get do
  alias Wabanex.{User, Repo, Training}
  alias Ecto.UUID

  import Ecto.Query

  def call(uuid) do
    uuid
    |> UUID.cast()
    |> handle_response()
  end

  defp handle_response(:error), do: {:erro, "Invalid ID"}

  defp handle_response({:ok, uuid}) do
    case Repo.get(User, uuid) do
      nil -> {:error, "User not found"}
      user -> {:ok, load_training(user)}
    end
  end

  defp load_training(%User{} = user) do
    today = Date.utc_today()

    query =
      from var_training in Training,
        where: ^today >= var_training.start_date and ^today <= var_training.end_date

    Repo.preload(user, trainings: {first(query, :inserted_at), :exercises})
  end
end
