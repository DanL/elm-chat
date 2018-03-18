module Types exposing (..)


type Msg
    = NoOp
    | SwitchChannel Channel
    | SetMessage String


type alias Model =
    { channels : List Channel
    , activeChannel : Channel
    , messages : List ChatMessage
    , currentMessage : ChatMessage
    , currentMember : Member
    }


type alias Channel =
    { name : String
    , members : List Member
    }


type alias ChatMessage =
    { member : Member
    , message : String
    }


type alias Member =
    { name : String
    }
