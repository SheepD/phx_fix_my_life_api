defmodule FixMyLifeWeb.UserView do
  use FixMyLifeWeb, :view
  alias FixMyLifeWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      email: user.email,
      name: user.name,
      token: user.token,
      token_expiration: user.token_expiration}
  end
end
