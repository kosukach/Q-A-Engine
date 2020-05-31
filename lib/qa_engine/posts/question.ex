defmodule QaEngine.Posts.Question do
  use Ecto.Schema
  import Ecto.Changeset
  alias QaEngine.Accounts.User
  alias QaEngine.Posts.Answer
  schema "questions" do
    field :body, :string
    field :title, :string
    field :score, :integer, default: 0
    many_to_many :likes, User, join_through: "question_likes"
    many_to_many :dislikes, User, join_through: "question_likes"
    belongs_to :user, User
    has_many :answers, Answer

    timestamps()
  end

  @doc false
  def changeset(question, attrs) do
    question
    |> cast(attrs, [:title, :body, :user_id])
    |> validate_required([:title, :body, :user_id])
  end
end
