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

        array0 =
            Array.fromList []

        hamt1000 =
            Hamt.initialize 1000 (always 0)

        hamt0 =
            Hamt.fromList []

        list1000 =
            List.repeat 1000 1
    in
        describe "Bulk set comparison"
            [ Benchmark.compare "Sequentially set to a fixed length Array"
                "Array.set 1000 times"
                (\_ -> list1000 |> List.foldl (\elem ( array, index ) -> ( Array.set index elem array, index + 1 )) ( array1000, 0 ))
                "Hamt.set 1000 times"
                (\_ -> list1000 |> List.foldl (\elem ( array, index ) -> ( Hamt.set index elem array, index + 1 )) ( hamt1000, 0 ))
            , Benchmark.compare "Append two Arrays"
                "Array.append 1000 elements array to empty array"
                (\_ -> Array.append array0 (Array.fromList list1000))
                "Hamt.append 1000 elements array to empty array"
                (\_ -> Hamt.append hamt0 (Hamt.fromList list1000))
            , Benchmark.compare "Sequentially push to a 0-length Array"
                "Array.push 1000 times"
                (\_ -> list1000 |> List.foldl (\elem array -> Array.push elem array) array0)
                "Hamt.push 1000 times"
                (\_ -> list1000 |> List.foldl (\elem array -> Hamt.push elem array) hamt0)
            ]


main : BenchmarkProgram
main =
    program suite
