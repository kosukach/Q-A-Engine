defmodule QaEngineWeb.AnswerDislikeController do
    
    use QaEngineWeb, :controller
    alias QaEngine.Posts
    

    def create(conn,  %{"answer_id" => answer_id, "question_id" => question_id, "user_id" => user_id}) do
        answer_dislike_params = %{
            user_id: String.to_integer(user_id),
            answer_id: String.to_integer(answer_id)
        }
        
            case Posts.create_answer_dislike(answer_dislike_params) do 
            {:ok, _answer_dislike} -> conn
              
      
            {:error, _} ->
                conn
                |> put_flash(:error, "Failed to create answer_dislike")
                |> redirect(to: Routes.question_path(conn, :show, question_id))
              
        end
    end

    def delete(conn, %{"answer_id" => answer_id, "question_id" => question_id, "user_id" => user_id}) do
        answer_dislike = Posts.get_answer_dislike(answer_id, user_id)
        case Posts.delete_answer_dislike(answer_dislike) do
            {:ok, _} -> conn
            {:error, _} ->
                conn
                |> put_flash(:error, "Failed to delete answer_dislike")
                |> redirect(to: Routes.question_path(conn, :show, question_id))
        end
    end


end