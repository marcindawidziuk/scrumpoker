defmodule ScrumPokerWeb.RoomChannel do
  use ScrumPokerWeb, :channel
  alias ScrumPokerWeb.Monitor
  alias ScrumPokerWeb.Presence

  def join("room:" <> room_id, payload, socket) do
    if authorized?(payload) do
      send(self(), {:after_join, room_id})
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

  def handle_in("update_deck", payload, socket) do
    new_current_deck = Jason.decode!(payload["cards"])
    Monitor.deck_update(socket.assigns.room_id, new_current_deck)

    broadcast! socket, "active_deck", Monitor.get_deck(socket.assigns.room_id)
    push socket, "active_deck", Monitor.get_deck(socket.assigns.room_id)
    {:noreply, socket}
  end

  def handle_in("add_deck", payload, socket) do
    Monitor.add_deck(socket.assigns.room_id, payload["deck"])

    broadcast! socket, "active_deck", Monitor.get_deck(socket.assigns.room_id)
    push socket, "active_deck", Monitor.get_deck(socket.assigns.room_id)
    {:noreply, socket}
  end
  
  def handle_info({:after_join, room_id}, socket) do
    {:ok, _} = Presence.track(socket, socket.assigns.user_id, %{
      observer: false,
      userName: socket.assigns.user_id,
      online_at: inspect(System.system_time(:second))
    })

    broadcast! socket, "active_deck", Monitor.get_deck(room_id)
    push socket, "presence_state", ScrumPokerWeb.Presence.list(socket)
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
