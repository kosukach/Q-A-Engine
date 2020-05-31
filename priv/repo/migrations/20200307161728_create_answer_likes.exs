defmodule QaEngine.Repo.Migrations.CreateAnswerLikes do
  use Ecto.Migration

  def change do
    create table(:answer_likes) do
      add :user_id, references(:users, on_delete: :delete_all)
      add :answer_id, references(:answers, on_delete: :delete_all)

      timestamps()
    end

    create index(:answer_likes, [:user_id])
    create index(:answer_likes, [:answer_id])
    create unique_index(:answer_likes, [:answer_id, :user_id])

  end
end
