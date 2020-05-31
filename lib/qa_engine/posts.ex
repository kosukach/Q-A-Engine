defmodule QaEngine.Posts do
  @moduledoc """
  The Posts context.
  """

  import Ecto.Query, warn: false
  alias QaEngine.Repo

  alias QaEngine.Posts.Question
  alias QaEngine.Posts.Answer
  alias QaEngine.Posts.AnswerLike
  @doc """
  Returns the list of questions.

  ## Examples

      iex> list_questions()
      [%Question{}, ...]

  """
  def list_questions do
    Repo.all(Question)
  end

  @doc """
  Gets a single question.

  Raises `Ecto.NoResultsError` if the Question does not exist.

  ## Examples

      iex> get_question!(123)
      %Question{}

      iex> get_question!(456)
      ** (Ecto.NoResultsError)

  """
  def get_question!(id) do
    
    Repo.get!(Question, id)
    |> Repo.preload([answers: [:user, :likes, :dislikes]])
    |> Repo.preload([:user, :likes, :dislikes])
    
  end 
  @doc """
  Creates a question.

  ## Examples

      iex> create_question(%{field: value})
      {:ok, %Question{}}

      iex> create_question(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_question(attrs \\ %{}) do
    %Question{}
    |> Question.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a question.

  ## Examples

      iex> update_question(question, %{field: new_value})
      {:ok, %Question{}}

      iex> update_question(question, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_question(%Question{} = question, attrs) do
    question
    |> Question.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a question.

  ## Examples

      iex> delete_question(question)
      {:ok, %Question{}}

      iex> delete_question(question)
      {:error, %Ecto.Changeset{}}

  """
  def delete_question(%Question{} = question) do
    Repo.delete(question)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking question changes.

  ## Examples

      iex> change_question(question)
      %Ecto.Changeset{source: %Question{}}

  """
  def change_question(%Question{} = question) do
    Question.changeset(question, %{})
  end

  

  @doc """
  Returns the list of answers.

  ## Examples

      iex> list_answers()
      [%Answer{}, ...]

  """
  def list_answers do
    Repo.all(Answer)
  end

  @doc """
  Gets a single answer.

  Raises `Ecto.NoResultsError` if the Answer does not exist.

  ## Examples

      iex> get_answer!(123)
      %Answer{}

      iex> get_answer!(456)
      ** (Ecto.NoResultsError)

  """
  def get_answer!(id) do
     Repo.get!(Answer, id)
     |> Repo.preload([:user, :question, :likes, :dislikes])
  end

  @doc """
  Creates a answer.

  ## Examples

      iex> create_answer(%{field: value})
      {:ok, %Answer{}}

      iex> create_answer(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_answer(attrs \\ %{}) do
    %Answer{}
    |> Answer.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a answer.

  ## Examples

      iex> update_answer(answer, %{field: new_value})
      {:ok, %Answer{}}

      iex> update_answer(answer, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_answer(%Answer{} = answer, attrs) do
    answer
    |> Answer.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a answer.

  ## Examples

      iex> delete_answer(answer)
      {:ok, %Answer{}}

      iex> delete_answer(answer)
      {:error, %Ecto.Changeset{}}

  """
  def delete_answer(%Answer{} = answer) do
    Repo.delete(answer)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking answer changes.

  ## Examples

      iex> change_answer(answer)
      %Ecto.Changeset{source: %Answer{}}

  """
  def change_answer(%Answer{} = answer) do
    Answer.changeset(answer, %{})
  end

  alias QaEngine.Posts.AnswerLike

  def get_answer_like(answer_id, user_id) do
      Repo.get_by!(AnswerLike, [answer_id: answer_id, user_id: user_id])
  end

  def create_answer_like(attrs \\ %{}) do
    %AnswerLike{}
    |> AnswerLike.changeset(attrs)
    |> Repo.insert()
  end
  
  def list_answer_likes do
    Repo.all(AnswerLike)
  end
  
  def delete_answer_like(%AnswerLike{} = answer_like) do
    Repo.delete(answer_like)
  end
  alias QaEngine.Posts.AnswerDislike
  
  def get_answer_dislike(answer_id, user_id) do
    Repo.get_by!(AnswerDislike, [answer_id: answer_id, user_id: user_id])
  end

  def create_answer_dislike(attrs \\ %{}) do
    %AnswerDislike{}
    |> AnswerDislike.changeset(attrs)
    |> Repo.insert()
  end
  
  def list_answer_dislikes do
    Repo.all(AnswerDislike)
  end
  
  def delete_answer_dislike(%AnswerDislike{} = answer_dislike) do
    Repo.delete(answer_dislike)
  end
end
