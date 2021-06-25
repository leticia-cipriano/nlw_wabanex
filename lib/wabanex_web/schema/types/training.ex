defmodule WabanexWeb.Schema.Types.Training do
  use Absinthe.Schema.Notation

  @desc "Logic training representation"
  object :training do
    field :id, non_null(:uuid4)
    field :start_date, :string
    field :end_date, :string
    field :exercises, list_of(:exercise)
  end

  input_object :create_training_input do
    field :user_id, non_null(:uuid4) #todo add descrição
    field :start_date, non_null(:string)
    field :end_date, non_null(:string)
    field :exercises, list_of(:create_exercise_input)
  end
end
