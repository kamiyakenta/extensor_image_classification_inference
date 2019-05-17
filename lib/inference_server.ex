# defmodule InferenceServer do
#   @behaviour GenServer

#   def run_inference_server(prepare_model) do
#     {:ok, pid} = GenServer.start_link(InferenceServer, prepare_model)
#   end

#   @impl GenServer
#   def init(state) do
#     set_interval(state)
#     {:ok, state}
#   end

#   defp set_interval(state) do
#     Process.send_after(self(), :run, 2 * 1000)
#   end

#   @impl GenServer
#   def handle_info(:run, result_list) do
#     result_inference_list = append_new(result_list)
#     set_interval()
#     {:noreply, result_inference_list}
#   end

#   defp append_new([]) do
#     []
#   end

#   defp append_new([head | tail]) do
#     [new_result | [head | tail]]
#   end

#   @impl GenServer
#   # GenServer.call(pid, :last)
#   def handle_call(:last, _from, []) do
#     {:reply, {:error, []}, []}
#   end

#   @impl GenServer
#   # GenServer.call(pid, :last)
#   def handle_call(:last, _from, [head | tail]) do
#     {:reply, {:ok, head}, [head | tail]}
#   end

#   @impl GenServer
#   # GenServer.call(pid, :list)
#   def handle_call(:list, _from, list) do
#     {:reply, {:ok, list}, list}
#   end
# end
