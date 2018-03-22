cancelable in Global := true
shellPrompt := { state => "> " }

ensimeIgnoreMissingDirectories in ThisBuild := true
ensimeJavaFlags ++= Seq("-Xmx2g", "-XX:+PerfDisableSharedMem")

addCommandAlias("pluginUpdates", "; reload plugins; dependencyUpdates; reload return")
