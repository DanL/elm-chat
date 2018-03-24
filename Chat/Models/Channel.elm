module Models.Channel exposing (active, empty)

import Dict
import Types exposing (Channel, ChannelName, Model)


active : Model -> Maybe Channel
active model =
    Dict.get model.activeChannel model.channels


empty : Channel
empty =
    Channel "" [] Nothing
