module Data.Elchemy exposing (wrapCode)


wrapCode : String -> String
wrapCode code =
    let
        newCode =
            code
                |> String.lines
                |> List.drop 1
                |> String.join "\n"
    in
    """
module Main exposing (..)
import Html

main : Html.Html msg
main =
    Html.text <| toString run

ffi =
    Debug.crash "FFI calls do not work in the browser"
""" ++ newCode ++ """

"""
