module Views.Chat exposing (chat)

import Html exposing (Attribute, Html, div, input, li, text, ul)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
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
        [ text "#engineering" ]


messages : Model -> Html msg
messages model =
    ul
        [ id "chat-messages" ]
        [ li []
            [ div
                [ class "chat-messages-name" ]
                [ text "dan" ]
            , div
                [ class "chat-message-message" ]
                [ text "This is a test message." ]
            ]
        , li []
            [ div
                [ class "chat-messages-name" ]
                [ text "jake" ]
            , div
                [ class "chat-message-message" ]
                [ text "Messages are cool." ]
            ]
        , li []
            [ div
                [ class "chat-messages-name" ]
                [ text "jake" ]
            , div
                [ class "chat-message-message" ]
                [ text "Something something whatever." ]
            ]
        ]


inputMessage : Model -> Html Msg
inputMessage model =
    div
        [ id "chat-input" ]
        [ input
            [ type_ "text", placeholder "Say something~", onInput SetMessage ]
            []
        ]
