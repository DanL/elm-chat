module Types exposing (..)

import Dict exposing (Dict)


type Msg
    = NoOp
    | SwitchChannel ChannelName
    | SetMessage String
    | SendMessage


type alias Model =
    { channels : Dict ChannelName Channel
    , activeChannel : ChannelName
    , currentMessage : Maybe ChatMessage
    , currentMember : Member
    }


type alias ChannelName =
    String


type alias Channel =
    { name : ChannelName
    , members : List Member
    , messages : Maybe (List ChatMessage)
    }


type alias ChatMessage =
    { member : Member
    , message : String
    }


type alias Member =
    { name : String
    }
