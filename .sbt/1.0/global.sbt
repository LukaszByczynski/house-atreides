//import org.ensime.EnsimeKeys._

cancelable in Global := true
shellPrompt := { state => "> " }

//ensimeServerFindUsages in ThisBuild := true
//ensimeIgnoreMissingDirectories in ThisBuild := true
//ensimeJavaFlags ++= Seq("-Xmx1g", "-XX:+PerfDisableSharedMem")

addCommandAlias("pluginUpdates", "; reload plugins; dependencyUpdates; reload return")
