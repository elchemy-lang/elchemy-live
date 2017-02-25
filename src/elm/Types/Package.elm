module Types.Package
    exposing
        ( Package
        , encode
        , decode
        , hash
        , docsLink
        )

import Json.Encode as Encode exposing (Value)
import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Pipeline as Decode
import Types.Version as Version exposing (Version)


type alias Package =
    { username : String
    , name : String
    , version : Version
    }


encode : Package -> Value
encode package =
    Encode.object
        [ ( "username", Encode.string package.username )
        , ( "name", Encode.string package.name )
        , ( "version", Version.encode package.version )
        ]


decode : Decoder Package
decode =
    Decode.decode Package
        |> Decode.required "username" Decode.string
        |> Decode.required "name" Decode.string
        |> Decode.required "version" Version.decode


docsLink : Package -> String
docsLink package =
    "http://package.elm-lang.org/packages/"
        ++ package.username
        ++ "/"
        ++ package.name
        ++ "/"
        ++ Version.toString package.version


hash : Package -> String
hash package =
    toString package
