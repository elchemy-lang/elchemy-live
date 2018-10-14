module Pages.Embed.Types.Panel exposing (..)


type Panel
    = Elm
    | Html
    | Output


eq : Panel -> Panel -> Bool
eq left right =
    case ( left, right ) of
        ( Elm, Elm ) ->
            True

        ( Html, Html ) ->
            True

        ( Output, Output ) ->
            True

        _ ->
            False


fromString : String -> Panel
fromString input =
    case input of
        "elixir" ->
            Html

        "output" ->
            Output

        _ ->
            Elm


toString : Panel -> String
toString panel =
    case panel of
        Html ->
            "elixir"

        Output ->
            "output"

        Elm ->
            "elchemy"
