defmodule QaEngine.Repo.Migrations.CreateAnswers do
  use Ecto.Migration

  def change do
    create table(:answers) do
      add :title, :string
      add :body, :text
      add :score, :integer
      add :user_id, references(:users, on_delete: :nothing)
      add :question_id, references(:questions, on_delete: :nothing)
      
      timestamps()
    end

    create index(:answers, [:user_id])
    create index(:answers, [:question_id])
  end
end
