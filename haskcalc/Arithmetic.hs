module Arithmetic (
  addition,
  subtraction,
  fact,
  pow
) where
  import Utils.Bitwise
  import Utils.Strings
  import Utils.Conversion

  {-|
  Function that adds two binary Strings.
  -}
  addition :: String -> String -> String
  addition a b =
    let
      s1 = stringToBools a
      s2 = stringToBools b
      r = _add s1 s2
    in boolsToString (value r)

  {-|
  Function that substracts a from b.
  RESPECT THE ORDER
  -}
  subtraction :: String -> String -> String
  subtraction a b =
    let
      s1 = stringToBools a
      s2 = twoComplement (stringToBools b)
      r = _add s1 s2
    in boolsToString (value r)

    {-|
    Function that adds two binary Strings and returns a 'Register'.
    -}
  _add :: [Bool] -> [Bool] -> Register
  _add a b =
    let
      n = length a - 1
      r = Register { value = [], carryFlag = False }
    in rippleAdder a b n r

  {-|
  Function returns n to power p
  -}
  pow :: Double -> Integer -> Double
  pow b p
    | p < 0 = 1 / pow b (abs p)
    | p == 0 = 1
    | p == 1 = b
    | otherwise = b * pow b (p - 1)

  fact :: Integer -> Integer
  fact number
    | number < 0 = 0
    | number == 0 = 1
    | otherwise = number * fact (number - 1)
