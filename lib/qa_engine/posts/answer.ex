defmodule QaEngine.Posts.Answer do
  use Ecto.Schema
  import Ecto.Changeset
  alias QaEngine.Accounts.User 
  alias QaEngine.Posts.Question 
  schema "answers" do
    field :body, :string
    field :title, :string
    field :score, :integer, default: 0
    many_to_many :likes, User, join_through: "answer_likes"
    many_to_many :dislikes, User, join_through: "answer_dislikes"
    belongs_to :user, User
    belongs_to :question, Question
    timestamps()
  end

  @doc false
  def changeset(answer, attrs) do
    answer
    |> cast(attrs, [:title, :body, :user_id, :question_id, :score])
    |> validate_required([:title, :body, :user_id, :question_id, :score])
  end
end
