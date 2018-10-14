defmodule Elm.Project do
  alias Elm.Version
  alias Elm.Package

  defstruct [:elm_version, :dependencies]

  @type t :: %Elm.Project{
    elm_version: Version.t,
    dependencies: MapSet.t(Package.t)
  }


end
