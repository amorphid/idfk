defmodule Idfk.Mixfile do
  use Mix.Project

  def application do
    [applications: [:logger]]
  end

  def project do
    [
      app:              :idfk,
      build_embedded:   Mix.env == :prod,
      description:      description,
      deps:             deps,
      elixir:           "~> 1.2",
      package:          package,
      start_permanent:  Mix.env == :prod,
      version:          "0.0.1"
    ]
  end

  defp deps do
    [
      {:earmark, "~> 0.1", only: :dev},
      {:espec, "~> 0.8.17", only: :test},
      {:ex_doc, "~> 0.11", only: :dev},
      {:timex, "~> 2.1.4"}
    ]
  end

  defp description do
    """
    The library of Elixir chunks of code that didn't clearly belong anywhere else.
    """
  end

  defp package do
    [
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/amorphid/idfk"},
      maintainers: ["Michael Pope"]
    ]
  end
end
