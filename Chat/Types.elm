module Types exposing (..)

import Dict exposing (Dict)


type Msg
    = NoOp
    | SwitchChannel ChannelName
    | SetMessage String
    | SendMessage


type alias Model =
    { channels : Dict ChannelName Channel
    , members : Dict Int Member
    , activeChannel : ChannelName
    , currentMessage : Maybe ChatMessage
    , currentMemberId : MemberId
    }


type alias ChannelName =
    String


type alias Channel =
    { name : ChannelName
    , memberIds : List MemberId
    , messages : Maybe (List ChatMessage)
    }


type alias ChatMessage =
    { memberId : MemberId
    , message : String
    }


type alias MemberId =
    Int


type alias Member =
    { id : MemberId
    , name : String
    }
