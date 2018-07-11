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
    in
        describe "Array"
            [ Benchmark.compare "index access"
                "Array of 10 elements, access to 5th"
                (\_ -> Array.get 5 array10)
                "Array of 1000 elements, access to 500th"
                (\_ -> Array.get 500 array1000)
            , Benchmark.compare "index access"
                "Array of 1000 elements, access to 500th"
                (\_ -> Array.get 500 array1000)
                "Array of 100000 elements, access to 50000th"
                (\_ -> Array.get 50000 array1000)
            , Benchmark.compare "index access"
                "Array of 1000 elements, access to 500th"
                (\_ -> Array.get 500 array1000)
                "Array.Hamt of 1000 elements, access to 500th"
                (\_ -> Hamt.get 500 hamt1000)
            , Benchmark.compare "index access"
                "Array of 100000 elements, access to 50000th"
                (\_ -> Array.get 50000 array100000)
                "Array.Hamt of 100000 elements, access to 50000th"
                (\_ -> Hamt.get 50000 hamt100000)
            , Benchmark.compare "index access (for reference)"
                "Array of 1000 elements, access to 500th"
                (\_ -> Array.get 500 array1000)
                "List of 1000 elements, access to 500th"
                (\_ -> list1000 |> List.drop 500 |> List.head)
            ]


main : BenchmarkProgram
main =
    program sampleSuite
