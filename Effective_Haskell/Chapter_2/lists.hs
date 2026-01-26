module Lists where

-- strings are lists of characters
-- ['h', 'e'] <> "llo"

-- indexing using !!
fruits = ["apple", "banana", "mango"]
-- fruits !! 1

-- "cons" operator, :, prepends elt to beginning (default in Haskell!)
-- right associative, eg 1:2:[3] produces [1,2,3]
-- NB prepending is much more efficient than appending for immutable lang

-- head gets first elt; tail gets all but first.
-- using them on empty list [] will cause errors
listIsEmpty list =
    if null list --alt: if list == []
    then putStrLn "this list is empty"
    else putStrLn ("the first elt is " <> show (head list))

-- eg count down
countdown n =
    if n <= 0 then []
    else n : countdown (n-1)

-- eg construct list of prime factors
factors num =
    factors' num 2 -- need initial value, not user-provided
    where
        factors' num fact
            | num == 1 = [] 
            -- if factor, recursively call on (number / found_factors)
            | (num `rem` fact) == 0 = fact : factors' (num `div` fact) fact
            --only increase candidate factor once it no longer divides the (number / found_factors)
            | otherwise = factors' num (fact + 1) 

-- eg DEconstruct lists - check if balanced parentheses
isBalanced s =
    0 == isBalanced' 0 s -- start with count at 0
    where
        isBalanced' count s
            | null s = count -- returns count when nothing left in string. this is 0 iff balanced.
            | head s == '(' = isBalanced' (count + 1) (tail s)
            | head s == ')' = isBalanced' (count - 1) (tail s)
            | otherwise = isBalanced' count (tail s)

-- a generic version of above traverse and accumulate:
-- this is actually foldl
reduce func carryValue lst =
    if null lst then carryValue
    else
        let intermediateValue = func carryValue (head lst)
        in reduce func intermediateValue (tail lst)

isBalanced' s =
    0 == reduce checkBalance 0 s
    where
        checkBalance count letter
            | letter == '(' = count + 1
            | letter == ')' = count - 1
            | otherwise = count

foldl' func carryValue lst =
    if null lst
    then carryValue
    else foldl' func (func carryValue (head lst)) (tail lst)
foldr' func carryValue lst =
    if null lst
    then carryValue
    else func (head lst) $ foldr' func carryValue (tail lst)
-- associativity of the func used in folds doesn't impact final result!

-- transforming list elements
-- map applies a function to every elt in list
-- let incr x = x + 1 in map incr [1..3]
-- map (+2) [1..3]
-- or appies a value to a list of functions
-- map ($ 10) [(+ 1), (* 3), (`div` 5)]
-- a manual implementation:
map' f xs =
    -- we could also use foldr for below
    if null xs then []
    else f (head xs) : map' f (tail xs)

-- filtering lists - getting subsets
-- use a function that returns True for values to keep, False otherwise
-- filter odd [0..10]

-- list comprehensions - combine map and filter
-- lst = [expression | condition1, condition2]
double = [2 * number | number <- [0..10]] -- read <- as "in", from math view
doubleOdds = [2 * number | number <- [0..10], odd number]
-- an example: calculating budget given guest list, foods they will eat, and fn returning cost per food
partyBudget isAttending willEat foodCost guests =
    foldl (+) 0 $
    [
        foodCost food
        | guest <- map fst guests -- NB guest not in final list
        , food  <- map snd guests
        , willEat guest food
        , isAttending guest
    ]

-- combining lists - zip
-- this gives all permutations:
-- [(num,str) | num <- [1,2,3], str <- ["I","II","III"]]
-- zip (like Python) - will truncate any extras
pairwiseSum xs ys = map (uncurry (+)) $ zip xs ys

-----------------------------------------------------------

-- pattern matching
-- match on special cases, otherwise fall back on general case:
matchTuple ("hello", "world") = "Hello there, you great big world"
matchTuple ("hello", name) = "Oh, hi there, " <> name
matchTuple (salutation, "George") = "Oh! " <> salutation <> " George!"
matchTuple n = show n
-- incomplete pattern matches lead to exceptions:
partialFunc 0 = "I only work for zero!"
-- partialFunc 1
-- so, we should use explicit errors for general case (eg incomplete code):
partialFunc impossibleValue = error $ 
    "I only take 0 but was called with " <> show impossibleValue
-- don't need general case if special cases are exhaustive:
matchBool True = "True story!"
matchBool False = "This is just not true."

-- destructuring lists with pattern matching
addValues [] = 0
addValues (first:rest) = first + (addValues rest)
-- use @ to pattern match but also get original value:
modifyPair p@(a,b)
    | a == "Hello" = "this is a salutation"
    | b == "George" = "this is for George"
    | otherwise = "I don't know what " <> show p <> " means"
-- wildcard pattern - use underscore
-- to communciate to other devs what the value will be, but also discard: use _varname
printHead [] = "empty"
printHead lst@(hd:_tail) =
    "the head of " <> (show lst) <> " is " <> show hd

-- case: pattern matching within functions
-- simple case: like switch
favoriteFood person =
    case person of
        "Nicole" -> "mango mochi"
        "Yi Wei" -> "soup"
        "Nicholas" -> "prata"
        name -> "I don't know what " <> name <> " likes"
-- combined with guards:
handleNums l =
    case l of
        [] -> "an empty list"
        [x] | x == 1 -> "a singleton of [1]"
            | even x -> "a singleton containing an even number"
            | otherwise -> "the list contains " <> (show x)
        _list -> "the list has more than 1 element"

-- warn about incomplete patterns:
-- when compiling, flag -Wincomplete-patterns
-- in ghci, :set -Wincomplete-patterns before loading
-- turn off warnings in ghci with :set -Wno-incomplete-patterns

-------------------------------------------

-- an as-yet unevaluated expression is a "thunk"
-- since Haskell is lazy, we can create potentially infinite "stream" / "generator"
radsToDegrees :: Float -> Int
radsToDegrees radians =
    let degrees = cycle [0..359]
        converted = truncate $ (radians * 360) / (2 * pi)
    in degrees !! converted
-- cycle uses this concept:
cycle' inputList =
    cycleHelper inputList
    where
        cycleHelper [] = cycle' inputList
        cycleHelper (x:xs) = x : cycleHelper xs
-- more concise:
cycle'' inputList = inputList <> cycle'' inputList

-- Folds and Infinite Lists
-- Sometimes, you can get a value back when folding on infinite lists!
findFirst predicate = 
    foldr findHelper [] -- ONLY foldr works for infinite lists!!
    where
        findHelper listElement maybeFound
            | predicate listElement = [listElement]
            | otherwise = maybeFound
-- findFirst (> 20) [1..]

-- lazy streams for efficient Fibonacci generation
fibs = 0 : 1 : helper fibs (tail fibs)
    where
        helper (a:as) (b:bs) = 
            a + b : helper as bs
