defmodule QaEngineWeb.AnswerControllerHelper do
    use QaEngineWeb, :controller
    alias QaEngine.Posts
    alias QaEngineWeb.{AnswerDislikeController, AnswerLikeController}
    def do_like_answer(conn, %{"status"=> "like"} = opts) do
        
        new_score = increment_score(conn, -1, opts)
        conn
        |> AnswerLikeController.delete(opts)
        |> json(%{
            result: "success",
            new_score: new_score
            })
    end
    
    def do_like_answer(conn, %{"status"=> "dislike"} = opts) do
        new_score = increment_score(conn, 2, opts)
        conn
        |> AnswerDislikeController.delete(opts)
        |> AnswerLikeController.create(opts)
        |> json(%{
            result: "success",
            new_score: new_score
            })
    end
    
    def do_like_answer(conn, %{"status"=> "neither"} = opts) do
        new_score = increment_score(conn, 1, opts)
        conn
        |> AnswerLikeController.create(opts)
        |> json(%{
            result: "success",
            new_score: new_score
            })
    end
    
    def do_like_answer(conn, _) do
        conn
        |> render("500.html")
    end
    
    def do_dislike_answer(conn, %{"status"=> "dislike"} = opts) do
        new_score = increment_score(conn, 1, opts)
        conn
        |> AnswerDislikeController.delete(opts)
        |> json(%{
            result: "success",
            new_score: new_score
            })
    end
    
    def do_dislike_answer(conn, %{"status"=> "like"} = opts) do
        new_score = increment_score(conn, -2, opts)
        conn
        |> AnswerLikeController.delete(opts)
        |> AnswerDislikeController.create(opts)
        |> json(%{
            result: "success",
            new_score: new_score,
            num: -2
            })
    end
    
    def do_dislike_answer(conn, %{"status"=> "neither"} = opts) do
        new_score = increment_score(conn, -1, opts)
        conn
        |> AnswerDislikeController.create(opts)
        |> json(%{
            result: "success",
            new_score: new_score
            })
    end

    def do_dislike_answer(conn, _) do
        conn
        |> render("500.html")
    end
    
    def increment_score(conn, num, %{"question_id" => question_id, "answer_params" => answer_params, "answer" => answer}) do
    
        new_score = answer_params.score + num
        answer_params_new = Map.replace!(answer_params, :score, new_score)
        case Posts.update_answer(answer, answer_params_new) do
            {:ok, _} ->
                new_score
            {:error, _} ->
                conn
                |> put_flash(:error, "Failed increment score")
                |> redirect(to: Routes.question_path(conn, :show, question_id))
        end    
        
    end
end