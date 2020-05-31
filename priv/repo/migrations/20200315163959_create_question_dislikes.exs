defmodule QaEngine.Repo.Migrations.CreateQuestionDislikes do
  use Ecto.Migration

  def change do
    create table(:question_dislikes) do
      add :user_id, references(:users, on_delete: :delete_all)
      add :question_id, references(:questions, on_delete: :delete_all)

      timestamps()
    end

    create index(:question_dislikes, [:user_id])
    create index(:question_dislikes, [:question_id])
    create unique_index(:question_dislikes, [:question_id, :user_id])
  end
end
