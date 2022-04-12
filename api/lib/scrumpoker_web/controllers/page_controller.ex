defmodule ScrumPokerWeb.PageController do
  use ScrumPokerWeb, :controller

  plug :put_layout, false when action in [:index]

  def index(conn, %{"room" => room}) do
    render(conn, "landing.html", room: room)
  end

  def index(conn, _params) do
    render(conn, "landing.html", room: "")
  end

  def landing(conn, _params) do
    render(conn, "landing.html")
  end

  def room(conn, %{"room" => room, "name" => userName}) do
    render(conn, "room.html", %{room: String.downcase(room), user_id: userName})
  end

  def room(conn, %{"room" => room}) do
    render(conn, "landing.html", room: room, layout: false)
  end
end
