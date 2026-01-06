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