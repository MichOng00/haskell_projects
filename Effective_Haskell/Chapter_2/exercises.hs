module Exercises where

reverseLeft xs =
    foldl helper [] xs
    where
        helper prevList x =
            x : prevList

reverseRight xs =
    foldr helper [] xs
    where
        helper x xs' =
            xs' ++ [x]

-- more concise:
-- reverseLeft' = foldl (flip (:)) []
-- reverseRight' xs = foldr (\ x acc -> acc ++ [x]) [] xs
-- foldl is more efficient, as it naturally returns head first

--------------------------------------------

zipWith'' func listOne listTwo
    | listOne == [] = []
    | listTwo == [] = []
    | otherwise = func (head listOne) (head listTwo) : zipWith'' func (tail listOne) (tail listTwo)
-- to avoid partial functions:
examplePatternGuard f as bs
  | (a:as') <- as, (b:bs') <- bs = f a b : examplePatternGuard f as' bs'
  | otherwise = []

zipWithFold f as bs =
    reverse $ fst results
    where
        results = foldl applyFunction ([], as) bs
        applyFunction (zipped, []) _ = (zipped, [])
        applyFunction (zipped, x:xs) val = (f x val : zipped, xs)

zipWithListComprehension f as bs =
    -- [ f a b | a <- as, b <- bs] --will give all combinations
    [f (as !! idx) (bs !! idx) | idx <- [0 .. len - 1]]
  where
    len = min (length as) (length bs)

--------------------------------------------

-- left version will not work with infinite lists
concatMapLeft f = foldl (\acc x -> acc <> f x) []
concatMapRight f = foldr (\x acc -> f x <> acc) []