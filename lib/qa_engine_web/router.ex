defmodule QaEngineWeb.Router do
  use QaEngineWeb, :router
  
  pipeline :browser do
    plug :accepts, ["html", "json"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug QaEngine.Auth
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", QaEngineWeb do
    pipe_through :browser
    
    get "/logout", SessionController, :delete
    get "/login", SessionController, :new
    get "/", PageController, :index
    resources "/users", UserController
    resources "/questions", QuestionController
    post "/questions/:id", QuestionController, :add_answer
    resources "/sessions", SessionController, only: [:new, :delete, :create], singleton: true
    post "/answer_like", AnswerLikeController, :like
    post "/answer_dislike", AnswerDislikeController, :dislike
    post "/answers", AnswerController, :like_answer
    delete "/answers", AnswerController, :delete
    get "/answers/:id/edit", AnswerController, :edit
    
  end

  # Other scopes may use custom stacks.
  # scope "/api", QaEngineWeb do
  # pipe_through :api
  # end
end
