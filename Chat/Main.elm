port module Chat exposing (..)

import Dict exposing (Dict)
import Html exposing (program)
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
                }
              )
            , ( "general"
              , { name = "general"
                , members = []
                }
              )
            , ( "engineering"
              , { name = "engineering"
                , members = []
                }
              )
            ]
                |> Dict.fromList

        activeChannel =
            "general"

        messages =
            [ { member = { name = "dan" }, message = "This is a test message." }
            , { member = { name = "jake" }, message = "Messages are cool." }
            , { member = { name = "fyodor" }, message = "Something something whatever." }
            ]

        currentMember =
            { name = "Dan" }
    in
    { emptyModel
        | channels = channels
        , activeChannel = activeChannel
        , messages = messages
        , currentMember = currentMember
    }
        ! []


emptyModel : Model
emptyModel =
    { channels = Dict.empty
    , activeChannel = ""
    , messages = []
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
            { model | currentMessage = Just (ChatMessage model.currentMember message) } ! []

        SendMessage ->
            let
                newMessage =
                    case model.currentMessage of
                        Just chatMessage ->
                            [ chatMessage ]

                        Nothing ->
                            []
            in
            { model | messages = model.messages ++ newMessage, currentMessage = Nothing } ! []
