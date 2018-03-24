port module Chat exposing (..)

import Dict exposing (Dict)
import Html exposing (program)
import Models.Channel
import Models.Message
import Types exposing (ChatMessage, Member, Model, Msg(..))
import Views exposing (view)


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }


init : ( Model, Cmd Msg )
init =
    let
        channels =
            [ ( "boston"
              , { name = "boston"
                , members = []
                , messages = Just []
                }
              )
            , ( "general"
              , { name = "general"
                , members = []
                , messages =
                    Just
                        [ { member = { name = "dan" }, message = "This is a test message." }
                        , { member = { name = "jake" }, message = "Messages are cool." }
                        , { member = { name = "fyodor" }, message = "Something something whatever." }
                        ]
                }
              )
            , ( "engineering"
              , { name = "engineering"
                , members = []
                , messages = Just []
                }
              )
            ]
                |> Dict.fromList

        activeChannel =
            "general"

        currentMember =
            { name = "Dan" }
    in
    { emptyModel
        | channels = channels
        , activeChannel = activeChannel
        , currentMember = currentMember
    }
        ! []


emptyModel : Model
emptyModel =
    { channels = Dict.empty
    , activeChannel = ""
    , currentMessage = Nothing
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
            { model | currentMessage = Models.Message.create message model } ! []

        SendMessage ->
            let
                newMessages =
                    Models.Message.appendCurrent model

                activeChannel =
                    Models.Channel.active model

                newChannels =
                    case activeChannel of
                        Just channel ->
                            let
                                newChannel =
                                    { channel | messages = Just newMessages }
                            in
                            Dict.insert model.activeChannel newChannel model.channels

                        Nothing ->
                            model.channels
            in
            { model | channels = newChannels, currentMessage = Nothing } ! []
