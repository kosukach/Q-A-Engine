defmodule QaEngine.Repo.Migrations.CreateAnswerDislikes do
  use Ecto.Migration

  def change do
    create table(:answer_dislikes) do
      add :user_id, references(:users, on_delete: :delete_all)
      add :answer_id, references(:answers, on_delete: :delete_all)

      timestamps()
    end

    create index(:answer_dislikes, [:user_id])
    create index(:answer_dislikes, [:answer_id])
    create unique_index(:answer_dislikes, [:answer_id, :user_id])
  end
end
