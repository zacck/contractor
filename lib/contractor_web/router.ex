defmodule ContractorWeb.Router do
  use ContractorWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
    plug(ContractorWeb.Context)
  end

  scope "/api" do
    pipe_through(:api)

    forward("/graph", Absinthe.Plug.GraphiQL, schema: ContractorWeb.Schema)
  end

  scope "/", ContractorWeb do
    # Use the default browser stack
    pipe_through(:browser)

    get("/*path", PageController, :index)
  end

  # Other scopes may use custom stacks.
  # scope "/api", ContractorWeb do
  #   pipe_through :api
  # end
end
