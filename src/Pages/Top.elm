module Pages.Top exposing (Model, Msg, Params, page)

import Element exposing (..)
import Element.Background as Background
import Element.Font as Font
import Html
import Html.Attributes
import Html.Events
import Process
import Shared exposing (subscriptions, update)
import Spa.Document exposing (Document)
import Spa.Page as Page exposing (Page)
import Spa.Url exposing (Url)
import Task


type alias Params =
    ()


type alias Id =
    String


type Model
    = None
    | Pool Id


type Msg
    = Copied Model


page : Page Params Model Msg
page =
    Page.element
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


init : Url Params -> ( Model, Cmd Msg )
init { params } =
    ( None, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Copied (Pool id) ->
            ( Pool id, delay 3000 (Copied None) )

        Copied None ->
            ( None, Cmd.none )


delay : Float -> msg -> Cmd msg
delay time msg =
    Process.sleep time
        |> Task.andThen (always <| Task.succeed msg)
        |> Task.perform identity


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Document Msg
view model =
    { title = "Homepage"
    , body =
        [ title
        , column [ paddingXY 0 20, spacing 12 ]
            [ paragraph [ spacing 8 ] [ intro ]
            , paragraph [ paddingXY 0 10 ] [ join ]
            ]
        , column [ spacing 12, centerX, width fill ] <|
            List.map (poolView model) pools
        ]
    }


title =
    row
        [ centerX
        , padding 20
        , Font.family
            [ Font.typeface "Major Mono Display"
            , Font.sansSerif
            ]
        , Font.size 40
        ]
        [ text "stAkeocrAcy" ]


intro =
    text """
        Want to help decide how your pool operates?  Want to focus your talent and resources on building a brighter future for everyone?
    """


join =
    text """
        Join a Decentralised Stakepool Organisation today!
    """


pools =
    [ { ticker = "DSOE1", id = "084d2f15d6e057f4a077bf0dc154eb33516aa81c684acadbb879413c" }
    , { ticker = "DSOE2", id = "184d2f15d6e057f4a077bf0dc154eb33516aa81c684acadbb879413c" }
    , { ticker = "DSOE3", id = "c314978bbdaca486c18aa61533be451cd0fb770a4f750e6d51f2d480" }
    ]


poolView model pool =
    el
        [ Background.color (rgb 0.8 0.8 0.8)
        , width fill
        , height (px 100)
        , Font.color (rgb 0 0 0)
        ]
    <|
        column
            [ spacing 12, width fill, centerY ]
            [ el [ Font.size (scaled 4), centerX ] (text pool.ticker)
            , row [ spacing 12, centerX ]
                [ el [] (idView pool.id)
                , el [] (clipboardCopy model pool.id)
                ]
            ]


clipboardCopy model poolId =
    let
        label =
            case model of
                Pool id ->
                    if id == poolId then
                        "copied!"

                    else
                        "copy"

                None ->
                    "copy"
    in
    Element.html <|
        Html.node "clipboard-copy"
            [ Html.Attributes.attribute "value" poolId ]
            [ Html.button [ Html.Events.onClick <| Copied (Pool poolId) ] [ Html.text label ] ]


idView id =
    Element.html <|
        Html.span
            [ Html.Attributes.style "overflow" "hidden"
            , Html.Attributes.style "text-overflow" "ellipsis"
            , Html.Attributes.style "width" "70vw"
            , Html.Attributes.style "max-width" "460px"
            ]
            [ Html.text id ]


scaled : Int -> Int
scaled factor =
    Element.modular 16 1.25 factor |> round
