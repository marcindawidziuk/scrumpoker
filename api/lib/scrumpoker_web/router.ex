defmodule ScrumPokerWeb.Router do
  use ScrumPokerWeb, :router
  import Plug.BasicAuth
  import Phoenix.LiveDashboard.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :admins_only do
    plug :basic_auth, username: "admin", password: System.get_env("ADMIN_PASSWORD") || "password"
  end

  scope "/" do
    pipe_through [:browser, :admins_only]
    live_dashboard "/dashboard"
  end

  scope "/", ScrumPokerWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/landing/", PageController, :landing
    get "/:room/", PageController, :room
  end

  # Other scopes may use custom stacks.
  # scope "/api", ScrumPokerWeb do
  #   pipe_through :api
  # end
end
