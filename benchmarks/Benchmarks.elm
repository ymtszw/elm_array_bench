module Benchmarks exposing (main)

import Array
import Array.Hamt as Hamt
import Benchmark exposing (..)
import Benchmark.Runner exposing (BenchmarkProgram, program)


sampleSuite : Benchmark
sampleSuite =
    let
        array10 =
            Array.initialize 10 (always 0)

        array1000 =
            Array.initialize 1000 (always 0)

        array100000 =
            Array.initialize 100000 (always 0)

        hamt1000 =
            Hamt.initialize 1000 (always 0)

        hamt100000 =
            Hamt.initialize 100000 (always 0)

        list1000 =
            List.repeat 1000 0

        list100000 =
            List.repeat 100000 0
    in
        describe "Container"
            [ describe "index access"
                [ Benchmark.compare "Array 10 to 1000 elements"
                    "Array(10), access to 5th"
                    (\_ -> Array.get 5 array10)
                    "Array(1000), access to 500th"
                    (\_ -> Array.get 500 array1000)
                , Benchmark.compare "Array 1000 to 100000 elements"
                    "Array(1000), access to 500th"
                    (\_ -> Array.get 500 array1000)
                    "Array(100000), access to 50000th"
                    (\_ -> Array.get 50000 array100000)
                , Benchmark.compare "Array and Array.Hamt, 1000 elements"
                    "Array(1000), access to 500th"
                    (\_ -> Array.get 500 array1000)
                    "Array.Hamt(1000), access to 500th"
                    (\_ -> Hamt.get 500 hamt1000)
                , Benchmark.compare "Array and Array.Hamt, 100000 elements"
                    "Array(100000), access to 50000th"
                    (\_ -> Array.get 50000 array100000)
                    "Array.Hamt(100000), access to 50000th"
                    (\_ -> Hamt.get 50000 hamt100000)
                , Benchmark.compare "Array and List, 1000 elements"
                    "Array(1000), access to 500th"
                    (\_ -> Array.get 500 array1000)
                    "List(1000), access to 500th"
                    (\_ -> list1000 |> List.drop 500 |> List.head)
                , Benchmark.compare "List 1000 to 100000 elements"
                    "List(1000), access to 500th"
                    (\_ -> list1000 |> List.drop 500 |> List.head)
                    "List(100000), access to 50000th"
                    (\_ -> list100000 |> List.drop 50000 |> List.head)
                ]
            , describe "initialize"
                [ Benchmark.benchmark "Array 1000" <|
                    \_ -> Array.initialize 1000 (always 0)
                , Benchmark.benchmark "Array 100000" <|
                    \_ -> Array.initialize 100000 (always 0)
                , Benchmark.benchmark "Array.Hamt 1000" <|
                    \_ -> Hamt.initialize 1000 (always 0)
                , Benchmark.benchmark "Array.Hamt 100000" <|
                    \_ -> Hamt.initialize 100000 (always 0)
                , Benchmark.benchmark "List 1000" <|
                    \_ -> List.repeat 1000 0
                , Benchmark.benchmark "List 100000" <|
                    \_ -> List.repeat 100000 0
                ]
            ]


main : BenchmarkProgram
main =
    program sampleSuite
