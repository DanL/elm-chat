module Views.Chat exposing (chat)

import Helpers exposing (onEnter)
import Html exposing (Attribute, Html, div, input, li, text, ul)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import Models.Channel
import Models.Member
import Models.Message
import Types exposing (Channel, ChatMessage, Member, Model, Msg(..))


chat : Model -> Html Msg
chat model =
    div
        [ id "chat" ]
        [ header model
        , messages model
        , inputMessage model
        ]


header : Model -> Html msg
header model =
    div
        [ id "chat-header" ]
        [ text ("#" ++ model.activeChannel) ]


chatMessages : Model -> List ChatMessage
chatMessages model =
    Models.Message.active (Models.Channel.active model)


messages : Model -> Html msg
messages model =
    let
        maybeMember chatMessage =
            Models.Member.getMemberById model.members chatMessage.memberId

        toMessageMemberTuple chatMessage =
            case maybeMember chatMessage of
                Just member ->
                    ( chatMessage, member )

                Nothing ->
                    ( chatMessage, Models.Member.missing )

        messageMemberTuples =
            List.map toMessageMemberTuple (chatMessages model)
    in
    ul
        [ id "chat-messages" ]
        (List.map htmlMessage messageMemberTuples)


htmlMessage : ( ChatMessage, Member ) -> Html msg
htmlMessage ( chatMessage, member ) =
    li []
        [ div
            [ class "chat-messages-name" ]
            [ text member.name ]
        , div
            [ class "chat-message-message" ]
            [ text chatMessage.message ]
        ]


inputMessage : Model -> Html Msg
inputMessage model =
    let
        currentMessage =
            case model.currentMessage of
                Just cm ->
                    cm.message

                Nothing ->
                    ""
    in
    div
        [ id "chat-input" ]
        [ input
            [ type_ "text"
            , placeholder "Say something~"
            , value currentMessage
            , onInput SetMessage
            , onEnter SendMessage
            ]
            []
        ]
