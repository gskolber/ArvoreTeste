defmodule ChallengeWeb.Router do
  use ChallengeWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ChallengeWeb do
    pipe_through :api
    resources "/entities", EntitieController, only: [:index, :show, :create, :update, :delete]
  end

  scope "/api" do
    forward "/swagger", PhoenixSwagger.Plug.SwaggerUI,
    otp_app: :challenge,
    swagger_file: "swagger.json"
  end
  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: ChallengeWeb.Telemetry
    end
  end

  def swagger_info do
    %{
      schemes: ["http", "https"],
      info: %{
        version: "1.0",
        title: "Desafio Arvore",
        description: "Teste para backender jr - elixir.",
        contact: %{
          name: "Gabriel Kolber",
          email: "gabrielkolber@icloud.com"
        }
      },
      consumes: ["application/json"],
      produces: ["application/json"],

    }
  end
end
