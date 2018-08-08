module PushAndCons exposing (main)

import Array
import Array.Hamt as Hamt
import Benchmark exposing (..)
import Benchmark.Runner exposing (BenchmarkProgram, program)


suite : Benchmark
suite =
    let
        array10000 =
            Array.initialize 10000 (always 0)

        array1 =
            Array.fromList [ 0 ]

        hamt10000 =
            Hamt.initialize 10000 (always 0)

        hamt1 =
            Hamt.fromList [ 0 ]

        list10000 =
            List.repeat 10000 0
    in
        describe "Push and Cons to containers (10000 elements)"
            [ describe "Push (append)"
                [ Benchmark.benchmark "Array.push" <|
                    \_ -> Array.push 0 array10000
                , Benchmark.benchmark "Array.Hamt.push" <|
                    \_ -> Hamt.push 0 hamt10000
                , Benchmark.benchmark "List.append" <|
                    \_ -> List.append list10000 [ 0 ]
                ]
            , describe "Cons (prepend)"
                [ Benchmark.benchmark "Array.append" <|
                    \_ -> Array.append array1 array10000
                , Benchmark.benchmark "Array.Hamt.append" <|
                    \_ -> Hamt.append hamt1 hamt10000
                , Benchmark.benchmark "List.(::)" <|
                    \_ -> 0 :: list10000
                ]
            ]


main : BenchmarkProgram
main =
    program suite
