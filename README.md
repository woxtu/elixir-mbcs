# elixir-mbcs

[![Travis](https://img.shields.io/travis/woxtu/elixir-mbcs.svg?style=flat-square)](https://travis-ci.org/woxtu/elixir-mbcs)

Wrapper for [erlang-mbcs](https://code.google.com/p/erlang-mbcs/).
This module provides functions for character encoding conversion.

## Install

Adding the following to the mix.exs in your project:

```elixir
defp deps do
  [
    {:elixir_mbcs, github: "woxtu/elixir-mbcs", tag: "0.1.3"},
  ]
end
```

## Usage

```elixir
# Start mbcs server
iex> Mbcs.start
:ok

# Convert UTF-8 to Shift_JIS
iex> Mbcs.encode!("九条カレン", :cp932)
<<139, 227, 143, 240, 131, 74, 131, 140, 131, 147>>

# Convert Shift_JIS to UTF-8, and return as a list
iex> Mbcs.decode!([139, 227, 143, 240, 131, 74, 131, 140, 131, 147], :cp932, return: :list)
[20061, 26465, 12459, 12524, 12531]
```

## Support encodings

* cp037
* cp437
* cp500
* cp737, cp775
* cp850, cp852, cp855, cp857, cp860, cp861, cp862, cp863, cp864, cp865, cp866, cp869, cp874, cp875
* cp932, cp936, gbk, cp949, cp950, big5
* cp1026, cp1250, cp1251, cp1252, cp1253, cp1254, cp1255, cp1256, cp1257, cp1258
* cp10000, cp10006, cp10007, cp10029, cp10079, cp10081
* utf8, utf16, utf16le, utf16be, utf32, utf32le, utf32be

## Options

* return: list, binary
* error: strict, ignore, replace
* replace: `non_neg_integer`
* bom: `true`, `false`

## License

Copyright (c) 2015 woxtu

Licensed under the MIT license.
