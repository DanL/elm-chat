port module Chat exposing (..)

import Dict exposing (Dict)
import Dom.Scroll
import Html exposing (program)
import Models.Channel
import Models.Member
import Models.Message
import Task
import Types exposing (ChatMessage, Member, MemberId, Model, Msg(..))
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
        emptyGeneralChannel =
            Models.Channel.new "general"

        generalMessages =
            Just
                [ { memberId = 1, message = "This is a test message." }
                , { memberId = 2, message = "Messages are cool." }
                , { memberId = 3, message = "Something something whatever." }
                ]

        generalChannel =
            { emptyGeneralChannel | messages = generalMessages }

        channels =
            [ ( "boston", Models.Channel.new "boston" )
            , ( "general", generalChannel )
            , ( "engineering", Models.Channel.new "engineering" )
            ]
                |> Dict.fromList

        activeChannel =
            "general"

        currentMemberId =
            1

        members =
            [ ( 1, Models.Member.new 1 "Dan" )
            , ( 2, Models.Member.new 2 "Jake" )
            , ( 3, Models.Member.new 3 "Fyodor" )
            ]
                |> Dict.fromList
    in
    { emptyModel
        | channels = channels
        , members = members
        , activeChannel = activeChannel
        , currentMemberId = currentMemberId
    }
        ! []


emptyModel : Model
emptyModel =
    { channels = Dict.empty
    , members = Dict.empty
    , activeChannel = ""
    , currentMessage = Nothing
    , currentMemberId = 0
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []

        SwitchChannel channel ->
            { model | activeChannel = channel } ! []

        SetMessage message ->
            { model | currentMessage = Just (Models.Message.create model.currentMemberId message) } ! []

        SendMessage ->
            let
                activeChannel =
                    Models.Channel.active model

                newMessages =
                    Models.Message.appendCurrent model.currentMessage activeChannel

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

                scrollMessages =
                    Task.attempt (\_ -> NoOp) (Dom.Scroll.toBottom "chat-messages")
            in
            { model | channels = newChannels, currentMessage = Nothing } ! [ scrollMessages ]
