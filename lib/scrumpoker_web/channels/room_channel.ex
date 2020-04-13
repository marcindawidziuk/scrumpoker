defmodule ScrumpokerWeb.RoomChannel do
  use ScrumpokerWeb, :channel

  def join("room:" <> _, payload, socket) do
    if authorized?(payload) do
      {:ok, socket}
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

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
