module Models.Channel exposing (active, new)

import Dict
import Types exposing (Channel, ChannelName, Model)


active : Model -> Maybe Channel
active model =
    Dict.get model.activeChannel model.channels


new : ChannelName -> Channel
new name =
    { name = name
    , memberIds = []
    , messages = Just []
    }
