defmodule ScrumpokerWeb.PageController do
  use ScrumpokerWeb, :controller

  def rick(conn, _params)do
    if :erlang.date |> :calendar.day_of_the_week >= 5 do
      redirect(conn, external: "https://youtu.be/4z95SAFud7w")
    else
      redirect(conn, external: "https://www.youtube.com/watch?v=dQw4w9WgXcQ")
    end
  end

  def index(conn, %{"room" => room}) do
    render(conn, "index.html", room: room)
  end

  def index(conn, _params) do
    render(conn, "index.html", room: "")
  end

  def room(conn, %{"room" => room, "name" => _userName}) do
      render(conn, "room.html", room: String.downcase(room))
  end
  
  def room(conn, %{"room" => room}) do
    redirect(conn, to: "/poker?room=#{room}")
  end
end
