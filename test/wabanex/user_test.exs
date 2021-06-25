defmodule Wabanex.UserTest do
  use Wabanex.DataCase, async: true

  alias Wabanex.User

  describe "changeset/1"  do
    test "when all params are valid, returns a valid changeset" do
      params = %{
        name: "Nome",
        email: "email@mail.com",
        password: "123456"
      }

      actual = User.changeset(params)

      assert %Ecto.Changeset{
        valid?: true,
        changes: %{email: "email@mail.com", name: "Nome", password: "123456"},
        errors: []
      } = actual
    end

    test "when there are invalid params, returns a invalid changeset" do
      params = %{
        name: "N",
        email: "emailmail.com"
      }

      actual = User.changeset(params)

      assert %Ecto.Changeset{
        valid?: false,
      } = actual

      expected_errors_message = %{
        email: ["has invalid format"],
        name: ["should be at least 3 character(s)"],
        password: ["can't be blank"]
      }

      assert errors_on(actual) == expected_errors_message
    end
  end
end
