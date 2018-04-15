module Types exposing (..)

import Dict exposing (Dict)


type Msg
    = NoOp
    | SwitchChannel ChannelName
    | SetMessage String
    | SendMessage
    | ToggleMemberSidebar MemberId


type alias Model =
    { channels : Dict ChannelName Channel
    , members : Dict Int Member
    , activeChannel : ChannelName
    , currentMessages : Dict ChannelName String
    , currentMemberId : MemberId
    , selectedMemberId : Maybe MemberId
    , viewVisibility : ViewVisibility
    }


type alias Flags =
    { members : List Member
    , channels : List Channel
    , currentMemberId : Int
    , activeChannel : String
    }



-- Chat


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



-- Member


type alias MemberId =
    Int


type alias Member =
    { id : MemberId
    , name : String
    , status : String
    , bio : String
    }



-- View


type alias ViewVisibility =
    { memberSidebar : Bool }
