module Pages.Top exposing (Model, Msg, Params, page)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font exposing (center)
import Html
import Html.Attributes
import Spa.Document exposing (Document)
import Spa.Page as Page exposing (Page)
import Spa.Url exposing (Url)


type alias Params =
    ()


type alias Model =
    Url Params


type alias Msg =
    Never


page : Page Params Model Msg
page =
    Page.static
        { view = view
        }



-- VIEW


view : Url Params -> Document Msg
view { params } =
    { title = "Homepage"
    , body =
        [ title
        , column [ paddingXY 0 20, spacing 12 ]
            [ paragraph [ spacing 8 ] [ intro ]
            , paragraph [ paddingXY 0 10 ] [ join ]
            ]
        , column [ spacing 12, centerX, width fill ] <|
            List.map poolView pools
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
    , { ticker = "DSOE2", id = "084d2f15d6e057f4a077bf0dc154eb33516aa81c684acadbb879413c" }
    , { ticker = "DSOE3", id = "084d2f15d6e057f4a077bf0dc154eb33516aa81c684acadbb879413c" }
    ]


poolView pool =
    el
        [ Background.color (rgb 0.8 0.8 0.8)
        , width fill
        , height (px 100)
        , Border.rounded 10
        , Font.color (rgb 0 0 0)

        -- , center
        ]
    <|
        column
            [ padding 8, spacing 8 ]
            [ el [] (text pool.ticker)
            , el [] (idView pool.id)
            ]


idView id =
    Element.html <|
        Html.span
            [ Html.Attributes.style "overflow" "hidden"
            , Html.Attributes.style "text-overflow" "ellipsis"
            , Html.Attributes.style "max-width" "300px"
            ]
            [ Html.text id ]
