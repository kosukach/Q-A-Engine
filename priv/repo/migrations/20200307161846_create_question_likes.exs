defmodule QaEngine.Repo.Migrations.CreateQuestionLikes do
  use Ecto.Migration

  def change do
    create table(:question_likes) do
      add :user_id, references(:users, on_delete: :nothing)
      add :question_id, references(:questions, on_delete: :nothing)

      timestamps()
    end

    create index(:question_likes, [:user_id])
    create index(:question_likes, [:question_id])
    create unique_index(:question_likes, [:question_id, :user_id])
  end
end
