import Unify

-- Example usage
example1 :: UnifyResult
example1 = unify (Var "X") (Atom "alice")
-- Should return: Success (fromList [("X", Atom "alice")])

example2 :: UnifyResult
example2 = unify 
    (Predicate "likes" 2 [Var "X", Atom "ice_cream"])
    (Predicate "likes" 2 [Atom "bob", Var "Y"])
-- Should return: Success (fromList [("X", Atom "bob"), ("Y", Atom "ice_cream")])

example3 :: UnifyResult
example3 = unify
    (Predicate "f" 1 [Var "X"])
    (Predicate "f" 1 [Predicate "g" 1 [Var "X"]])
-- Should return: Failure (occurs check)

example4 :: UnifyResult
example4 = unify
    (Predicate "p" 2 [Var "X", Var "Y"])
    (Predicate "p" 2 [Var "Y", Atom "a"])
-- Should return: Success (fromList [("X", Var "Y"), ("Y", Atom "a")])
-- Note: Could be further resolved to [("X", Atom "a"), ("Y", Atom "a")]

example5 :: UnifyResult
example5 = unify
    (Predicate "append" 3 [
        (Predicate "cons" 2 [
            (Atom "a"),
            (Predicate "cons" 2 [
                (Atom "b"),
                (Predicate "void" 0 [])
            ])]
            ),
        (Predicate "cons" 2 [
            (Atom "c"),
            (Predicate "cons" 2 [
                (Atom "d"),
                (Predicate "void" 0 [])
            ])]
            ),
        (Var "Ls")
    ])
    (Predicate "append" 3 [
        (Predicate "cons" 2 [
            (Var "X"),
            (Var "Xs")
        ]),
        (Var "Ys"),
        (Predicate "cons" 2 [
            (Var "X"),
            (Var "Zs")
        ])
    ])

example6 :: UnifyResult
example6 = unify
    (Predicate "append" 3 [
        (Predicate "cons" 2 [
            (Atom "b"),
            (Predicate "void" 0 [])
        ]),
        (Predicate "cons" 2 [
            (Atom "c"),
            (Predicate "cons" 2 [
                (Atom "d"),
                (Predicate "void" 0 [])
            ])
        ]),
        (Var "L")
    ])
    (Predicate "append" 3 [
        (Predicate "cons" 2 [
            (Var "X"),
            (Var "Xs")
        ]),
        (Var "Ys"),
        (Predicate "cons" 2 [
            (Var "X"),
            (Var "Zs")
        ])
    ])

example7 :: UnifyResult
example7 = unify
    (Predicate "hanoi" 5 [
        (Predicate "s" 1 [(Var "N")]),
        (Var "A"),
        (Var "B"),
        (Var "C"),
        (Var "Ms")
    ])
    (Predicate "hanoi" 5 [
        (Predicate "s" 1 [(Predicate "s" 1 [(Atom "0")])]),
        (Atom "a"),
        (Atom "b"),
        (Atom "c"),
        (Var "Xs")
    ])


main :: IO ()
main = do
    putStrLn "Example 1:"
    print example1
    putStrLn "\nExample 2:"
    print example2
    putStrLn "\nExample 3:" 
    print example3
    putStrLn "\nExample 4:"
    print example4
    putStrLn "\nExample 5:"
    print example5
    putStrLn "\nExample 6:"
    print example6
    putStrLn "\nExample 7:"
    print example7