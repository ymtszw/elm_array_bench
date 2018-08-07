module RangeAccess exposing (main)

import Array
import Array.Hamt as Hamt
import Benchmark exposing (..)
import Benchmark.Runner exposing (BenchmarkProgram, program)


suite : Benchmark
suite =
    let
        array100000 =
            Array.initialize 100000 (always 0)

        hamt100000 =
            Hamt.initialize 100000 (always 0)

        list100000 =
            List.repeat 100000 0
    in
        describe "Range access (100000 elements, get 1000)"
            [ Benchmark.benchmark "Array.slice (from the first)" <|
                \_ -> Array.slice 0 1000 array100000
            , Benchmark.benchmark "Array.Hamt.slice (from the first)" <|
                \_ -> Hamt.slice 0 1000 hamt100000
            , Benchmark.benchmark "List.take (from the first)" <|
                \_ -> List.take 1000 list100000
            , Benchmark.compare "Array.slice"
                "(from 50000th)"
                (\_ -> Array.slice 50000 51000 array100000)
                "(from 99000th)"
                (\_ -> Array.slice 90000 100000 array100000)
            , Benchmark.compare "Array.Hamt.slice"
                "(from 50000th)"
                (\_ -> Hamt.slice 50000 51000 hamt100000)
                "(from 99000th)"
                (\_ -> Hamt.slice 99000 100000 hamt100000)
            ]


main : BenchmarkProgram
main =
    program suite
