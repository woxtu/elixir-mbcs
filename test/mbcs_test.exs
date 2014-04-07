defmodule MbcsTest do
  use ExUnit.Case

  test "encode/2" do
    assert Mbcs.encode('九条カレン', :cp932) == {:ok, <<139, 227, 143, 240, 131, 74, 131, 140, 131, 147>>}
    assert Mbcs.encode("九条カレン", :cp932) == {:ok, <<139, 227, 143, 240, 131, 74, 131, 140, 131, 147>>}

    assert Mbcs.encode('\xff', :cp932) == {:error, {:unmapping_unicode, [unicode: 255, pos: 1]}}
    assert Mbcs.encode(<<255>>, :cp932) == {:error, {:unmapping_unicode, [unicode: 255, pos: 1]}}
  end

  test "encode/3" do
    assert Mbcs.encode('九条カレン', :cp932, return: :list) == {:ok, [139, 227, 143, 240, 131, 74, 131, 140, 131, 147]}
    assert Mbcs.encode('九条カレン', :cp932, return: :binary) == {:ok, <<139, 227, 143, 240, 131, 74, 131, 140, 131, 147>>}
    assert Mbcs.encode("九条カレン", :cp932, return: :list) == {:ok, [139, 227, 143, 240, 131, 74, 131, 140, 131, 147]}
    assert Mbcs.encode("九条カレン", :cp932, return: :binary) == {:ok, <<139, 227, 143, 240, 131, 74, 131, 140, 131, 147>>}

    assert Mbcs.encode('\xff', :cp932, error: :strict) == {:error, {:unmapping_unicode, [unicode: 255, pos: 1]}}
    assert Mbcs.encode('\xff', :cp932, error: :ignore) == {:ok, ""}
    assert Mbcs.encode(<<255>>, :cp932, error: :strict) == {:error, {:unmapping_unicode, [unicode: 255, pos: 1]}}
    assert Mbcs.encode(<<255>>, :cp932, error: :ignore) == {:ok, ""}
  end

  test "encode!/2" do
    assert Mbcs.encode!('九条カレン', :cp932) == <<139, 227, 143, 240, 131, 74, 131, 140, 131, 147>>
    assert Mbcs.encode!("九条カレン", :cp932) == <<139, 227, 143, 240, 131, 74, 131, 140, 131, 147>>

    assert_raise RuntimeError, "{:unmapping_unicode, [unicode: 255, pos: 1]}", fn ->
      Mbcs.encode!('\xff', :cp932)
    end
    assert_raise RuntimeError, "{:unmapping_unicode, [unicode: 255, pos: 1]}", fn ->
      Mbcs.encode!(<<255>>, :cp932)
    end
  end

  test "encode!/3" do
    assert Mbcs.encode!('九条カレン', :cp932, return: :list) == [139, 227, 143, 240, 131, 74, 131, 140, 131, 147]
    assert Mbcs.encode!('九条カレン', :cp932, return: :binary) == <<139, 227, 143, 240, 131, 74, 131, 140, 131, 147>>
    assert Mbcs.encode!("九条カレン", :cp932, return: :list) == [139, 227, 143, 240, 131, 74, 131, 140, 131, 147]
    assert Mbcs.encode!("九条カレン", :cp932, return: :binary) == <<139, 227, 143, 240, 131, 74, 131, 140, 131, 147>>

    assert_raise RuntimeError, "{:unmapping_unicode, [unicode: 255, pos: 1]}", fn ->
      Mbcs.encode!('\xff', :cp932, error: :strict)
    end
    assert Mbcs.encode!('\xff', :cp932, error: :ignore) == ""
    assert_raise RuntimeError, "{:unmapping_unicode, [unicode: 255, pos: 1]}", fn ->
      Mbcs.encode!(<<255>>, :cp932, error: :strict)
    end
    assert Mbcs.encode!(<<255>>, :cp932, error: :ignore) == ""
  end

  test "decode/2" do
    assert Mbcs.decode([139, 227, 143, 240, 131, 74, 131, 140, 131, 147], :cp932) == {:ok, "九条カレン"}
    assert Mbcs.decode(<<139, 227, 143, 240, 131, 74, 131, 140, 131, 147>>, :cp932) == {:ok, "九条カレン"}

    assert Mbcs.decode([255], :cp932) == {:error, {:undefined_character, [character: 255, pos: 1]}}
    assert Mbcs.decode(<<255>>, :cp932) == {:error, {:undefined_character, [character: 255, pos: 1]}}
  end

  test "decode/3" do
    assert Mbcs.decode([139, 227, 143, 240, 131, 74, 131, 140, 131, 147], :cp932, return: :list) == {:ok, '九条カレン'}
    assert Mbcs.decode([139, 227, 143, 240, 131, 74, 131, 140, 131, 147], :cp932, return: :binary) == {:ok, "九条カレン"}
    assert Mbcs.decode(<<139, 227, 143, 240, 131, 74, 131, 140, 131, 147>>, :cp932, return: :list) == {:ok, '九条カレン'}
    assert Mbcs.decode(<<139, 227, 143, 240, 131, 74, 131, 140, 131, 147>>, :cp932, return: :binary) == {:ok, "九条カレン"}

    assert Mbcs.decode([255], :cp932, error: :strict) == {:error, {:undefined_character, [character: 255, pos: 1]}}
    assert Mbcs.decode([255], :cp932, error: :ignore) == {:ok, ""}
    assert Mbcs.decode(<<255>>, :cp932, error: :strict) == {:error, {:undefined_character, [character: 255, pos: 1]}}
    assert Mbcs.decode(<<255>>, :cp932, error: :ignore) == {:ok, ""}
  end

  test "decode!/2" do
    assert Mbcs.decode!([139, 227, 143, 240, 131, 74, 131, 140, 131, 147], :cp932) == "九条カレン"
    assert Mbcs.decode!(<<139, 227, 143, 240, 131, 74, 131, 140, 131, 147>>, :cp932) == "九条カレン"

    assert_raise RuntimeError, "{:undefined_character, [character: 255, pos: 1]}", fn ->
      Mbcs.decode!([255], :cp932)
    end
    assert_raise RuntimeError, "{:undefined_character, [character: 255, pos: 1]}", fn ->
      Mbcs.decode!(<<255>>, :cp932)
    end
  end

  test "decode!/3" do
    assert Mbcs.decode!([139, 227, 143, 240, 131, 74, 131, 140, 131, 147], :cp932, return: :list) == '九条カレン'
    assert Mbcs.decode!([139, 227, 143, 240, 131, 74, 131, 140, 131, 147], :cp932, return: :binary) == "九条カレン"
    assert Mbcs.decode!(<<139, 227, 143, 240, 131, 74, 131, 140, 131, 147>>, :cp932, return: :list) == '九条カレン'
    assert Mbcs.decode!(<<139, 227, 143, 240, 131, 74, 131, 140, 131, 147>>, :cp932, return: :binary) == "九条カレン"

    assert_raise RuntimeError, "{:undefined_character, [character: 255, pos: 1]}", fn ->
      Mbcs.decode!([255], :cp932, error: :strict)
    end
    assert Mbcs.decode!([255], :cp932, error: :ignore) == ""
    assert_raise RuntimeError, "{:undefined_character, [character: 255, pos: 1]}", fn ->
      Mbcs.decode!(<<255>>, :cp932, error: :strict)
    end
    assert Mbcs.decode!(<<255>>, :cp932, error: :ignore) == ""
  end

  test "from_to/3" do
    assert Mbcs.from_to([228, 185, 157, 230, 157, 161, 227, 130, 171, 227, 131, 172, 227, 131, 179], :utf8, :cp932)
      == {:ok, <<139, 227, 143, 240, 131, 74, 131, 140, 131, 147>>}
    assert Mbcs.from_to([139, 227, 143, 240, 131, 74, 131, 140, 131, 147], :cp932, :utf8)
      == {:ok, <<228, 185, 157, 230, 157, 161, 227, 130, 171, 227, 131, 172, 227, 131, 179>>}
    assert Mbcs.from_to(<<228, 185, 157, 230, 157, 161, 227, 130, 171, 227, 131, 172, 227, 131, 179>>, :utf8, :cp932)
      == {:ok, <<139, 227, 143, 240, 131, 74, 131, 140, 131, 147>>}
    assert Mbcs.from_to(<<139, 227, 143, 240, 131, 74, 131, 140, 131, 147>>, :cp932, :utf8)
      == {:ok, <<228, 185, 157, 230, 157, 161, 227, 130, 171, 227, 131, 172, 227, 131, 179>>}

    assert Mbcs.from_to('\xff', :cp932, :utf8) == {:error, {:undefined_character, [character: 255, pos: 1]}}
    assert Mbcs.from_to(<<255>>, :cp932, :utf8) == {:error, {:undefined_character, [character: 255, pos: 1]}}
  end

  test "from_to/4" do
    assert Mbcs.from_to([228, 185, 157, 230, 157, 161, 227, 130, 171, 227, 131, 172, 227, 131, 179], :utf8, :cp932, return: :list)
      == {:ok, [139, 227, 143, 240, 131, 74, 131, 140, 131, 147]}
    assert Mbcs.from_to([228, 185, 157, 230, 157, 161, 227, 130, 171, 227, 131, 172, 227, 131, 179], :utf8, :cp932, return: :binary)
      == {:ok, <<139, 227, 143, 240, 131, 74, 131, 140, 131, 147>>}
    assert Mbcs.from_to([139, 227, 143, 240, 131, 74, 131, 140, 131, 147], :cp932, :utf8, return: :list)
      == {:ok, [228, 185, 157, 230, 157, 161, 227, 130, 171, 227, 131, 172, 227, 131, 179]}
    assert Mbcs.from_to([139, 227, 143, 240, 131, 74, 131, 140, 131, 147], :cp932, :utf8, return: :binary)
      == {:ok, <<228, 185, 157, 230, 157, 161, 227, 130, 171, 227, 131, 172, 227, 131, 179>>}
    assert Mbcs.from_to(<<228, 185, 157, 230, 157, 161, 227, 130, 171, 227, 131, 172, 227, 131, 179>>, :utf8, :cp932, return: :list)
      == {:ok, [139, 227, 143, 240, 131, 74, 131, 140, 131, 147]}
    assert Mbcs.from_to(<<228, 185, 157, 230, 157, 161, 227, 130, 171, 227, 131, 172, 227, 131, 179>>, :utf8, :cp932, return: :binary)
      == {:ok, <<139, 227, 143, 240, 131, 74, 131, 140, 131, 147>>}
    assert Mbcs.from_to(<<139, 227, 143, 240, 131, 74, 131, 140, 131, 147>>, :cp932, :utf8, return: :list)
      == {:ok, [228, 185, 157, 230, 157, 161, 227, 130, 171, 227, 131, 172, 227, 131, 179]}
    assert Mbcs.from_to(<<139, 227, 143, 240, 131, 74, 131, 140, 131, 147>>, :cp932, :utf8, return: :binary)
      == {:ok, <<228, 185, 157, 230, 157, 161, 227, 130, 171, 227, 131, 172, 227, 131, 179>>}

    assert Mbcs.from_to('\xff', :cp932, :utf8, error: :strict) == {:error, {:undefined_character, [character: 255, pos: 1]}}
    assert Mbcs.from_to('\xff', :cp932, :utf8, error: :ignore) == {:ok, ""}
    assert Mbcs.from_to(<<255>>, :cp932, :utf8, error: :strict) == {:error, {:undefined_character, [character: 255, pos: 1]}}
    assert Mbcs.from_to(<<255>>, :cp932, :utf8, error: :ignore) == {:ok, ""}
  end

  test "from_to!/3" do
    assert Mbcs.from_to!([228, 185, 157, 230, 157, 161, 227, 130, 171, 227, 131, 172, 227, 131, 179], :utf8, :cp932)
      == <<139, 227, 143, 240, 131, 74, 131, 140, 131, 147>>
    assert Mbcs.from_to!([139, 227, 143, 240, 131, 74, 131, 140, 131, 147], :cp932, :utf8)
      == <<228, 185, 157, 230, 157, 161, 227, 130, 171, 227, 131, 172, 227, 131, 179>>
    assert Mbcs.from_to!(<<228, 185, 157, 230, 157, 161, 227, 130, 171, 227, 131, 172, 227, 131, 179>>, :utf8, :cp932)
      == <<139, 227, 143, 240, 131, 74, 131, 140, 131, 147>>
    assert Mbcs.from_to!(<<139, 227, 143, 240, 131, 74, 131, 140, 131, 147>>, :cp932, :utf8)
      == <<228, 185, 157, 230, 157, 161, 227, 130, 171, 227, 131, 172, 227, 131, 179>>

    assert_raise RuntimeError, "{:undefined_character, [character: 255, pos: 1]}", fn ->
      Mbcs.from_to!('\xff', :cp932, :utf8)
    end
    assert_raise RuntimeError, "{:undefined_character, [character: 255, pos: 1]}", fn ->
      Mbcs.from_to!(<<255>>, :cp932, :utf8)
    end
  end

  test "from_to!/4" do
    assert Mbcs.from_to!([228, 185, 157, 230, 157, 161, 227, 130, 171, 227, 131, 172, 227, 131, 179], :utf8, :cp932, return: :list)
      == [139, 227, 143, 240, 131, 74, 131, 140, 131, 147]
    assert Mbcs.from_to!([228, 185, 157, 230, 157, 161, 227, 130, 171, 227, 131, 172, 227, 131, 179], :utf8, :cp932, return: :binary)
      == <<139, 227, 143, 240, 131, 74, 131, 140, 131, 147>>
    assert Mbcs.from_to!([139, 227, 143, 240, 131, 74, 131, 140, 131, 147], :cp932, :utf8, return: :list)
      == [228, 185, 157, 230, 157, 161, 227, 130, 171, 227, 131, 172, 227, 131, 179]
    assert Mbcs.from_to!([139, 227, 143, 240, 131, 74, 131, 140, 131, 147], :cp932, :utf8, return: :binary)
      == <<228, 185, 157, 230, 157, 161, 227, 130, 171, 227, 131, 172, 227, 131, 179>>
    assert Mbcs.from_to!(<<228, 185, 157, 230, 157, 161, 227, 130, 171, 227, 131, 172, 227, 131, 179>>, :utf8, :cp932, return: :list)
      == [139, 227, 143, 240, 131, 74, 131, 140, 131, 147]
    assert Mbcs.from_to!(<<228, 185, 157, 230, 157, 161, 227, 130, 171, 227, 131, 172, 227, 131, 179>>, :utf8, :cp932, return: :binary)
      == <<139, 227, 143, 240, 131, 74, 131, 140, 131, 147>>
    assert Mbcs.from_to!(<<139, 227, 143, 240, 131, 74, 131, 140, 131, 147>>, :cp932, :utf8, return: :list)
      == [228, 185, 157, 230, 157, 161, 227, 130, 171, 227, 131, 172, 227, 131, 179]
    assert Mbcs.from_to!(<<139, 227, 143, 240, 131, 74, 131, 140, 131, 147>>, :cp932, :utf8, return: :binary)
      == <<228, 185, 157, 230, 157, 161, 227, 130, 171, 227, 131, 172, 227, 131, 179>>

    assert_raise RuntimeError, "{:undefined_character, [character: 255, pos: 1]}", fn ->
      Mbcs.from_to!('\xff', :cp932, :utf8, error: :strict)
    end
    assert Mbcs.from_to!('\xff', :cp932, :utf8, error: :ignore) == ""
    assert_raise RuntimeError, "{:undefined_character, [character: 255, pos: 1]}", fn ->
      Mbcs.from_to!(<<255>>, :cp932, :utf8, error: :strict)
    end
    assert Mbcs.from_to!(<<255>>, :cp932, :utf8, error: :ignore) == ""
  end
end
