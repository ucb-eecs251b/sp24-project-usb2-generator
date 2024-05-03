// See README.md for license details.
// REMOVE THIS AFTER YOU ARE DONE JASON
ThisBuild / scalaVersion     := "2.13.12"
ThisBuild / version          := "0.1.0"
ThisBuild / organization     := "ucb-eecs251b"

val chiselVersion = "5.1.0"
// val chiselVersion = "6.2.0" // switch to this version to change to verilog
lazy val root = (project in file("."))
  .settings(
    name := "usb2",
    libraryDependencies ++= Seq(
      "org.chipsalliance" %% "chisel" % chiselVersion,
      "edu.berkeley.cs" %% "chiseltest" % "5.0.2" % "test",
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

