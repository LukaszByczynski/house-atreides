import org.ensime.EnsimeKeys._

//cancelable in Global := true

// for 2.0-graph
//ensimeIgnoreMissingDirectories in ThisBuild := true
//ensimeJavaFlags ++= Seq("-Xmx4g", "-XX:+PerfDisableSharedMem")

addCommandAlias("pluginUpdates", "; reload plugins; dependencyUpdates; reload return")
