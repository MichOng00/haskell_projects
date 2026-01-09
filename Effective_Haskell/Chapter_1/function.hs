module Function where

makeGreeting salutation person =
    salutation <> " " <> person

-- partial application
greetPerson = makeGreeting "Hello"

-- eta reduction (idiomatic)
enthusiasticGreeting salutation = 
    makeGreeting (salutation <> "!")
-- as opposed to eta expansion (passing along the extra param)
-- enthusiasticGreeting salutation name =
--     makeGreeting (salutation <> "!") name

-- we can also partially apply infix functions, eg operators:
half = (/2)
twoOver = (2/)

-- Two ways to apply only second argument:
-- 1) making functions infix:
greetGeorge = (`makeGreeting` "George")
-- 2) use flip to swap argument order:
greetAnotherGeorge = flip makeGreeting "George"

-- Functions associate left to right.
sayThree a b c = a <> " " <> b <> " " <> c
-- flip sayThree "a" "b" "c" gives "b a c"
-- flip (sayThree "a") "b" "c" gives "a c b"

-- Function composition!
addOne num = num + 1
timesTwo num = num * 2
squared num = num * num
findResult num = squared (timesTwo (addOne num))
-- to avoid parentheses, we can use
findResult' num = squared $ timesTwo $ addOne num
findResult'' = squared . timesTwo . addOne
-- note that to use . without named function, need parentheses or $:
-- (timesTwo . timesTwo . timesTwo) 3
-- timesTwo . timesTwo . timesTwo $ 3

-- Pointfree, aka tacit programming - no named parameters
makeGreeting' = (<>) . (<> " ")

------------------------------------------
-- local variables with let binding
extendedGreeting person =
    -- can define multiple variables - here 4
    let hello = makeGreeting helloStr person -- note helloStr referenced before definition
        goodDay = makeGreeting "I hope you have a nice afternoon" person
        goodBye = makeGreeting "See you later" person
        helloStr = "Hello"
    in hello <> "\n" <> goodDay <> "\n" <> goodBye

extendedGreeting' person =
    -- can define functions, nest let bindings
    let joinWithNewlines a b = a <> "\n" <> b
        helloAndGoodbye hello goodbye =
            let hello' = makeGreeting hello person
                goodbye' = makeGreeting goodbye person
            in joinWithNewlines hello' goodbye'
    in helloAndGoodbye "Hello" "Goodbye"

-- where bindings - like let, but:
-- variables defined in let are not available in where,
-- variables defined in where are available in let.
-- Let vs. Where is matter of personal style and readability.
letWhereGreeting name place =
    let
        salutation = "Hello " <> name
        meetingInfo = location "Tuesday" 
    in salutation <> " " <> meetingInfo
    where
        location day = "we met at " <> place <> " on a " <> day

extendedGreeting'' person = 
    helloAndGoodbye "Hello" "Goodbye"
    where
        helloAndGoodbye hello goodbye =
            joinWithNewlines hello' goodbye'
            where
                hello' = makeGreeting hello person
                goodbye' = makeGreeting goodbye person
        joinWithNewlines a b = a <> "\n" <> b


main = print "no salutation yet"