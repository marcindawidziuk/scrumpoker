defmodule ScrumpokerWeb.RoomChannelTest do
  use ScrumpokerWeb.ChannelCase

  setup do
    {:ok, _, socket} =
      socket(ScrumpokerWeb.UserSocket, "user_id", %{user_id: :assign})
      |> subscribe_and_join(ScrumpokerWeb.RoomChannel, "room:lobby")

    {:ok, socket: socket}
  end

  test "shout broadcasts to room:lobby", %{socket: socket} do
    push socket, "shout", %{"hello" => "all"}
    assert_broadcast "shout", %{"hello" => "all"}
  end

  test "broadcasts are pushed to the client", %{socket: socket} do
    broadcast_from! socket, "broadcast", %{"some" => "data"}
    assert_push "broadcast", %{"some" => "data"}
  end
end
