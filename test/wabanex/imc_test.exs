defmodule Wabanex.IMCTest do
  use ExUnit.Case, async: true

  alias Wabanex.IMC

  describe "calculate/1" do
    test "When the file exists, returns the data" do
      params = %{"filename" => "students.csv"}

      actual = IMC.calculate(params)
      expected = {
        :ok,
        %{
          "Lays" => 15.94387755102041,
          "Leticia" => 22.03856749311295,
          "Luzinete" => 24.46460160337235
        }
      }

      assert expected == actual
    end

    test "When the wrong filename given, returns an error" do
      params = %{"filename" => "other_name.csv"}

      actual = IMC.calculate(params)
      expected = {:error, "Error while opening the file"}

      assert expected == actual
    end
  end
end
