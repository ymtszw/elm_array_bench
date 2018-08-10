module BulkSetComparison exposing (main)

import Array
import Array.Hamt as Hamt
import Benchmark exposing (..)
import Benchmark.Runner exposing (BenchmarkProgram, program)


suite : Benchmark
suite =
    let
        array1000 =
            Array.initialize 1000 (always 0)

        array500 =
            Array.initialize 500 (always 0)

        array0 =
            Array.fromList []

        hamt1000 =
            Hamt.initialize 1000 (always 0)

        hamt500 =
            Hamt.initialize 500 (always 0)

        hamt0 =
            Hamt.fromList []

        list1000 =
            List.repeat 1000 1

        list500 =
            List.repeat 500 1
    in
        describe "Bulk set comparison"
            [ describe "Sequentially set to a fixed 1000-length Array"
                [ Benchmark.compare "1000 items from the first"
                    "Array.set"
                    (\_ -> list1000 |> List.foldl (\elem ( array, index ) -> ( Array.set index elem array, index + 1 )) ( array1000, 0 ))
                    "Hamt.set"
                    (\_ -> list1000 |> List.foldl (\elem ( array, index ) -> ( Hamt.set index elem array, index + 1 )) ( hamt1000, 0 ))
                , Benchmark.compare "500 items from the middle"
                    "Array.set"
                    (\_ -> list500 |> List.foldl (\elem ( array, index ) -> ( Array.set index elem array, index + 1 )) ( array1000, 500 ))
                    "Hamt.set"
                    (\_ -> list500 |> List.foldl (\elem ( array, index ) -> ( Hamt.set index elem array, index + 1 )) ( hamt1000, 500 ))
                ]
            , describe "Append two Arrays"
                [ Benchmark.compare "1000 items into empty array"
                    "Array.append"
                    (\_ -> Array.append array0 (Array.fromList list1000))
                    "Hamt.append"
                    (\_ -> Hamt.append hamt0 (Hamt.fromList list1000))
                , Benchmark.compare "500 items into 500-length array"
                    "Array.append"
                    (\_ -> Array.append array500 (Array.fromList list500))
                    "Hamt.append"
                    (\_ -> Hamt.append hamt500 (Hamt.fromList list500))
                ]
            , describe "Sequentially push to an Array"
                [ Benchmark.compare "1000 items to empty array"
                    "Array.push"
                    (\_ -> list1000 |> List.foldl (\elem array -> Array.push elem array) array0)
                    "Hamt.push"
                    (\_ -> list1000 |> List.foldl (\elem array -> Hamt.push elem array) hamt0)
                , Benchmark.compare "500 items to 500-length array"
                    "Array.push"
                    (\_ -> list500 |> List.foldl (\elem array -> Array.push elem array) array500)
                    "Hamt.push"
                    (\_ -> list500 |> List.foldl (\elem array -> Hamt.push elem array) hamt500)
                ]
            ]


main : BenchmarkProgram
main =
    program suite
