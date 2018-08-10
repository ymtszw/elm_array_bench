module Length exposing (main)

import Array
import Array.Hamt as Hamt
import Benchmark exposing (..)
import Benchmark.Runner exposing (BenchmarkProgram, program)


sampleSuite : Benchmark
sampleSuite =
    let
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
        describe "Get container length"
            [ Benchmark.compare "Array"
                "1000 elements"
                (\_ -> Array.length array1000)
                "100000 elements"
                (\_ -> Array.length array100000)
            , Benchmark.compare "Array.Hamt"
                "1000 elements"
                (\_ -> Hamt.length hamt1000)
                "100000 elements"
                (\_ -> Hamt.length hamt100000)
            , Benchmark.compare "List"
                "1000 elements"
                (\_ -> List.length list1000)
                "100000 elements"
                (\_ -> List.length list100000)
            ]


main : BenchmarkProgram
main =
    program sampleSuite
