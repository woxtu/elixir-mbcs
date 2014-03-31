defmodule Mbcs do
  def start do
    :mbcs.start
  end
 
  def stop do
    :mbcs.stop
  end

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
