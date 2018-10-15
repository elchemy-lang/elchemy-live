defmodule Ellie.Domain.Embed do
  alias Elm.Error
  alias Ellie.Types.Revision

  @type status :: :working | {:finished, Error.t | nil} | {:started, (-> Task.t)}

  @callback result(revision :: Revision.t) :: {:ok, Path.t} | :error
  @callback compile(revision :: Revision.t) :: status
  @callback cleanup(minutes_old :: integer) :: :unit

  @spec result(revision :: Revision.t) :: {:ok, Path.t} | :error
  def result(revision) do
    adapter().result(revision)
  end

  @spec compile(revision :: Revision.t) :: status
  def compile(revision) do
    revision = %Revision{revision | elm_code: revision.elm_code |> wrap_code}
    adapter().compile(revision |> IO.inspect(label: "NEW REVISION"))
  end

  @spec cleanup(minutes_old :: integer) :: :unit
  def cleanup(minutes_old) do
    adapter().cleanup(minutes_old)
  end

  defp adapter() do
    config = Application.get_env(:ellie, Ellie.Domain.Embed, [])
    Keyword.get(config, :adapter, Ellie.Adapters.Embed.Local)
  end

  # Wrap the code to work with Elchemy
  defp wrap_code(code) do
    new_code =
      code
      |> String.split("\n")
      |> Enum.drop(2)
      |> Enum.join("\n")

    prefix <> new_code <> postfix
  end

  defp prefix() do
    """
module Main exposing (..)
import Html
"""
  end


  defp postfix() do
    """

main : Html.Html msg
main =
    Html.text <| toString run

ffi mod fun =
    Debug.crash "FFI calls do not work in the browser"
"""
  end
end
