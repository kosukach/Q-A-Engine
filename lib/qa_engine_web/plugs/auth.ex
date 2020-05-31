defmodule QaEngine.Auth do
    import Plug.Conn
    import Phoenix.Controller
    alias QaEngineWeb.Router.Helpers, as: Routes
    def init(opts), do: opts
        
    def call(conn, _opts) do
        user_id = get_session(conn, :user_id)
        user = user_id && QaEngine.Accounts.get_user!(user_id)
        assign(conn, :current_user, user)
    end

    def logged_in_user(conn = %{assigns: %{current_user: %{}}}, _opts), do: conn

    def logged_in_user(conn, _opts) do
        conn
        |> put_flash(:error, "Not logged in")
        |> redirect(to: Routes.session_path(conn, :new))
        |> halt()
    end

end