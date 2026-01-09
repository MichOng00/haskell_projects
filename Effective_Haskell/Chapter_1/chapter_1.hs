module Chapter1 where

-- putStrLn and putStr are only for strings; for other data types need show
-- print conveniently combines putStrLn and show

-- range syntax for lists - inclusive endpoints, step defined by first two (default +1 if only start given)
integers = [1..10]
evens = [2, 4 .. 10]

-- tuples can contain different types; lists must contain the same, including nested tuples:
tuplesList = [(1, "blue"), (2, "red")]
-- not valid: [(1, "michelle"), ("blue", 2)]
-- not valid: [(1, 2), (3, 4, 5)]
-- However, lists can be variable length:
lists = [[1, 2], [3, 4, 5]]

-- variables are camelCase by convention; can contain underscores, numbers, single quote
helloWorld = "Hello, World"
new = helloWorld

-- Variables can be reused (in interpreter), but will not be changed:
one = 1
two = one + one
-- if we now type `one=5`, the value of `two` is not affected
-- NB: two = two + 1 will "work" but trying to use it later will cause error because of recursion

-- function definitions:
functionName arg1 arg2 =
    -- return value is the value of expression
    arg1 <> arg2

-- anonymous / lambda functions:
-- \arg1 arg2 -> expression

-- partial application:
newFunction = functionName "arg1"
-- then we can use newFunction "arg2"

-- what are operators?
-- 1) infix by default - make prefix with parentheses, eg (<>)
-- 2) have exactly two arguments
-- 3) must be named using symbols (not (), [], or _)
-- NB operators starting with : are reserved for type constructors
(+++) a b = a + b -- exactly equivalent to a +++ b = a + b

{-
Precedence rules (highest to lowest; left associative whenever same precedence):
- parentheses
- function application
- operator application (by default, user-defined oeprations have highest precedence of 9)

When declaring operator, optionally make fixity declaration
1) associativity (default infixl): infixl (left), infixr (right), or infix (not associative)
2) binding precedence (default 9): [0..9] can check for other operators in ghci with eg :info (+) 
3) operator symbol
So, for example:
-}
infixl 6 ***
a *** b = a * b
-- Note that mixing left / right associative operators without parentheses is ambiguous -> error
-- Ditto multiple operators without associativity, eg True == True == False

-- We can also give fixity declaration to defined functions.
-- This only changes behaviour when used infix, but not prefix.
-- Note the backticks.
infixr 0 `divide`
divide = (/)
-- divide 1 2 * 10 gives different result from 1 `divide` 2 * 10
