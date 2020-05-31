defmodule QaEngineWeb.AnswerController do
    use QaEngineWeb, :controller
    alias QaEngineWeb.AnswerControllerHelper, as: Helper
    alias QaEngine.Posts
    import QaEngine.Auth, only: [logged_in_user: 2]
    plug :logged_in_user 
    
    def like_answer(conn, %{"answer_id" => answer_id, "action" => action} = opts) do
        
        answer = Posts.get_answer!(answer_id)
        answer_params = Map.from_struct(answer)
        
        opts_append = %{
            "answer" => answer,
            "answer_params" => answer_params
        }
        
        case action do
            "like" -> Helper.do_like_answer(conn, Map.merge(opts, opts_append))
            "dislike" -> Helper.do_dislike_answer(conn, Map.merge(opts, opts_append))
        end
                
    end
            
    def delete(conn, %{"id" => id}) do
        answer = Posts.get_answer!(id)
        {:ok, _answer} = Posts.delete_answer(answer)

        conn
        |> json(%{
            result: "success"
        })
    end

    def edit(conn, %{"id" => id}) do
        
        answer = Posts.get_answer!(id)
        changeset = Posts.change_answer(answer)
        render(conn, "edit.html", answer: answer, changeset: changeset)
    end
    
end    