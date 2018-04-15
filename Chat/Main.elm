port module Chat exposing (..)

import Dict exposing (Dict)
import Dom exposing (focus)
import Dom.Scroll
import Html exposing (programWithFlags)
import Models.Channel
import Models.Message
import Models.ViewVisibility
import Task
import Types
    exposing
        ( Channel
        , ChannelName
        , ChatMessage
        , Flags
        , Member
        , MemberId
        , Model
        , Msg(..)
        )
import Views exposing (view)


main : Program Flags Model Msg
main =
    programWithFlags
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }


init : Flags -> ( Model, Cmd Msg )
init flags =
    let
        members =
            flags.members
                |> List.map (\m -> ( m.id, m ))
                |> Dict.fromList

        channels =
            flags.channels
                |> List.map (\c -> ( c.name, c ))
                |> Dict.fromList
    in
    { emptyModel
        | members = members
        , channels = channels
        , currentMemberId = flags.currentMemberId
        , activeChannel = flags.activeChannel
    }
        ! []


emptyModel : Model
emptyModel =
    { channels = Dict.empty
    , members = Dict.empty
    , activeChannel = ""
    , currentMessages = Dict.empty
    , currentMemberId = 0
    , selectedMemberId = Nothing
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
                newMemberId =
                    case model.selectedMemberId of
                        Just id ->
                            if id /= memberId then
                                Just memberId
                            else
                                Nothing

                        Nothing ->
                            Just memberId

                newVisibility =
                    newMemberId /= Nothing

                viewVisibility =
                    model.viewVisibility

                newViewVisibility =
                    { viewVisibility | memberSidebar = newVisibility }
            in
            { model
                | viewVisibility = newViewVisibility
                , selectedMemberId = newMemberId
            }
                ! []


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
