defmodule Mbcs do
  @moduledoc """
  Wrapper for erlang-mbcs.
 
  Support encodings:
    :cp037,
    :cp437,
    :cp500,
    :cp737, :cp775,
    :cp850, :cp852, :cp855, :cp857, :cp860, :cp861, :cp862, :cp863, :cp864, :cp865, :cp866, :cp869, :cp874, :cp875,
    :cp932, :cp936, :gbk, :cp949, :cp950, :big5,
    :cp1026, :cp1250, :cp1251, :cp1252, :cp1253, :cp1254, :cp1255, :cp1256, :cp1257, :cp1258,
    :cp10000, :cp10006, :cp10007, :cp10029, :cp10079, :cp10081,
    :utf8, :utf16, :utf16le, :utf16be, :utf32, :utf32le, :utf32be
 
  Options:
    {:return, :list | :binary},
    {:error, :strict | :ignore | :replace},
    {:replace, non_neg_integer}
    {:bom, true | false}
 
  See https://code.google.com/p/erlang-mbcs/
  """

  @doc """
  Start mbcs server.
  """
  def start do
    :mbcs.start
  end
 
  @doc """
  Stop mbcs server.
  """
  def stop do
    :mbcs.stop
  end

  @doc """
  Convert utf-8 to some encoding.
  """
  def encode(str, encoding) do
    encode(str, encoding, [])
  end

  def encode(str, encoding, options) when is_bitstring(str) do
    encode(String.to_char_list!(str), encoding, options)
  end

  def encode(str, encoding, options) when is_list(str) do
    options = Dict.merge([return: :list, error: :strict], options)

    case :mbcs.encode(str, encoding, options) do
      {:error, reason} -> {:error, reason}
      result -> {:ok, result}
    end
  end

  def encode!(str, encoding) do
    encode!(str, encoding, [])
  end

  def encode!(str, encoding, options) when is_bitstring(str) do
    encode!(String.to_char_list!(str), encoding, options)
  end

  def encode!(str, encoding, options) when is_list(str) do
    options = Dict.merge([return: :list, error: :strict], options)

    case :mbcs.encode(str, encoding, options) do
      {:error, reason} -> raise inspect(reason)
      result -> result
    end
  end

  @doc """
  Convert some encoding to utf-8.
  """
  def decode(str, encoding) do
    decode(str, encoding, [])
  end

  def decode(str, encoding, options) when is_bitstring(str) do
    decode(String.to_char_list!(str), encoding, options)
  end

  def decode(str, encoding, options) when is_list(str) do
    options = Dict.merge([return: :binary, error: :strict], options)

    case :mbcs.decode(str, encoding, options) do
      {:error, reason} -> {:error, reason}
      result -> if options[:return] == :binary, do: String.from_char_list(result), else: {:ok, result}
    end
  end

  def decode!(str, encoding) do
    decode!(str, encoding, [])
  end

  def decode!(str, encoding, options) when is_bitstring(str) do
    decode!(String.to_char_list!(str), encoding, options)
  end

  def decode!(str, encoding, options) when is_list(str) do
    options = Dict.merge([return: :binary, error: :strict], options)

    case :mbcs.decode(str, encoding, options) do
      {:error, reason} -> raise inspect(reason)
      result -> if options[:return] == :binary, do: String.from_char_list!(result), else: result
    end
  end

  @doc """
  Convert some encoding to some encoding.
  """
  def from_to(str, from, to) do
    from_to(str, from, to, [])
  end

  def from_to(str, from, to, options) when is_list(str) do
    options = Dict.merge([return: :list, error: :strict], options)

    case :mbcs.from_to(str, from, to, options) do
      {:error, reason} -> {:error, reason}
      result -> {:ok, result}
    end
  end

  def from_to!(str, from, to) do
    from_to!(str, from, to, [])
  end

  def from_to!(str, from, to, options) when is_list(str) do
    options = Dict.merge([return: :list, error: :strict], options)

    case :mbcs.from_to(str, from, to, options) do
      {:error, reason} -> raise inspect(reason)
      result -> result
    end
  end
end
