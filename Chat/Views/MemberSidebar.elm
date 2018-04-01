module Views.MemberSidebar exposing (memberSidebar)

import Html exposing (Attribute, Html, div, text)
import Html.Attributes exposing (..)
import Models.Member
import Types exposing (Model, Msg(..))


memberSidebar : Model -> Html Msg
memberSidebar model =
    let
        member =
            case model.selectedMemberId of
                Just id ->
                    case Models.Member.getMemberById model.members id of
                        Just member ->
                            member

                        -- This should never happen?
                        Nothing ->
                            Models.Member.missing

                -- This should never happen?
                Nothing ->
                    Models.Member.missing
    in
    div
        [ id "memberSidebar"
        , classList [ ( "showMemberSidebar", model.viewVisibility.memberSidebar ) ]
        ]
        [ text ("Sidebar for " ++ member.name) ]
