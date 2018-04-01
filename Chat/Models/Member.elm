module Models.Member exposing (getMemberById, missing, new)

import Dict exposing (Dict)
import Types exposing (Member, MemberId, Model)


new : MemberId -> String -> String -> String -> Member
new id name status bio =
    { id = id
    , name = name
    , status = status
    , bio = bio
    }



-- TODO: `missing` is a hack and should be removed.


missing : Member
missing =
    { id = 0
    , name = "Missing"
    , status = ""
    , bio = ""
    }


getMemberById : Dict Int Member -> MemberId -> Maybe Member
getMemberById members memberId =
    Dict.get memberId members
