module Views.MemberSidebar exposing (memberSidebar)

import Html exposing (Attribute, Html, div, text)
import Html.Attributes exposing (..)
import Types exposing (Model, Msg(..))


memberSidebar : Model -> Html Msg
memberSidebar model =
    div
        [ id "memberSidebar"
        , classList [ ( "showMemberSidebar", model.viewVisibility.memberSidebar ) ]
        ]
        [ text "Sidebar" ]
