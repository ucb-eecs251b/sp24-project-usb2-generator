ThisBuild / scalaVersion     := "2.13.10"
ThisBuild / version          := "0.1.0"
ThisBuild / organization     := "251b"

val chiselVersion = "6.2.0"

lazy val root = (project in file("."))
  .settings(
    name := "usbtx",
    libraryDependencies ++= Seq(
      "org.chipsalliance" %% "chisel" % chiselVersion,
      "org.scalatest" %% "scalatest" % "3.2.16" % "test",
      "edu.berkeley.cs" %% "rocketchip" % "1.6.0"
    ),
    scalacOptions ++= Seq(
      "-language:reflectiveCalls",
      "-deprecation",
      "-feature",
      "-Xcheckinit",
      "-Ymacro-annotations",
    ),
    addCompilerPlugin("org.chipsalliance" % "chisel-plugin" % chiselVersion cross CrossVersion.full),
  )
