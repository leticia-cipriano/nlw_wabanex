defmodule WabanexWeb.IMCControllerTest do
  use WabanexWeb.ConnCase, async: true

  describe "index/2" do
    test "when all params are valid, returns the imc info", %{conn: conn} do
      params = %{"filename" => "students.csv"}

      actual = conn
        |> get(Routes.imc_path(conn, :index, params))
        |> json_response(:ok)

      expected = %{
        "result" => %{
          "Lays" => 15.94387755102041,
          "Leticia" => 22.03856749311295,
          "Luzinete" => 24.46460160337235
        }
      }

      assert expected == actual
    end

    test "when there are invalid params, returns an error", %{conn: conn} do
      params = %{"filename" => "other_name.csv"}

      actual = conn
        |> get(Routes.imc_path(conn, :index, params))
        |> json_response(:bad_request)

      expected = %{"result" => "Error while opening the file"}

      assert expected == actual
    end
  end
end
