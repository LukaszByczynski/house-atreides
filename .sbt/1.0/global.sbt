cancelable in Global := true

shellPrompt := { state => "> " }

addCommandAlias("pluginUpdates", "; reload plugins; dependencyUpdates; reload return")

dependencyUpdatesFilter -= moduleFilter(organization = "org.scala-lang")
