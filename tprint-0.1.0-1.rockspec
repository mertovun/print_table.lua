package = "tprint"
version = "0.1.0-1"
source = {
   url = "git://github.com/mertovun/tprint.git",
   tag = "v0.1.0"
}
description = {
   summary = "A simple table printing module for Lua.",
   detailed = [[
      tprint allows for easy printing of Lua tables, including nested tables,
      by providing a simple function call interface.
   ]],
   homepage = "http://github.com/mertovun/tprint",
   license = "MIT"
}
dependencies = {
   "lua ~> 5.1"
}
build = {
   type = "builtin",
   modules = {
     ["tprint"] = "tprint.lua"
   }
}
