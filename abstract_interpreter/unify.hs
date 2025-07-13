module Unify where

import qualified Data.Map as Map
import Data.Maybe (fromMaybe)

-- Term data type
data Term = Atom String
          | Var String
          | Predicate String Int [Term]  -- name, arity, terms
          deriving (Eq, Show)

-- Substitution is a mapping from variable names to terms
type Substitution = Map.Map String Term

-- Unification constraint: two terms that should be unified
type Constraint = (Term, Term)

-- Unification state: stack of constraints and current substitution
type UnifyState = ([Constraint], Substitution)

-- Result of unification
data UnifyResult = Success Substitution
                 | Failure String
                 deriving (Eq, Show)

-- Apply a substitution to a term
applySubst :: Substitution -> Term -> Term
applySubst subst (Var v) = fromMaybe (Var v) (Map.lookup v subst)
applySubst subst (Predicate name arity terms) = 
    Predicate name arity (map (applySubst subst) terms)
applySubst _ atom = atom

-- Check if a variable occurs in a term (occurs check)
occurs :: String -> Term -> Bool
occurs v (Var v') = v == v'
occurs v (Predicate _ _ terms) = any (occurs v) terms
occurs _ (Atom _) = False

-- Main unification algorithm
unify :: Term -> Term -> UnifyResult
unify t1 t2 = unifyWithState ([(t1, t2)], Map.empty)

-- Unification with explicit state
unifyWithState :: UnifyState -> UnifyResult
unifyWithState ([], subst) = Success subst
unifyWithState ((t1, t2):rest, subst) = 
    let t1' = applySubst subst t1
        t2' = applySubst subst t2
    in case (t1', t2') of
        -- Same terms unify trivially
        _ | t1' == t2' -> unifyWithState (rest, subst)
        
        -- Variable cases
        (Var v, t) -> unifyVar v t rest subst
        (t, Var v) -> unifyVar v t rest subst
        
        -- Atom cases
        (Atom a1, Atom a2) 
            | a1 == a2 -> unifyWithState (rest, subst)
            | otherwise -> Failure $ "Cannot unify atoms: " ++ a1 ++ " and " ++ a2
        
        -- Predicate cases
        (Predicate n1 a1 ts1, Predicate n2 a2 ts2)
            | n1 == n2 && a1 == a2 -> 
                unifyWithState (zip ts1 ts2 ++ rest, subst)
            | n1 /= n2 -> Failure $ "Cannot unify predicates with different names: " ++ n1 ++ " and " ++ n2
            | otherwise -> Failure $ "Cannot unify predicates with different arities: " ++ show a1 ++ " and " ++ show a2
        
        -- Mismatched types
        _ -> Failure $ "Cannot unify terms of different types: " ++ show t1' ++ " and " ++ show t2'

-- Unify a variable with a term
unifyVar :: String -> Term -> [Constraint] -> Substitution -> UnifyResult
unifyVar v t rest subst
    | Var v == t = unifyWithState (rest, subst)  -- Variable unifies with itself
    | occurs v t = Failure $ "Occurs check failed: " ++ v ++ " occurs in " ++ show t
    | otherwise = unifyWithState (rest, Map.insert v t subst)

-- Helper function to extract the most general unifier
mgu :: Term -> Term -> Maybe Substitution
mgu t1 t2 = case unify t1 t2 of
    Success subst -> Just subst
    Failure _ -> Nothing