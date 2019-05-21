scalaVersion := "2.12.6"

name := "swarmchemistry"

version := "0.1-SNAPSHOT"

//mainClass in (Compile, run) := Some("swarmchemistry.Run")
mainClass in (Compile, run) := Some("swarmchemistry.Test")

enablePlugins(SbtOsgi)
OsgiKeys.exportPackage := Seq("swarmchemistry.*")
OsgiKeys.importPackage := Seq("*;resolution:=optional")
OsgiKeys.privatePackage := Seq("!scala.*,*")
OsgiKeys.requireCapability := """osgi.ee;filter:="(&(osgi.ee=JavaSE)(version=1.8))""""

