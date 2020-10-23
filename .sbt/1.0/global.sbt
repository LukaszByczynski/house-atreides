cancelable in Global := true

addCommandAlias("pluginUpdates", "; reload plugins; dependencyUpdates; reload return")

dependencyUpdatesFilter -= moduleFilter(organization = "org.scala-lang")

credentials ++= Seq(Path.userHome / ".sbt" / ".credentials").collect {
  case path if path.canRead ⇒ Credentials(path)
}

