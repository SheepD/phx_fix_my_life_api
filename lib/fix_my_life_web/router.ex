defmodule FixMyLifeWeb.Router do
  use FixMyLifeWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", FixMyLifeWeb do
    pipe_through :api
    resources "/users", UserController, except: [:edit, :new]
    resources "/todos", ToDoListController, except: [:edit, :new] do
      resources "/items", ToDoItemController, except: [:edit, :new]
    end
  end
end
