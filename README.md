# print_table.lua

`print_table.lua` module provides a simple way to print Lua tables, handling circular references gracefully. It's designed to be easy to use for debugging or logging complex table structures with minimal configuration.

## Installation

To install the `print_table`, use LuaRocks:

```bash
luarocks install print_table
```

## Usage

To use `print_table`, simply require the module and call it with the table you want to print:

```lua
local print_table = require("print_table")

local myTable = {
    a = 1,
    b = { c = 2, d = 3 },
    e = { f = { g = 4 }, h = 5 },
}

print_table(myTable)
```
