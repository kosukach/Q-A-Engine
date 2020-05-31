defmodule QaEngineWeb.QuestionController do
  use QaEngineWeb, :controller

  alias QaEngine.Posts
  alias QaEngine.Posts.Question
  alias QaEngine.Posts.Answer
  import QaEngine.Auth, only: [logged_in_user: 2]
  plug :logged_in_user

  def index(conn, _params) do
    questions = Posts.list_questions()
    render(conn, "index.html", questions: questions)
  end
  
  def new(conn, _params) do
    changeset = Posts.change_question(%Question{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"question" => question_params}) do
    
    user_id = conn.assigns.current_user.id
    
    case Posts.create_question(Map.put(question_params, "user_id", user_id)) do
      {:ok, question} ->
        conn
        |> put_flash(:info, "Question created successfully.")
        |> redirect(to: Routes.question_path(conn, :show, question))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    changeset = Posts.change_answer(%Answer{})
    question = Posts.get_question!(id)
    render(conn, "show.html", [question: question, changeset: changeset])
  end

  def edit(conn, %{"id" => id}) do
    question = Posts.get_question!(id)
    changeset = Posts.change_question(question)
    render(conn, "edit.html", question: question, changeset: changeset)
  end

  def update(conn, %{"id" => id, "question" => question_params}) do
    question = Posts.get_question!(id)

    case Posts.update_question(question, question_params) do
      {:ok, question} ->
        conn
        |> put_flash(:info, "Question updated successfully.")
        |> redirect(to: Routes.question_path(conn, :show, question))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", question: question, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    question = Posts.get_question!(id)
    {:ok, _question} = Posts.delete_question(question)
  
    conn
    |> put_flash(:info, "Question deleted successfully.")
    |> redirect(to: Routes.question_path(conn, :index))
  end

  def add_answer(conn, %{"answer"=> answer, "id" => question_id}) do
    user_id = conn.assigns.current_user.id
    answer_params = %{
      title: answer["title"],
      body: answer["body"],
      user_id: user_id,
      question_id: question_id
    }

    case Posts.create_answer(answer_params) do 
      {:ok, _answer} ->
        
        conn
        |> put_flash(:info, "Answer created successfully")
        |> redirect(to: Routes.question_path(conn, :show, question_id))

      {:error, _} ->
        conn
        |> put_flash(:error, "Failed to create answer")
        |> redirect(to: Routes.question_path(conn, :show, question_id))
    
    end
    
  end
end
