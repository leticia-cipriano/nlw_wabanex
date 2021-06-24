defmodule Wabanex.User do
  # injeta código de um módulo, importa macro e qqr tipo de código
  use Ecto.Schema

  alias Wabanex.Training
  # importa funções
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  @fields [:name, :email, :password]

  schema "users" do
    field :name, :string, null: false
    field :email, :string, null: false
    field :password, :string, null: false

    has_one :training, Training

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
