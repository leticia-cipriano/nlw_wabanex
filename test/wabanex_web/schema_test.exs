defmodule WabanexWeb.SchemaTest do
  use WabanexWeb.ConnCase, async: true

  alias Wabanex.User
  alias Wabanex.Users.Create

  describe "users queries" do
    test "when a valid id is given, returns the user", %{conn: conn} do
      params = %{
        name: "Nome",
        email: "email@mail.com",
        password: "123456"
      }

      {:ok, %User{id: user_id}} = Create.call(params)
      query = """
        {
          getUser(id: "#{user_id}"){
            name,
            email
          }
        }
      """

      actual =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(:ok)

        expected = %{
          "data" => %{
            "getUser" => %{
              "email" => "email@mail.com",
              "name" => "Nome"
            }
          }
        }

        assert expected == actual
    end

    test "when id are invalid given, returns a error", %{conn: conn} do

      query = """
        {
          getUser(id: "123"){
            name,
            email
          }
        }
      """

      actual =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(:ok)

        expected =  %{
          "errors" => [
            %{
              "locations" => [%{"column" => 13, "line" => 2}],
              "message" => "Argument \"id\" has invalid value \"123\"."
            }
          ]
        }

        assert expected == actual
    end

    test "when all params are valid, creates the user", %{conn: conn} do

      mutation = """
        mutation{
          createUser(input: {
            name: "Name One",
            email: "name@mail.com",
            password: "123456"
          }){
            id,
            name,
            email
          }
        }
      """

      actual =
        conn
        |> post("/api/graphql", %{query: mutation})
        |> json_response(:ok)

        assert  %{
          "data" => %{
            "createUser" => %{
              "email" => "name@mail.com",
              "id" => _id,
              "name" => "Name One"
            }
          }
        } = actual
    end
  end
end
