module Helpers exposing (..)

import Html exposing (Attribute)
import Html.Events exposing (keyCode, on)
import Json.Decode as JD
import Types exposing (Msg)


onEnter : Msg -> Attribute Msg
onEnter msg =
    let
        isEnter code =
            if code == 13 then
                JD.succeed msg
            else
                JD.fail "not ENTER"
    in
    on "keydown" (JD.andThen isEnter keyCode)
