module Models.Channel exposing (findByName)

import Dict
import Types exposing (Channel, ChannelName, Model)


findByName : Model -> ChannelName -> Maybe Channel
findByName model name =
    Dict.get name model.channels
