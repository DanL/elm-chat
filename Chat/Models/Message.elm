module Models.Message exposing (active, appendCurrent, create)

import Types exposing (Channel, ChatMessage, MemberId, Model)


create : MemberId -> String -> ChatMessage
create memberId message =
    { memberId = memberId
    , message = message
    }


active : Maybe Channel -> List ChatMessage
active activeChannel =
    case activeChannel of
        Just channel ->
            channel.messages |> Maybe.withDefault []

        Nothing ->
            []


currentAsList : Maybe ChatMessage -> List ChatMessage
currentAsList currentMessage =
    case currentMessage of
        Just chatMessage ->
            [ chatMessage ]

        Nothing ->
            []


appendCurrent : Maybe ChatMessage -> Maybe Channel -> List ChatMessage
appendCurrent currentMessage activeChannel =
    let
        messages =
            case activeChannel of
                Just channel ->
                    channel.messages

                Nothing ->
                    Nothing
    in
    case messages of
        Just messages ->
            messages ++ currentAsList currentMessage

        Nothing ->
            []
