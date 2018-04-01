port module Chat exposing (..)

import Dict exposing (Dict)
import Dom exposing (focus)
import Dom.Scroll
import Html exposing (program)
import Models.Channel
import Models.Member
import Models.Message
import Models.ViewVisibility
import Task
import Types exposing (Channel, ChannelName, ChatMessage, Member, MemberId, Model, Msg(..))
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
            [ ( 1, Models.Member.new 1 "Dan" "Away" "B-b-b-bio bio" )
            , ( 2, Models.Member.new 2 "Jake" "On Vacation" "Biooooooo" )
            , ( 3, Models.Member.new 3 "Fyodor" "Working" "Bio bio bio" )
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
    , currentMessages = Dict.empty
    , currentMemberId = 0
    , viewVisibility = Models.ViewVisibility.empty
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []

        SwitchChannel channel ->
            let
                focusInput =
                    Task.attempt (always NoOp) (focus "chat-input-field")
            in
            { model | activeChannel = channel } ! [ focusInput ]

        SetMessage message ->
            let
                newCurrentMessages =
                    Dict.insert model.activeChannel message model.currentMessages
            in
            { model | currentMessages = newCurrentMessages } ! []

        SendMessage ->
            let
                newCurrentMessages =
                    Dict.insert model.activeChannel "" model.currentMessages
            in
            { model | channels = appendMessageToChannel model, currentMessages = newCurrentMessages } ! [ scrollMessages ]

        ToggleMemberSidebar memberId ->
            let
                viewVisibility =
                    model.viewVisibility

                newViewVisibility =
                    { viewVisibility | memberSidebar = not viewVisibility.memberSidebar }
            in
            { model | viewVisibility = newViewVisibility } ! []


appendMessageToChannel : Model -> Dict ChannelName Channel
appendMessageToChannel model =
    let
        activeChannel =
            Models.Channel.active model
    in
    case activeChannel of
        Just channel ->
            let
                newMessages =
                    Models.Message.appendCurrent model.currentMessages channel model.currentMemberId

                newChannel =
                    { channel | messages = Just newMessages }
            in
            Dict.insert model.activeChannel newChannel model.channels

        Nothing ->
            model.channels


scrollMessages : Cmd Msg
scrollMessages =
    Task.attempt (\_ -> NoOp) (Dom.Scroll.toBottom "chat-messages")
