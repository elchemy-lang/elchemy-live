module Data.Elchemy exposing (wrapCode)


wrapCode : String -> String
wrapCode code =
    let
        newCode =
            code
                |> String.lines
                |> List.drop 2
                |> String.join "\n"
    in
    prefix ++ newCode ++ postfix

prefix : String
prefix =
    """module Main exposing (..)
import Html
"""

postfix : String
postfix =
    """

main : Html.Html msg
main =
    Html.text <| toString run

ffi mod fun =
    Debug.crash "FFI calls do not work in the browser"
"""
