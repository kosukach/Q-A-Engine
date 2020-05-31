defmodule QaEngine.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :username, :string
    has_one :credential, QaEngine.Accounts.Credential
    has_many :questions, QaEngine.Posts.Question
    has_many :answers, QaEngine.Posts.Answer
    many_to_many :liked_questions, QaEngine.Posts.Question, join_through: "question_likes"
    many_to_many :disliked_questions, QaEngine.Posts.Question, join_through: "question_dislikes"
    many_to_many :liked_answers, QaEngine.Posts.Answer, join_through: "answer_likes"
    many_to_many :disliked_answers, QaEngine.Posts.Answer, join_through: "answer_dislikes"
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username])
    |> validate_required([:username])
    |> unique_constraint(:username)
  end
end
