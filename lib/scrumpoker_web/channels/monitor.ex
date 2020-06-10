defmodule ScrumPokerWeb.Monitor  do
  def start_link(initial_state) do
    Agent.start_link(fn -> initial_state end, name: __MODULE__)
  end
  
  def get_deck(room_id) do
    Agent.get(__MODULE__, fn state -> get_deck(state, room_id) end)
  end

  defp get_deck(state, room_id) do
    case state[room_id] do
      nil ->
        state
        |> Map.put(room_id, %{cards: "0|0.5|1|2|3|5|8|13|20|40|∞|☕"})
        |> Map.get(room_id)
      data ->
        state[room_id]
    end
  end

def deck_update(room_id, cards) do
    Agent.update(__MODULE__, fn state -> deck_update(state, room_id, cards) end)
  end

  defp deck_update(state, room_id, cards) do
    put_in(state, [room_id], cards)
  end
end
