defmodule NamerWeb.PageController do
  use NamerWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
