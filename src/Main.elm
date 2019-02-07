module Main exposing (Model, Msg(..), init, main, update, view)

import Array
import Browser
import Html exposing (Html, a, button, div, h1, img, text)
import Html.Attributes exposing (class, href, src, style)
import Html.Events exposing (onClick)
import Random



---- MODEL ----


type alias Model =
    { reasons : List String, currentReason : Maybe String }


init : ( Model, Cmd Msg )
init =
    ( { reasons = reasonList, currentReason = Nothing }, Cmd.none )



---- UPDATE ----


type Msg
    = NewReason
    | RandomNumber Int


reasonList =
    [ "1. No commute! Working remotely cuts the average commute time from 25.4 minutes to ZERO"
    , "2. You save a whole lot of money on gas"
    , "3. You don’t have to worry about getting a flat tire on the way to work (Note: also can’t use that as an excuse anymore!)"
    , "4. You will never get pulled over by the police on the way to work"
    , "6. Car insurance can actually be cheaper (fewer miles per year = save money!)"
    , "7. Your daily life is unaffected when a nearby interstate collapses, buckles, or is covered with a toxic spill"
    , "8. You no longer have to deal with road rage (either your own or some other crazy fool)"
    , "9. You can eat lunch in the forest."
    , "10. You get a little extra sleep when you don’t have to factor a commute into your day"
    , "11. Sweatpants – We are so on board with Andy Orin’s Lifehacker ode to sweatpants. (But if you have to get dressed up to get into work mode, that’s all good, too!)"
    , "12. Love from pets all day every day"
    , "13. Private bathroom 🙂 (You KNOW you appreciate this!)"
    , "14. Being free to just not go outside when the weather’s horrid"
    , "14. Being free to just go outside when the weather is heavenly"
    , "15. Freedom to manage your own time"
    , "16. Fewer uncontrollable distractions"
    , "17. No fighting over the thermostat"
    , "18. No one to pinch you when you don’t wear green on St. Patrick’s Day"
    , "19. No fire drills"
    , "20. You don’t have to see anyone on your “ugly days”"
    , "21. You can watch the sun come up while working."
    , "22. If you don’t like what a coworker is saying, you can just mute them with the click of a button"
    , "25. No depressing fluorescent lighting"
    , "26. Your own desk/office setup – no cubicles. Or worse – open office plans "
    , "27. People aren’t walking behind you all day"
    , "28. Freedom to travel and work wherever you want"
    , "29. You don’t have to restructure your whole day to wait for a service technician to come fix something. Comcast’s “4 hour service window” is suddenly OK"
    , "30. Birds for background noise."
    , "31. Having the flexibility to help out during the workweek"
    , "32. You can sign for packages"
    , "33. You can do laundry during weekdays"
    , "34. You can choose your own decor and nobody can judge you for it. "
    , "35. Never have to worry about leaving badge/laptop/charger/lunch/whatever at home"
    , "36. Flexibility to live wherever you want and not worry about the job market in that area or the distance from your home to the office"
    , "37. You can see epic urban forest from your screened in porch every day and still have an awesome job"
    , "38. It’s easier to volunteer/give back to your community when you’re nearby every day"
    , "39. You don’t have to wear shoes"
    , "40. Your keyboard can be as loud as you want!"
    , "41. You can avoid annoying co-workers (and you probably don’t even have them)"
    , "42. You only have to dress (nicely) from the waist up for video conferences"
    , "43. Can pick up kids from school without people in the office looking at you funny"
    , "44. You can go to all of your kids’ school and sports events"
    , "45. You’re home well before your kids go to bed"
    , "46. Have 300+ million people in the US – easier to find amazing teammates than being constrained to a city"
    , "47. You know that your co-workers get all these benefits too!"
    , "48. You always have the corner office/window view"
    , "49. No claustrophobic elevators"
    , "50. You can AirBNB/Homeaway travel and not miss a day of work as long as you have internet"
    , "51. You never have to wait to use the microwave. And you can cook what you want."
    , "52. When the coffee runs out, you only have yourself to blame"
    , "53. You don’t have to fix your hair (until it’s time to video chat – and sometimes not even then)"
    , "54. It’s much easier to put your Do Not Disturb sign up and concentrate deeply on work"
    , "55. You can work at a tech company and not live in San Francisco"
    , "56. Want to move? No problem! You don’t need to get a new job."
    , "57. You can work super early or super late if you want"
    , "58. You don’t have to worry about who has keys to the office or whether the door is unlocked"
    , "59. You can blast your music and no one will yell at you to keep it down"
    , "60. Unless you have a vending machine at home, your snacks are a lot cheaper, and likely healthier"
    , "61. You can enjoy last night’s leftovers for lunch without carting them around"
    , "62. You can eat smelly food without dirty looks"
    , "63. You have more time to cook dinner (or lunch!)"
    , "64. No spending money on lunches out"
    , "65. You can have groceries delivered while everyone else is at work"
    , "66. You can make “good coffee” at home. No more subpar beans"
    , "67. You roast coffee while working"
    , "68. No need to possess a lunchbox or travel mug"
    , "69. Nobody at work will judge you (or know) if drink 15 cups of coffee a\n    day."
    , "70. Throw stuff on the smoker or slow cooker at lunch, it’s ready for dinner"
    , "71. Nobody steals your sandwich"
    , "72. Nobody leaves passive aggressive notes about the state of your fridge or the cleanliness of your kitchen area"
    , "73. 30 minutes of exercise really only takes 30 minutes… no changing (or showers!) required"
    , "74. No one has to smell you after your lunchtime run, either"
    , "76. You can take yoga/stretch breaks without getting weird looks from co-workers"
    , "78. Your co-workers can take a midday dance break if they darn well want to"
    , "79. You never have to worry about a coworker passing the flu around the office (Note: kids will still bring them home from school, sorry)"
    , "80. You don’t have to make big decisions about getting dressed/commuting/sharing germs when you’re still “a little bit sick” but not sick enough to miss work"
    , "81. Hungover? Take a lunchtime nap without sneaking out to your car"
    , "82. The mute button does wonders for covering a cough or sneeze during video conferences"
    , "83. You can perfect the coffee nap (as our team does)"
    , "84. The bed/couch is closer by so lunch naps can be fractionally longer"
    , "85. And one more time. You can love on your furry friends all day long."
    ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NewReason ->
            ( model
            , generateRandomReason model.reasons
            )

        RandomNumber randomNumber ->
            let
                reason =
                    Array.fromList model.reasons |> Array.get randomNumber
            in
            if model.currentReason == reason then
                ( model, generateRandomReason model.reasons )

            else
                ( { model | currentReason = reason }, Cmd.none )


generateRandomReason : List String -> Cmd Msg
generateRandomReason set =
    Random.generate RandomNumber (Random.int 0 (List.length set - 1))


showReason : Maybe String -> Html Msg
showReason reason =
    let
        givenReason =
            case reason of
                Just r ->
                    r

                Nothing ->
                    "Freedom"
    in
    h1 [] [ text givenReason ]



---- VIEW ----


view : Model -> Html Msg
view model =
    div [ class "view" ]
        [ img [ src "/porch.jpg" ] []
        , h1 [] [ text "Why Remote?" ]
        , button [ class "button", onClick NewReason ] [ text "Tell me More" ]
        , showReason model.currentReason
        , a
            [ class "footnote"
            , href
                "https://life.taxjar.com/remote-work-love/"
            ]
            [ text "Reasons adapted from TaxJar.com" ]
        ]



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
