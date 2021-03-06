module Main exposing (..)

import Html exposing(Html)
import Http
import Types exposing (Model, Msg(..), Page(..))
import State exposing (update, setRoute)
import View exposing (view)
import Navigation exposing (Location)
import Select




main =
  Navigation.program SetRoute
      { init = init
      , view = view
      , update = update
      , subscriptions = \_ -> Sub.none
      }


initialModel : Model
initialModel =
    { response = "Waiting for a response ..."
    , token = ""
    , page = Home
    , name = ""
    , email = ""
    , password = ""
    , passwordconf = ""
    , errors = []
    , loggedId = Nothing
    , contractCategory = ""
    , contractCost = 0.0
    , contractVendor = ""
    , endsDate = ""
    , people = []
    , contracts = []
    , activeContract = ""
    , selectedVendorId = Nothing
    , vendorSelectState = Select.newState ""
    , availableVendors = []
    , selectedCategoryId = Nothing
    , categorySelectState = Select.newState ""
    , availableCategories = []
    }

init : Location -> (Model, Cmd Msg)
init location =
  let
      initTuple =
       setRoute location initialModel
   in
       initTuple


-- Http.send FetchPeople (authedGraphRequest "" peopleQuery) ]
