defmodule Mbcs.Mixfile do
  use Mix.Project

  def project do
    [ app: :"elixir-mbcs",
      version: "0.0.1",
      elixir: "~> 0.15.1",
      deps: deps ]
  end

  def application do
    []
  end

  defp deps do
    [{:mbcs, github: "rkfg/erlang-mbcs"}]
  end
end
