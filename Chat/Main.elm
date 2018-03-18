port module Chat exposing (..)

import Html exposing (programWithFlags)
import Types exposing (ChatMessage, Member, Model, Msg(..))
import Views exposing (view)


main : Program (Maybe Model) Model Msg
main =
    programWithFlags
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }


init : Maybe Model -> ( Model, Cmd Msg )
init savedModel =
    emptyModel ! []


emptyModel : Model
emptyModel =
    { channels = []
    , activeChannel = { name = "", members = [] }
    , messages = []
    , currentMessage = { member = { name = "" }, message = "" }
    , currentMember = { name = "" }
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []

        SwitchChannel channel ->
            { model | activeChannel = channel } ! []

        SetMessage message ->
            { model | currentMessage = ChatMessage model.currentMember message } ! []
