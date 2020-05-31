defmodule QaEngine.Posts.QuestionLike do
  use Ecto.Schema
  import Ecto.Changeset

  schema "question_likes" do
    belongs_to :user, QaEngine.Accounts.User
    belongs_to :question, QaEngine.Posts.Question

    timestamps()
  end

  @doc false
  def changeset(question_like, attrs) do
    question_like
    |> cast(attrs, [:user_id, :quesion_id])
    |> validate_required([:user_id, :quesion_id])
  end
end
