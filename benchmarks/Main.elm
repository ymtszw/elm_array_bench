module Main exposing (main)

import Html
import Html.Attributes


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }


init : ( Model, Cmd Msg )
init =
    ( emptyModel, Cmd.none )



-- MODEL


type alias Model =
    {}


emptyModel : Model
emptyModel =
    {}



-- UPDATE


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )



-- VIEW


view : Model -> Html.Html Msg
view model =
    Html.div []
        [ Html.h1 [] [ Html.text "Container benchmarks" ]
        , Html.ul []
            [ Html.li [] [ Html.a [ Html.Attributes.href "container_init.html" ] [ Html.text "initialization" ] ]
            , Html.li [] [ Html.a [ Html.Attributes.href "container_index_access.html" ] [ Html.text "index access" ] ]
            ]
        ]
