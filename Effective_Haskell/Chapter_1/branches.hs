module Branches where

printSmallNumber num =
    if num < 10
    then print num
    else print "the number is too big!"

-- if statements always return a value.
-- `then` and `else` clauses must return the same type.
printSmallNumber' num =
    let msg = if num < 10
        then show num -- would fail without show
        else "the number is too big!"
    in print msg

-- if then else can be nested, no special syntax.

-- guard clauses
{-
functionName argument1 argument2 -- as many arguments as you want
    | predicate1 = body1
    | predicate2 = body2
    -- as many predicates as you want
    | otherwise = body3 
-}
guardSize num -- note: no = symbol! Common error
    | num > 0 =
        -- size is local to this branch
        let size = "positive"
        in exclaim size
    | num < 3 = exclaim "small"
    | num < 100 = exclaim "medium"
    | otherwise = exclaim "large"
    where
        -- exclaim is in scope for all branches
        exclaim message = "that's a " <> message <> " number!"
main = printSmallNumber 3