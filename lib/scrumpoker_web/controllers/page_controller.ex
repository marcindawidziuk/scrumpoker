defmodule ScrumpokerWeb.PageController do
  use ScrumpokerWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def room(conn, %{"room" => room}) do
      render(conn, "room.html", room: String.downcase(room))
  end
end
