module Data.Examples exposing (getExample, Example(..))


type Example
    = HelloWorld
    | Application
    | Currying
    | Structs
    | Pipes
    | SumList


getExample : Example -> String
getExample example =
    String.trim
        ("module Main exposing (..)\n\n"
            ++ case example of
                HelloWorld ->
                    helloWorld

                Application ->
                    application

                Structs ->
                    structs

                Currying ->
                    currying

                Pipes ->
                    pipes

                SumList ->
                    sumList
        )
        ++ "\n\n"


helloWorld : String
helloWorld =
    """
run : String
run =
    "Hello, world!"
"""


application : String
application =
    """
append : String -> String -> String
append a b =
    a ++ b

run : String
run =
    -- You can call a function by calling its name and separating
    -- arguments with a space
    append "argument1 " "argument2"
"""


structs : String
structs =
    """
type Breed
    = Dog
    | Cat
    | Fox


type alias Animal =
    { name : String
    , breed : Breed
    , age : Int
    }


speak : Animal -> String
speak animal =
    case animal.breed of
        Dog ->
          "Woof!"

        Cat ->
          "Meow"

        Fox ->
          "???"


run : String
run =
    speak (Animal "Garfield" Cat 10)


  """


currying : String
currying =
    """
add : Int -> Int -> Int
add x y =
    x + y

-- You can apply only some of the arguments to return a
-- function waiting for more
add2 : Int -> Int
add2 =
    add 2

-- Operators are just functions used in infix, you can use them
-- as a regular function by wrapping them in parenthesis.
add4 : Int -> Int
add4 =
    (+) 4


run : List Int
run =
    [ add 10 2
    , add2 10
    , add4 8
    ]
"""


sumList : String
sumList =
    """
sum : List Int -> Int
sum list =
    case list of
        [] -> 0
        x :: xs -> x + sum xs

run : Int
run =
    sum [ 1, 2, 3, 4 ]
"""


pipes : String
pipes =
    """
-- You can use pipe operator, to pass result of a function
-- As a last argument to the function on a right

run : String
run =
    1
    |> (+) 2
    |> toString
    |> (++) "Number: "
    |> String.reverse
"""
