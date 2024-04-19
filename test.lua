local print_table = require("print_table")

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