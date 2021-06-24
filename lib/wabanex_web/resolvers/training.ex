defmodule WabanexWeb.Resolvers.Trainig do
  # def get(%{id: user_id}, _context), do: Wabanex.Users.Get.call(user_id)

  def create(%{input: params}, _context), do: Wabanex.Training.Create.call(params)
end
