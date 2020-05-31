defmodule QaEngine.Posts.AnswerLike do
  use Ecto.Schema
  import Ecto.Changeset

  schema "answer_likes" do
    belongs_to :user, QaEngine.Accounts.User
    belongs_to :answer, QaEngine.Posts.Answer

    timestamps()
  end

  @doc false
  def changeset(answer_like, attrs) do
    answer_like
    |> cast(attrs, [:user_id, :answer_id])
    |> validate_required([:user_id, :answer_id])
  end
end
