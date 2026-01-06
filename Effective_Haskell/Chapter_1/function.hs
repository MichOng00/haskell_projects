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


main = print "no salutation yet"