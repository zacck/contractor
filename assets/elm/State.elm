module State exposing(..)


import Http 
import Json.Encode as Encode 
import Json.Decode as Decode 
import Types exposing (Model, Msg(..))
import Utils exposing (graphUrl, queryBody, resultDecoder, authedGraphRequest)

-- Draw up a people query
peopleQuery : String
peopleQuery =
    """
    {
      people {
        id
        name
      }
    }
    """



update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
   case msg of
     FetchPeople response ->
       case response of
         Ok result ->
           { response = result } ! []

         Err err ->
           { response = toString err } ! []



