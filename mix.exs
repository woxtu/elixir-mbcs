defmodule Mbcs.Mixfile do
  use Mix.Project

  def project do
    [ app: :"elixir-mbcs",
      version: "0.1.1",
      elixir: ">= 0.15.0",
      deps: deps ]
  end

  def application do
    []
  end

  defp deps do
    [{:mbcs, github: "rkfg/erlang-mbcs"}]
  end
end
