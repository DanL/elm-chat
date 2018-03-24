module Views.Chat exposing (chat)

import Helpers exposing (onEnter)
import Html exposing (Attribute, Html, div, input, li, text, ul)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import Models.Message as Message
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


messages : Model -> Html msg
messages model =
    ul
        [ id "chat-messages" ]
        (List.map htmlMessage (Message.active model))


htmlMessage : ChatMessage -> Html msg
htmlMessage chatMessage =
    li []
        [ div
            [ class "chat-messages-name" ]
            [ text chatMessage.member.name ]
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
