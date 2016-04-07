defmodule Idfk.Mixfile do
  use Mix.Project

  def project do
    [app: :idfk,
     version: "0.0.1",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    [
      {:earmark, "~> 0.1", only: :dev},
      {:espec, "~> 0.8.17", only: :test},
      {:ex_doc, "~> 0.11", only: :dev},
      {:timex, "~> 2.1.4"}
    ]
  end
end
