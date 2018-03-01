defmodule FixMyLifeWeb.Router do
  use FixMyLifeWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", FixMyLifeWeb do
    pipe_through :api
  end
end
