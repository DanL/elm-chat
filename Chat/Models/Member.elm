module Models.Member exposing (getMemberById, missing, new)

import Dict exposing (Dict)
import Types exposing (Member, MemberId, Model)


new : MemberId -> String -> Member
new id name =
    Member id name



-- TODO: `missing` is a hack and should be removed.


missing : Member
missing =
    new 0 "Missing"


getMemberById : Dict Int Member -> MemberId -> Maybe Member
getMemberById members memberId =
    Dict.get memberId members
