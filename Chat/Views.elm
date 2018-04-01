module Views exposing (view)

import Html exposing (Attribute, Html, div)
import Html.Attributes exposing (..)
import Types exposing (Model, Msg(..))
import Views.Chat exposing (chat)
import Views.MemberSidebar exposing (memberSidebar)
import Views.Switcher exposing (switcher)


view : Model -> Html Msg
view model =
    div
        [ id "app" ]
        [ switcher model
        , chat model
        , memberSidebar model
        ]
