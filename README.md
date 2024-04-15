# tprint.lua

`tprint.lua` module provides a simple way to print Lua tables, handling circular references gracefully. It's designed to be easy to use for debugging or logging complex table structures with minimal configuration.

## Installation

To install the `tprint`, use LuaRocks:

```bash
luarocks install tprint
```

## Usage

To use `tprint`, simply require the module and call it with the table you want to print:

```lua
local tprint = require("tprint")

local myTable = {
    a = 1,
    b = { c = 2, d = 3 },
    e = { f = { g = 4 }, h = 5 },
}

tprint(myTable)
```
