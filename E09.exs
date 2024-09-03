defmodule ChatServer do
  use GenServer

  defmodule State do
    defstruct clients: %{}
  end

  def start_link do
    GenServer.start_link(__MODULE__, %State{}, name: __MODULE__)
  end

  def handle_call({:add_client, client_pid, client_name}, _from, state) do
    new_state = %{state | clients: Map.put(state.clients, client_pid, client_name)}
    {:reply, :ok, new_state}
  end

  def handle_call({:remove_client, client_pid}, _from, state) do
    new_state = %{state | clients: Map.delete(state.clients, client_pid)}
    {:reply, :ok, new_state}
  end

  def handle_cast({:broadcast, client_pid, message}, state) do
    Enum.each(state.clients, fn {pid, name} ->
      if pid != client_pid do
        send(pid, {name, message})
      end
    end)
    {:noreply, state}
  end
end

defmodule ChatClient do
  def start_link(server_pid, client_name) do
    GenServer.start_link(__MODULE__, {server_pid, client_name})
  end

  def send_message(server_pid, client_pid, message) do
    GenServer.cast(server_pid, {:broadcast, client_pid, message})
  end

  def assign_name(server_pid, client_pid, client_name) do
    GenServer.call(server_pid, {:add_client, client_pid, client_name})
  end

  defp remove_client(server_pid, client_pid) do
    GenServer.call(server_pid, {:remove_client, client_pid})
  end

  def handle_call({:add_client, client_pid, client_name}, _from, state) do
    IO.puts("#{client_name} has joined the chat.")
    {:reply, :ok, state}
  end

  def handle_info({client_name, message}, state) do
    IO.puts("#{client_name}: #{message}")
    {:noreply, state}
  end

  def handle_cast(_msg, state) do
    {:noreply, state}
  end

  def init({server_pid, client_name}) do
    {:ok, %{server_pid: server_pid, client_name: client_name}}
  end

  def terminate(_reason, %{server_pid: server_pid, client_name: client_name}) do
    remove_client(server_pid, self())
    IO.puts("#{client_name} has left the chat.")
  end
end

# Start the server
{:ok, server_pid} = ChatServer.start_link()

# Start two clients
{:ok, client1_pid} = ChatClient.start_link(server_pid, "Alice")
{:ok, client2_pid} = ChatClient.start_link(server_pid, "Bob")

# Assign names to clients
ChatClient.assign_name(server_pid, client1_pid, "Alice")
ChatClient.assign_name(server_pid, client2_pid, "Bob")

# Send messages from clients
ChatClient.send_message(server_pid, client1_pid, "Hello from Alice!")
ChatClient.send_message(server_pid, client2_pid, "Hi, this is Bob.")

# Wait for messages to be processed
Process.sleep(2000)
