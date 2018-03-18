module Views.Switcher exposing (switcher)

import Html exposing (Attribute, Html, div, li, text, ul)
import Html.Attributes exposing (..)
import Types exposing (Channel, Model, Msg(..))


switcher : Model -> Html msg
switcher model =
    div
        [ id "switcher" ]
        [ channels model ]


channels : Model -> Html msg
channels model =
    ul
        [ id "channels" ]
        [ li
            [ attribute "data-name" "boston" ]
            [ text "#boston" ]
        , li
            [ attribute "data-name" "engineering"
            , classList [ ( "channel-active", True ) ]
            ]
            [ text "#engineering" ]
        , li
            [ attribute "data-name" "general" ]
            [ text "#general" ]
        ]
