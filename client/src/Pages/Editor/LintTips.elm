module Pages.Editor.LintTips exposing (lint)

import Data.CodeMirror.LinterMessage as LinterMessage exposing (LinterMessage)
import Data.CodeMirror.Position as Position exposing (Position)
import Regex


type Rule
    = Rule String String


rules : List Rule
rules =
    [ Rule "wende" "Mind the second commandment!"
    , Rule "\\b\\w+_\\w+.*?\\b" "Careful there. Elchemy uses CamelCase, not snake_case"
    , Rule "\\n(\\s*?)([^ ].*?)=(.*)\\n\\1([^= ][^=\\n]*)\\n" "In Elchemy all functions consist only of one expression. Use\n\nlet\n  @2=@3\nin\n  @4\n\n instead"
    ]


lint : String -> List LinterMessage
lint code =
    List.concatMap (runRule code) rules |> Debug.log "Lints"


runRule :
    String
    -> Rule
    ->
        List
            { from : Position
            , message : String
            , severity : LinterMessage.Severity
            , to : Position
            }
runRule code (Rule pattern message) =
    Regex.find Regex.All (Regex.regex pattern) code
        |> List.map
            (\{ index, match, submatches } ->
                let
                    ( line, column ) =
                        toPosition code index

                    ( xLength, yLength ) =
                        toPosition match (String.length match)

                    replacePattern index with =
                        let
                            replace =
                                with |> Maybe.withDefault ""
                        in
                            Regex.replace (Regex.AtMost 1) (Regex.regex <| "@" ++ toString index) (always replace)

                    prompt =
                        List.indexedMap (,) (Just match :: submatches)
                            |> List.foldl (uncurry replacePattern) message
                in
                    warning prompt (Position line column) <| Position (line + xLength) (column + yLength)
            )


toPosition : String -> Int -> ( Int, Int )
toPosition code x =
    let
        line =
            code
                |> String.left x
                |> String.filter ((==) '\n')
                |> String.length

        column =
            code
                |> String.lines
                |> List.take line
                |> List.foldl ((+) << negate << (+) 1 << String.length) x
    in
        ( line, column )


warning :
    a
    -> b
    -> c
    -> { from : b, message : a, severity : LinterMessage.Severity, to : c }
warning message from to =
    { severity = LinterMessage.Warning
    , message = message
    , from = from
    , to = to
    }
