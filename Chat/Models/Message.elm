module Models.Message exposing (active, appendCurrent, create)

import Models.Channel as Channel
import Types exposing (ChatMessage, Model)


create : String -> Model -> Maybe ChatMessage
create message model =
    Just (ChatMessage model.currentMember message)


active : Model -> List ChatMessage
active model =
    let
        activeChannel =
            Channel.active model
    in
    case activeChannel of
        Just channel ->
            channel.messages |> Maybe.withDefault []

        Nothing ->
            []


currentAsList : Model -> List ChatMessage
currentAsList model =
    case model.currentMessage of
        Just chatMessage ->
            [ chatMessage ]

        Nothing ->
            []


appendCurrent : Model -> List ChatMessage
appendCurrent model =
    let
        messages =
            case Channel.active model of
                Just channel ->
                    channel.messages

                Nothing ->
                    Nothing
    in
    case messages of
        Just messages ->
            messages ++ currentAsList model

        Nothing ->
            []
