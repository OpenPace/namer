defmodule NamerWeb.Router do
  use NamerWeb, :router

  alias NamerWeb.Plug

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :authenicated do
    plug Plug.Auth
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/namer", NamerWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/namer", NamerWeb do
    pipe_through :browser
    pipe_through :authenicated

    get "/profile", ProfileController, :index
    put "/profile", ProfileController, :update
  end

  scope "/namer/auth", NamerWeb do
    pipe_through :browser

    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
    post "/:provider/callback", AuthController, :callback
    delete "/", AuthController, :delete
  end

  scope "/namer", NamerWeb do
    get "/webhook", WebhookController, :challenge
    post "/webhook", WebhookController, :webhook
  end
end
