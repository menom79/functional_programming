defmodule Player do
  def start_link do
    spawn_link(fn -> loop() end)
  end

  defp loop do
    receive do
      {:dealer, dealer_pid} ->
        IO.puts("Player's turn:")
        handle_player_turn(dealer_pid)
      {:result, result} ->
        IO.puts("Result: #{result}")
        handle_play_again()
    end
  end

  defp handle_player_turn(dealer_pid) do
    IO.puts("Enter 'hit' or 'stand': ")
    case IO.gets("") |> String.trim() do
      "hit" ->
        send(dealer_pid, {:player, self(), :hit})
        handle_player_turn(dealer_pid)
      "stand" ->
        send(dealer_pid, {:player, self(), :stand})
    end
  end

  defp handle_play_again do
    IO.puts("Play again? (yes/no)")
    case IO.gets("") |> String.trim() do
      "yes" ->
        IO.puts("Starting a new game...\n\n")
        send(self(), {:dealer, Dealer.start_link()})
      _ ->
        IO.puts("Thanks for playing!")
        Process.exit(self(), :normal)
    end
  end
end

defmodule Dealer do
  def start_link do
    spawn_link(fn -> loop() end)
  end

  defp loop do
    receive do
      {:player, player_pid, :hit} ->
        card = draw_card()
        IO.puts("Player drew: #{card}")
        send(player_pid, {:dealer, self(), card})
        loop()
      {:player, player_pid, :stand} ->
        dealer_hand = draw_card() + draw_card()
        IO.puts("Dealer's turn: #{dealer_hand}")
        handle_dealer_turn(player_pid, dealer_hand)
    end
  end

  defp draw_card do
    :rand.uniform(10) + 1
  end

  defp handle_dealer_turn(player_pid, dealer_hand) do
    if dealer_hand < 17 do
      card = draw_card()
      IO.puts("Dealer drew: #{card}")
      new_dealer_hand = dealer_hand + card
      send(player_pid, {:dealer, self(), card})
      handle_dealer_turn(player_pid, new_dealer_hand)
    else
      determine_winner(dealer_hand)
    end
  end

  defp determine_winner(dealer_hand) do
    if dealer_hand > 21 do
      {:result, "Player wins! Dealer busted with #{dealer_hand}"}
    else
      {:result, if dealer_hand > 16 do "Dealer wins with #{dealer_hand}" else "Player wins with #{dealer_hand}" end}
    end
  end
end

player_pid = Player.start_link()
dealer_pid = Dealer.start_link()

send(player_pid, {:dealer, dealer_pid})

Process.sleep(:infinity)
