defmodule QaEngine.Repo do
  use Ecto.Repo,  
    otp_app: :qa_engine,
    adapter: Ecto.Adapters.Postgres
end
