defmodule ScrumPokerWeb.Monitor  do
  def start_link(initial_state) do
    Agent.start_link(fn -> initial_state end, name: __MODULE__)
  end

  def get_deck(room_id) do
    Agent.get(__MODULE__, fn state -> get_deck(state, room_id) end)
  end

  @doc """
  Getting deck for current room
  """
  def get_deck(state, room_id) do
    default_decks = get_default_deck()
    case state[room_id] do
      nil ->
        state
        |> Map.put(room_id, %{decks: default_decks, currentDeck: List.first(default_decks)})
        |> Map.get(room_id)
      data ->
        state[room_id]
    end
  end

  @doc """
  Setting deck for current room
  """
  def deck_update(room_id, deck) do
    Agent.update(__MODULE__, fn state -> deck_update(state, room_id, deck) end)
  end
  
  @doc """
  Adding new deck for the current room
  """
  def add_deck(room_id, new_deck) do
    Agent.update(__MODULE__, fn state -> add_deck(state, room_id, new_deck) end)
  end

  defp add_deck(state, room_id, deck) do
    new_state = state
                |> get_deck(room_id)
                |> add_deck_to_state(deck)
                |> Map.replace(:currentDeck, deck)
    put_in(state, [room_id], new_state)
  end
  
  def add_deck_to_state(room_state, new_deck) do
    if length(Map.get(room_state, :decks)) > 20 do
      exit("don't be greedy, too many decks")
    end
    
    Map.replace!(room_state, :decks, [new_deck | get_default_deck()])
  end

  defp deck_update(state, room_id, deck) do
    new_state = state
                |> get_deck(room_id)
                |> Map.replace(:currentDeck, deck)
    put_in(state, [room_id], new_state)
  end

  defp get_default_deck() do
    [
      %{name: "Standard", cards: "0|0.5|1|2|3|5|8|13|20|40|∞|☕"},
      %{name: "Time estimate", cards: "30m|1h|2h|4h|8h|2d|4d|7d|14d|30d|∞|☕"},
    ]
  end
end
