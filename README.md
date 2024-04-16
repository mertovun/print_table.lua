# print_table.lua

`print_table.lua` provides a simple way to print Lua tables, handling circular references gracefully. It's designed to be easy to use for debugging or logging complex table structures with minimal configuration.

## Installation

To install the `print_table`, use LuaRocks:

```bash
luarocks install print_table
```

## Examples

### Basic Data Types

Here, a configuration table, including various types of settings:

```lua
local configSettings = {
    appName = "MyApp",
    maxConnections = 100,
    debugEnabled = false,
    logFile = nil,
    onLaunch = function() print("App launching...") end,
    backgroundTask = coroutine.create(function() end),
    logFileHandle = io.open(os.tmpname(), "r"),
}

print_table(configSettings)
```
  
```output 
backgroundTask: <thread>
debugEnabled: false
onLaunch: <function>
maxConnections: 100
appName: "MyApp"
logFileHandle: <userdata>
```

### Nested Structures

Nested feature flags:

```lua
local moduleConfig = {
  supportedLanguages = {"English", "Spanish", "French", "German"},
  features = {
      authentication = {
          oauth = true,
          saml = false,
      },
      uiThemes = {
          darkMode = true,
          fontSize = "medium"
      }
  }
}

print_table(moduleConfig)
```
  
```output 
features:
  authentication:
    oauth: true
    saml: false
  uiThemes:
    darkMode: true
    fontSize: "medium"
supportedLanguages:
  1: "English"
  2: "Spanish"
  3: "French"
  4: "German"
```

### Circular Ref Example

A dependency graph of interconnected nodes:

```lua
local graphNode = {}
graphNode.connections = {graphNode}
graphNode.metadata = {
  nodeName = "Node1",
  nodeType = "Root",
}

local projectDependencies = {
  root = graphNode,
  dependencyGraph = {
      root = graphNode,
      nodes = {
          {name = "Node2", linksTo = graphNode},
          {name = "Node3", linksTo = {graphNode}}
      }
  }
}

graphNode.project = projectDependencies

print_table(projectDependencies)
```
  
```output 
root:
  metadata:
    nodeName: "Node1"
    nodeType: "Root"
  connections:
    1: <circular ref: root.root>
  project: <circular ref: root>
dependencyGraph:
  root: <circular ref: root.root>
  nodes:
    1:
      name: "Node2"
      linksTo: <circular ref: root.root>
    2:
      name: "Node3"
      linksTo:
        1: <circular ref: root.root>
```

### Circular Ref Example 2

A user profile with various types of information, including nested preferences and a reference to a session or user object:
```lua
local userProfile = {
  username = "user123",
  preferences = {
      notifications = "enabled",
      privacy = {
          shareLocation = false,
          onlineStatus = "invisible",
      },
  },
  session = coroutine.create(function() end),
}

local userSession = {
  user = userProfile,
  preferences = userProfile.preferences,
}
userProfile.sessionData = userSession

print_table(userSession)
```

```output 
user:
  sessionData: <circular ref: root>
  preferences:
    notifications: "enabled"
    privacy:
      shareLocation: false
      onlineStatus: "invisible"
  username: "user123"
  session: <thread>
preferences: <circular ref: root.user.preferences>
```
