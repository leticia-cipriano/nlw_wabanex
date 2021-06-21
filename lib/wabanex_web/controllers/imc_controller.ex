defmodule WabanexWeb.IMCController do
  use WabanexWeb, :controller

  alias Wabanex.IMC

  def index(conn, params) do
    params
    |> IMC.calculate()
    |> handle_response(conn)
  end

  defp handle_response({:error, reason}, conn), do: build_response(conn, :bad_request, reason)
  defp handle_response({:ok, result}, conn), do: build_response(conn, :ok, result)

  defp build_response(conn, status, result) do
    conn
    |> put_status(status)
    |> json(%{result: result})
  end
end
