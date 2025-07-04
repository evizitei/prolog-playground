data Term = STerm String | NTerm Int | VTerm String | FTerm String [Term] | RTerm Term [Term] | TInvalid
    deriving (Eq)

instance Show Term where
    show (STerm s) = s
    show (NTerm n) = show n
    show (VTerm v) = v
    show (FTerm f ts) = f ++ "(" ++ unwords (map show ts) ++ ")"

data Goal = Goal [Term]
data Program = Program [Term]

instance Show Program where
    show (Program ts) = unlines (map show ts)

data Resolution = Yes | No
    deriving (Show)

data Resolvant = Resolvant [Term] | REmpty

lookupTerm :: Term -> Program -> Bool
lookupTerm t (Program []) = False
lookupTerm t (Program (pt:pts)) =
    case t == pt of
        True -> True
        False -> lookupTerm t (Program pts)

sameFunctor :: Term -> Term -> Bool
sameFunctor (FTerm f1 _) (FTerm f2 _) = f1 == f2
sameFunctor _ _ = False

conditionalSub :: Term -> Term -> Maybe (String, Term)
conditionalSub t (VTerm v_name) = Just (v_name, t)
conditionalSub _ _ = Nothing

substitutionFor :: Term -> Term -> [(String, Term)]
substitutionFor (FTerm f1 args1) (FTerm f2 args2) =
    if f1 == f2 
        then [sub | Just sub <- zipWith conditionalSub args1 args2]
        else []
substitutionFor _ _ = []

substitute :: [(String, Term)] -> Term -> Term
substitute sMap (VTerm v_name) = case lookup v_name sMap of
    Just t -> t
    Nothing -> VTerm v_name
substitute _ t = t

rewriteTerm :: Term -> Term -> [Term] -> [Term]
rewriteTerm ground headTerm (bodyTerm:bodyTerms) =
    let sMap = substitutionFor ground headTerm in 
        map (substitute sMap) bodyTerms
    
expandTerm :: Term -> Program -> [Term]
expandTerm t (Program []) = [TInvalid]
expandTerm t (Program (pt:pts)) =
    case pt of
        (RTerm headTerm bodyTerms) ->
            case (sameFunctor headTerm t) of
                True -> rewriteTerm t headTerm bodyTerms
                False -> expandTerm t (Program pts)
        _ -> expandTerm t (Program pts)


walkResolvant :: Program -> Resolvant -> Resolution
walkResolvant pgm (Resolvant []) = Yes
walkResolvant pgm (REmpty) = Yes
walkResolvant pgm (Resolvant (TInvalid:ts)) = No
walkResolvant pgm (Resolvant (t:ts)) = 
    case lookupTerm t pgm of
        True -> walkResolvant pgm (Resolvant ts)
        False -> walkResolvant pgm (Resolvant ((expandTerm t pgm) ++ ts))
    
resolve :: Program -> Goal -> Resolution
resolve pgm (Goal goalTerms) = 
    walkResolvant pgm (Resolvant goalTerms)

main :: IO ()
main = do
    let pgm = (Program [
            FTerm "male" [(STerm "lot")],
            FTerm "father" [(STerm "haran"), (STerm "lot")],
            (RTerm (FTerm "son" [(VTerm "A"), (VTerm "B")]) [
                FTerm "father" [(VTerm "B"), (VTerm "A")],
                FTerm "male" [(VTerm "A")]])
            ])
    let goal = (Goal [(FTerm "son" [(STerm "lot"), (STerm "haran")])])
    let r1 = resolve pgm goal
    putStrLn $ show r1


    
    