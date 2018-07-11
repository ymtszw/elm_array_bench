module ContainerInit exposing (main)

import Array
import Array.Hamt as Hamt
import Benchmark exposing (..)
import Benchmark.Runner exposing (BenchmarkProgram, program)


sampleSuite : Benchmark
sampleSuite =
    describe "Container initialize"
        [ Benchmark.compare "Array"
            "1000 elements"
            (\_ -> Array.initialize 1000 (always 0))
            "100000 elements"
            (\_ -> Array.initialize 100000 (always 0))
        , Benchmark.compare "Array.Hamt"
            "1000 elements"
            (\_ -> Hamt.initialize 1000 (always 0))
            "100000 elements"
            (\_ -> Hamt.initialize 100000 (always 0))
        , Benchmark.compare "List"
            "1000 elements"
            (\_ -> List.repeat 1000 0)
            "100000 elements"
            (\_ -> List.repeat 100000 0)
        ]


main : BenchmarkProgram
main =
    program sampleSuite
