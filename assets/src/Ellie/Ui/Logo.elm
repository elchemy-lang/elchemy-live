module Ellie.Ui.Logo exposing (animated, flat)

-- import Svg.Styled as Svg exposing (Svg, path, svg)

import Css exposing (..)
import Ellie.Ui.Theme as Theme
import Html.Styled as Html exposing (Attribute, Html)
import Svg.Styled.Attributes as SvgAttributes exposing (css, d, fillRule, stroke, viewBox, xlinkHref)


flat : Html msg
flat =
    Html.div
        [ css
            [ color Theme.primaryForeground
            , fontFamilies [ "Helvetica Neue" ]
            , fontWeight bold
            , fontSize (em 4)
            , cursor default
            , left (pct 50)
            ]
        ]
        [ Html.text "Elchemy Live" ]


animated : Html msg
animated =
    flat
