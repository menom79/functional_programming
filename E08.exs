defmodule PeriodicalTimer do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def start_timer(period, fun) do
    GenServer.call(__MODULE__, {:start_timer, period, fun})
  end

  def cancel_timer(timer_ref) do
    GenServer.cast(__MODULE__, {:cancel_timer, timer_ref})
  end

  def handle_call({:start_timer, period, fun}, _from, state) do
    {timer_ref, new_state} = start_timer(period, fun, state)
    {:reply, timer_ref, new_state}
  end

  def handle_cast({:cancel_timer, timer_ref}, state) do
    new_state = cancel_timer(timer_ref, state)
    {:noreply, new_state}
  end

  defp start_timer(period, fun, state) do
    timer_ref = {self(), make_ref()}

    Process.send_after(self(), {:timer_trigger, timer_ref}, period)

    new_state = Map.put(state, timer_ref, fun)
    {timer_ref, new_state}
  end

  defp cancel_timer(timer_ref, state) do
    Process.cancel_timer(timer_ref)
    new_state = Map.delete(state, timer_ref)
    new_state
  end

  defp handle_info({:timer_trigger, timer_ref}, state) do
    case Map.get(state, timer_ref) do
      nil -> {:noreply, state}  # Timer already canceled
      fun ->
        case fun.() do
          :cancel -> {:noreply, cancel_timer(timer_ref, state)}
          :ok -> {:noreply, state}
        end
    end
  end

  defp handle_info(_, state), do: {:noreply, state}
end

defmodule Example do
  def start do
    {:ok, _pid} = PeriodicalTimer.start_link()

    # Start a timer with a 1000 ms (1 second) period
    timer_ref = PeriodicalTimer.start_timer(1000, fn ->
      IO.puts("Timer triggered!")
      # To cancel the timer, return :cancel
      # To continue the timer, return :ok
      :ok
    end)

    # Wait for a while and then cancel the timer
    Process.sleep(5000)
    PeriodicalTimer.cancel_timer(timer_ref)
  end
end

Example.start()
