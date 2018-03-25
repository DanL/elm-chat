module Models.Message exposing (active, appendCurrent, new)

import Dict exposing (Dict)
import Types exposing (Channel, ChannelName, ChatMessage, Member, MemberId, Model)


new : MemberId -> String -> ChatMessage
new memberId message =
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


currentAsList : Dict ChannelName String -> Channel -> MemberId -> List ChatMessage
currentAsList currentMessages activeChannel currentMemberId =
    case Dict.get activeChannel.name currentMessages of
        Just message ->
            [ new currentMemberId message ]

        Nothing ->
            []


appendCurrent : Dict ChannelName String -> Channel -> MemberId -> List ChatMessage
appendCurrent currentMessages activeChannel currentMemberId =
    let
        current =
            currentAsList currentMessages activeChannel currentMemberId
    in
    case activeChannel.messages of
        Just acMessages ->
            acMessages ++ current

        Nothing ->
            current
