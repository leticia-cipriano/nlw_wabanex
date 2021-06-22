defmodule Wabanex.User do
  use Ecto.Schema # injeta código de um módulo, importa macro e qqr tipo de código

  import Ecto.Changeset # importa funções

  @primary_key {:id, :binary_id, autogenerate: true}

  @fields [:name, :email, :password]

  schema "users" do
    field :name, :string
    field :email, :string
    field :password, :string

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @fields)
    |> validate_required(@fields)
    |> validate_length(:name, min: 3)
    |> validate_length(:password, min: 6)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint([:email])
  end
end
