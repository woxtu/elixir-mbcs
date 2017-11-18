defmodule Mbcs.Mixfile do
  use Mix.Project

  def project do
    [ app: :elixir_mbcs,
      version: "0.1.3",
      elixir: "~> 1.0",
      description: "Convert the character encoding",
      package: [
        contributors: ["woxtu"],
        licenses: ["MIT"],
        links: %{"GitHub" => "https://github.com/woxtu/elixir-mbcs"}
      ],
      deps: deps()
    ]
  end

  def application do
    []
  end

  defp deps do
    [{:mbcs, github: "nekova/erlang-mbcs"}]
  end
end
