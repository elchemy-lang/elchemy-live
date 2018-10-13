module Pages.Editor.Types.Revision exposing (External(..), Id, Revision, default, editorLink, embedLink, localStorageDecoder, localStorageEncoder)

import Data.Url as Url exposing (Url)
import Ellie.Constants as Constants
import Elm.Compiler as Compiler
import Elm.Package as Package exposing (Package)
import Elm.Version as Version exposing (Version)
import Json.Decode as Decode exposing (Decoder)
import Json.Encode as Encode exposing (Value)


type External
    = Default
    | Remote ( Id, Revision )
    | Example Revision


type alias Id =
    String


type alias Revision =
    { htmlCode : String
    , elmCode : String
    , elchemyCode : String
    , packages : List Package
    , title : String
    , elmVersion : Version
    }


editorLink : Id -> Url
editorLink id =
    Url.fromString <| Constants.editorBase ++ "/" ++ id


embedLink : Id -> Url
embedLink id =
    Url.fromString <| Constants.embedBase ++ "/" ++ id


localStorageDecoder : Decoder Revision
localStorageDecoder =
    Decode.map6 Revision
        (Decode.field "htmlCode" Decode.string)
        (Decode.field "elmCode" Decode.string)
        (Decode.field "elchemyCode" Decode.string)
        (Decode.field "packages" (Decode.list Package.decoder))
        (Decode.field "title" Decode.string)
        (Decode.field "elmVersion" Version.decoder)


localStorageEncoder : Revision -> Value
localStorageEncoder revision =
    Encode.object
        [ ( "htmlCode", Encode.string revision.htmlCode )
        , ( "elmCode", Encode.string revision.elmCode )
        , ( "elchemyCode", Encode.string revision.elchemyCode )
        , ( "packages", Encode.list <| List.map Package.encoder revision.packages )
        , ( "title", Encode.string revision.title )
        , ( "elmVersion", Version.encoder revision.elmVersion )
        ]


default : List Package -> Revision
default packages =
    { packages = packages
    , title = ""
    , elmVersion = Compiler.version
    , elchemyCode = ""
    , htmlCode = """<html>
<html>
<head>
  <style>
    /* you can style your program here */
  </style>
</head>
<body>
  <div id="app"></div>
  <script>
    var node = document.getElementById("app");
    var app = Elm.Main.embed(node)
    // you can use ports and stuff here
  </script>
</body>
</html>

"""
    , elmCode = """module Main exposing (..)

run : String
main =
    "Hello, world!"

"""
    }
