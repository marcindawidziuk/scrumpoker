defmodule ScrumpokerWeb.PageController do
  use ScrumpokerWeb, :controller

  plug :put_layout, false when action in [:index]
  
  def rick(conn, _params)do
    if :erlang.date |> :calendar.day_of_the_week >= 5 do
      redirect(conn, external: "https://youtu.be/4z95SAFud7w")
    else
      redirect(conn, external: "https://www.youtube.com/watch?v=dQw4w9WgXcQ")
    end
  end

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
