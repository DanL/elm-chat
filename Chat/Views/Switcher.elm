module Views.Switcher exposing (switcher)

import Dict exposing (Dict)
import FontAwesome.Solid as Icon
import Html exposing (Attribute, Html, div, i, li, span, text, ul)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Types exposing (Channel, ChannelName, Model, Msg(..))


switcher : Model -> Html Msg
switcher model =
    div
        [ id "switcher" ]
        [ channels model ]


channels : Model -> Html Msg
channels model =
    let
        channelList =
            List.map
                (channelNode model.currentMessages model.activeChannel)
                (Dict.keys model.channels)
    in
    ul
        [ id "channels" ]
        channelList


channelNode : Dict ChannelName String -> ChannelName -> ChannelName -> Html Msg
channelNode currentMessages activeChannel name =
    let
        currentMessage =
            Maybe.withDefault "" (Dict.get name currentMessages)

        visible =
            String.length currentMessage > 0 && name /= activeChannel

        icon =
            if visible then
                Icon.pencil_alt
            else
                text ""
    in
    li
        [ onClick <| SwitchChannel name
        , classList [ ( "channel-active", name == activeChannel ) ]
        ]
        [ span [] [ text ("#" ++ name) ]
        , icon
        ]
