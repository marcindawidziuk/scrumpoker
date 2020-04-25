defmodule ScrumpokerWeb.Router do
  use ScrumpokerWeb, :router

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

  scope "/", ScrumpokerWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/rick", PageController, :rick
    get "/landing/", PageController, :landing
    get "/:room/", PageController, :room
  end

  # Other scopes may use custom stacks.
  # scope "/api", ScrumpokerWeb do
  #   pipe_through :api
  # end
end
