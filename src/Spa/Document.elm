module Spa.Document exposing
    ( Document
    , map
    , toBrowserDocument
    )

import Browser
import Element exposing (..)
import Element.Font as Font


type alias Document msg =
    { title : String
    , body : List (Element msg)
    }


map : (msg1 -> msg2) -> Document msg1 -> Document msg2
map fn doc =
    { title = doc.title
    , body = List.map (Element.map fn) doc.body
    }


toBrowserDocument : Document msg -> Browser.Document msg
toBrowserDocument doc =
    { title = doc.title
    , body =
        [ Element.layout
            [ Font.color (rgb 1 1 1)
            , Font.family
                [ Font.typeface "Montserrat"
                , Font.sansSerif
                ]
            ]
            (column
                [ width (fill |> maximum 600)
                , centerX
                ]
                doc.body
            )
        ]
    }
