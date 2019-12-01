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

  scope "/", NamerWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/profile", NamerWeb do
    pipe_through :browser
    pipe_through :authenicated

    get "/", ProfileController, :index
    put "/", ProfileController, :update
  end

  scope "/auth", NamerWeb do
    pipe_through :browser

    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
    post "/:provider/callback", AuthController, :callback
    delete "/", AuthController, :delete
  end

  scope "/webhook", NamerWeb do
    get "/", WebhookController, :challenge
    post "/", WebhookController, :webhook
  end
end
