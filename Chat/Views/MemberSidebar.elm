module Views.MemberSidebar exposing (memberSidebar)

import Html exposing (Attribute, Html, div, text)
import Html.Attributes exposing (..)
import Models.Member
import Types exposing (Model, Msg(..))


memberSidebar : Model -> Html Msg
memberSidebar model =
    let
        member =
            model.selectedMemberId
                |> Maybe.andThen (Models.Member.getMemberById model.members)
                |> Maybe.withDefault Models.Member.missing
    in
    div
        [ id "memberSidebar"
        , classList [ ( "showMemberSidebar", model.viewVisibility.memberSidebar ) ]
        ]
        [ div [ id "memberSidebar-header" ] [ text member.name ]
        , div [ id "memberSidebar-status" ] [ text member.status ]
        , div [ id "memberSidebar-bio" ] [ text member.bio ]
        ]
