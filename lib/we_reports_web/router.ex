defmodule WeReportsWeb.Router do
  use WeReportsWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :fetch_live_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug WeReports.UserManager.Pipeline
  end

  # We use ensure_auth to fail if there is no one logged in
  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end

  # Maybe logged in routes
  scope "/", WeReportsWeb do
    pipe_through [:browser, :auth]

    get "/", PageController, :index

    get "/login", SessionController, :new
    post "/login", SessionController, :login
    get "/logout", SessionController, :logout
  end

  scope "/", WeReportsWeb do
    pipe_through [:browser, :auth, :ensure_auth]
    resources "/groups", GroupController do
      resources "/propositions", PropositionController
    end
    live "/daily_reports/new", DailyReports.New
    resources "/daily_reports", DailyReportController, only: [:index, :show, :delete]
    resources "/articles", ArticleController, except: [:new, :edit]
  end

  # Other scopes may use custom stacks.
  # scope "/api", WeReportsWeb do
  #   pipe_through :api
  # end
end
