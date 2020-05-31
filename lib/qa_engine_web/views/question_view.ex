defmodule QaEngineWeb.QuestionView do
  use QaEngineWeb, :view

  def current_user_liked?(user_id, answer) do

    likes_id = Enum.map(answer.likes, fn user -> user.id end)
    dislikes_id = Enum.map(answer.dislikes, fn user -> user.id end)
    case {Enum.member?(likes_id, user_id), Enum.member?(dislikes_id, user_id)} do
      {true, false} -> "like"
      {false, true} -> "dislike"
      {false, false} -> "neither"
    end
    
  end

  def get_like_src("like") do
    "/images/like-arrow.png"
  end

  def get_like_src(_) do
    "/images/white-like-arrow.png"
  end
  def get_dislike_src("dislike") do
    "/images/dislike-arrow.png"
  end

  def get_dislike_src(_) do
    "/images/white-dislike-arrow.png"
  end

  def current_user_is_author(answer, user_id) do
    answer.user.id == user_id
  end
end
