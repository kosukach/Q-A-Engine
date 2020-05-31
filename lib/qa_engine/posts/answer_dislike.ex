defmodule QaEngine.Posts.AnswerDislike do
  use Ecto.Schema
  import Ecto.Changeset

  schema "answer_dislikes" do
    belongs_to :user, QaEngine.Accounts.User
    belongs_to :answer, QaEngine.Posts.Answer

    timestamps()
  end

  @doc false
  def changeset(answer_dislike, attrs) do
    answer_dislike
    |> cast(attrs, [:user_id, :answer_id])
    |> validate_required([:user_id, :answer_id])
  end
end
