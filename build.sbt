/*name                         := "usb2"
ThisBuild / scalaVersion     := "2.13.10"
ThisBuild / version          := "0.1.0"
val chiselVersion = "3.5.6"
lazy val root = (project in file("."))
  .settings(
    libraryDependencies ++= Seq(
      "edu.berkeley.cs" %% "chisel3" % chiselVersion,
      "edu.berkeley.cs" %% "chiseltest" % "0.5.6" % "test",
      "edu.berkeley.cs" %% "rocketchip" % "1.6.0",
    ),
    addCompilerPlugin("edu.berkeley.cs" % "chisel3-plugin" % chiselVersion cross CrossVersion.full),
    scalacOptions ++= Seq(
      "-language:reflectiveCalls",
      "-deprecation",
      "-unchecked",
      "-feature",
      "-Ymacro-annotations"
    )
  )
resolvers ++= Seq(
  Resolver.sonatypeRepo("snapshots"),
  Resolver.sonatypeRepo("releases"),
  Resolver.mavenLocal)
libraryDependencies ++= Seq("edu.berkeley.cs" %% "rocketchip" % "1.6.0-4fbd2f238-SNAPSHOT")
import Tests._
Test / fork := true
Test / testGrouping := (Test / testGrouping).value.flatMap { group =>
   group.tests.map { test =>
      Group(test.name, Seq(test), SubProcess(ForkOptions()))
   }
}
*/
// Comment the lines above and uncomment the lines below for building in chipyard
name := "usb2_generator"
version := "0.1"
scalaVersion := "2.13.10"
val chiselVersion = "3.6.0"
scalacOptions ++= Seq(
  "-language:reflectiveCalls",
  "-deprecation",
  "-feature",
  "-unchecked",
  "-Ymacro-annotations"
)
// SNAPSHOT repositories
libraryDependencies ++=
  Seq(
    "edu.berkeley.cs" %% "rocketchip-3.6.0" % "1.6-3.6.0-e3773366a-SNAPSHOT",
    "edu.berkeley.cs" %% "chisel3" % chiselVersion,
    "edu.berkeley.cs" %% "chiseltest" % "0.6.2" % "test",
  )
resolvers ++= Resolver.sonatypeOssRepos("snapshots")
resolvers ++= Resolver.sonatypeOssRepos("releases")
resolvers += Resolver.mavenLocal
addCompilerPlugin("edu.berkeley.cs" % "chisel3-plugin" % chiselVersion cross CrossVersion.full)
import Tests._
Test / fork := true
Test / testGrouping := (Test / testGrouping).value.flatMap { group =>
   group.tests.map { test =>
      Group(test.name, Seq(test), SubProcess(ForkOptions()))
   }
}
concurrentRestrictions := Seq(Tags.limit(Tags.ForkedTestGroup, 72))