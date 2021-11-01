defmodule ElliTest.Application do
  use Application
  
  def start(_type, _args) do
    elli_opts = [callback: ElliTest.Handler, port: 4000]

    children = [
      %{id: :elli, start: {:elli, :start_link, [elli_opts]}},
    ]

    opts = [strategy: :one_for_one, name: ElliTest.Supervisor]
    Supervisor.start_link(children, opts)
  end
end