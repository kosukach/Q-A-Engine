defmodule QaEngine.Posts.QuestionDislike do
  use Ecto.Schema
  import Ecto.Changeset

  schema "question_dislikes" do
    belongs_to :user, QaEngine.Accounts.User
    belongs_to :question, QaEngine.Posts.Question
    
    timestamps()
  end

  @doc false
  def changeset(question_dislike, attrs) do
    question_dislike
    |> cast(attrs, [:user_id, :quesion_id])
    |> validate_required([:user_id, :quesion_id])
  end
end
