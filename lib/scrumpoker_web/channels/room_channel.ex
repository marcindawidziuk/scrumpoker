defmodule ScrumPokerWeb.RoomChannel do
  use ScrumPokerWeb, :channel
  alias ScrumPokerWeb.Presence

  def join("room:" <> room_id, payload, socket) do
    if authorized?(payload) do
      send(self(), :after_join)
      {:ok, %{channel: "room:#{room_id}"}, assign(socket, :room_id, room_id)}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (room:lobby).
  def handle_in("shout", payload, socket) do
    broadcast socket, "shout", payload
    {:noreply, socket}
  end

  def handle_in("ping", payload, socket) do
    broadcast socket, "ping", payload
    {:noreply, socket}
  end

  def handle_in("change_message", payload, socket) do
    broadcast socket, "change_message", payload
    {:noreply, socket}
  end

  def handle_in("voted", payload, socket) do
    broadcast socket, "voted", payload
    {:noreply, socket}
  end

  def handle_in("show_votes", payload, socket) do
    broadcast socket, "show_votes", payload
    {:noreply, socket}
  end

  def handle_in("clear_votes", payload, socket) do
    broadcast socket, "clear_votes", payload
    {:noreply, socket}
  end

  def handle_in("joined", payload, socket) do
    broadcast socket, "joined", payload
    {:noreply, socket}
  end
  
  def handle_info(:after_join, socket) do
    {:ok, _} = Presence.track(socket, socket.assigns.user_id, %{
      observer: false,
      userName: socket.assigns.user_id,
      online_at: inspect(System.system_time(:second))
    })

    push socket, "presence_state", Presence.list(socket)
    {:noreply, socket}
  end

  def handle_in("user_set_observer", %{"observer" => observer}, socket) do
    {:ok, _} = Presence.update(socket, socket.assigns.user_id, %{
      observer: observer,
      userName: socket.assigns.user_id,
      online_at: inspect(System.system_time(:second))
    })

    {:reply, :ok, socket}
  end


  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
