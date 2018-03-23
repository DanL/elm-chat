module Views.Switcher exposing (switcher)

import Dict exposing (Dict)
import Html exposing (Attribute, Html, div, li, text, ul)
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
                (channelNode model.activeChannel)
                (Dict.values model.channels |> List.map .name)
    in
    ul
        [ id "channels" ]
        channelList


channelNode : ChannelName -> ChannelName -> Html Msg
channelNode activeChannel name =
    li
        [ onClick <| SwitchChannel name
        , classList [ ( "channel-active", name == activeChannel ) ]
        ]
        [ text ("#" ++ name) ]
