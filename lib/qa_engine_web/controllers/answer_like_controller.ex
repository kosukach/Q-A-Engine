defmodule QaEngineWeb.AnswerLikeController do
    
    use QaEngineWeb, :controller
    alias QaEngine.Posts
    

    def create(conn, %{"answer_id" => answer_id, "question_id" => question_id, "user_id" => user_id}) do
        
        answer_like_params = %{
            user_id: String.to_integer(user_id),
            answer_id: String.to_integer(answer_id)
        }
        
        case Posts.create_answer_like(answer_like_params) do 
            {:ok, _answer_like} -> conn
              
           {:error, _} ->
                conn
                |> put_flash(:error, "Failed to create answer_like")
                |> redirect(to: Routes.question_path(conn, :show, question_id))
            
        end
    end

    def delete(conn, %{"answer_id" => answer_id, "question_id" => question_id, "user_id" => user_id}) do
        answer_like = Posts.get_answer_like(answer_id, user_id)
        case Posts.delete_answer_like(answer_like) do
            {:ok, _} -> conn
            
            {:error, _} ->
                conn
                |> put_flash(:error, "Failed to delete answer_like")
                |> redirect(to: Routes.question_path(conn, :show, question_id))
        end


    end


end