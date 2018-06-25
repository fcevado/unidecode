defmodule Unidecode.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      supervisor(ConCache, [name: :unidecode]),
      supervisor(Task.Supervisor, [[name: Unidecode.DataLoad.Supervisor]], [restart: :temporary]),
      worker(Task, [Unidecode.DataLoad, :task, []], [restart: :temporary])
    ]

    opts = [strategy: :one_for_one, name: Unidecode.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
