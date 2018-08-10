module SingleSetComparison exposing (main)

import Array
import Array.Hamt as Hamt
import Benchmark exposing (..)
import Benchmark.Runner exposing (BenchmarkProgram, program)


suite : Benchmark
suite =
    let
        array1000 =
            Array.initialize 1000 (always 0)

        array999 =
            Array.initialize 999 (always 0)

        array500 =
            Array.initialize 500 (always 0)

        array1 =
            Array.fromList [ 1 ]

        array0 =
            Array.fromList []

        hamt1000 =
            Hamt.initialize 1000 (always 0)

        hamt999 =
            Hamt.initialize 999 (always 0)

        hamt500 =
            Hamt.initialize 500 (always 0)

        hamt1 =
            Hamt.fromList [ 1 ]

        hamt0 =
            Hamt.fromList []
    in
        describe "Single set comparison"
            [ describe "Set to a fixed length Array (1000-length)"
                [ Benchmark.compare "Set at the first"
                    "Array.set"
                    (\_ -> Array.set 0 1 array1000)
                    "Hamt.set"
                    (\_ -> Hamt.set 0 1 hamt1000)
                , Benchmark.compare "Set at the middle"
                    "Array.set"
                    (\_ -> Array.set 500 1 array1000)
                    "Hamt.set"
                    (\_ -> Hamt.set 500 1 hamt1000)
                , Benchmark.compare "Set at the last"
                    "Array.set"
                    (\_ -> Array.set 999 1 array1000)
                    "Hamt.set"
                    (\_ -> Hamt.set 999 1 hamt1000)
                ]
            , describe "Append two Arrays"
                [ Benchmark.compare "Append to 0-length Array"
                    "Array.append"
                    (\_ -> Array.append array0 array1)
                    "Hamt.append"
                    (\_ -> Hamt.append hamt0 hamt1)
                , Benchmark.compare "Append to 500-length Array"
                    "Array.append"
                    (\_ -> Array.append array500 array1)
                    "Hamt.append"
                    (\_ -> Hamt.append hamt500 hamt1)
                , Benchmark.compare "Append to 999-length Array"
                    "Array.append"
                    (\_ -> Array.append array999 array1)
                    "Hamt.append"
                    (\_ -> Hamt.append hamt999 hamt1)
                ]
            , describe "Push to an Array"
                [ Benchmark.compare "Push to a 0-length Array"
                    "Array.push"
                    (\_ -> Array.push 1 array0)
                    "Hamt.push"
                    (\_ -> Hamt.push 1 hamt0)
                , Benchmark.compare "Push to a 500-length Array"
                    "Array.push"
                    (\_ -> Array.push 1 array500)
                    "Hamt.push"
                    (\_ -> Hamt.push 1 hamt500)
                , Benchmark.compare "Push to a 999-length Array"
                    "Array.push"
                    (\_ -> Array.push 1 array999)
                    "Hamt.push"
                    (\_ -> Hamt.push 1 hamt999)
                ]
            ]


main : BenchmarkProgram
main =
    program suite
