module Exercises where

factorial num =
    if num == 1
    then 1
    else
        let nextNum = num - 1
        in factorial nextNum * num

fibonacci num
  | num == 0 = 0
  | num == 1 = 1
  | otherwise = fibonacci (num - 1) + fibonacci (num - 2)

-- curry: fn taking tuple -> fn taking 2 args
curry' function a b = function (a, b)
uncurry' function (a, b) = function a b

-- test
uncurriedAdd nums =
    let
        a = fst nums
        b = snd nums
    in a + b