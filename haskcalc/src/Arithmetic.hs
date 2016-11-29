module Arithmetic (
  addThem,
  subtractThem,
  multiplyThem,
  fact,
  pow
) where
  import Utils.Bitwise
  import Utils.Strings
  import Utils.Conversion


  addThem :: Int -> Int -> Int
  addThem a b = let
      n1 = signedIntToBin a
      n2 = signedIntToBin b
      r = _add n1 n2
    in binToSignedInt (value r)


  {-|
  Subtract the first argument from the second, thus yielding the next formula:
  a - b
  So, if b is negative, it becomes a + b.
  -}
  subtractThem :: Int -> Int -> Int
  subtractThem a b = let
    new_a = signedIntToBin a
    new_b = twoComplement (signedIntToBin b)
    r = _add new_a new_b
    in binToSignedInt (value r)

{-|
  divideThem :: Int -> Int -> Int
  divideThem a b =
    let
      dividend = signedIntToBin a
      divisor = signedIntToBin (abs b)
      reg = Register { value = completeBits [], carryFlag = False }
      result = _succesiveSubtraction dividend divisor 0
    in if b <= 0
      then binToSignedInt (twoComplement (value result))
      else binToSignedInt (value result)
-}

{-|
  TODO: Finish the shittie division

  _succesiveSubtraction :: [Bool] -> [Bool] -> Int -> Register -> Register
  _succesiveSubtraction =
    let
      name = expression
      in expression
-}

  multiplyThem :: Int -> Int -> Int
  multiplyThem a b = let
    bools = signedIntToBin a
    reg = Register { value=completeBits [], carryFlag = False }
    iter = abs b
    in let
      result = _succesiveAddition bools iter reg
     in if b <= 0
       then binToSignedInt (twoComplement (value result))
       else binToSignedInt(value result)


  _succesiveAddition :: [Bool] -> Int -> Register -> Register
  _succesiveAddition a n r
    | n == 0 = r
    | otherwise = let
      add_res = _add a (value r)
      in _succesiveAddition a (n-1) add_res

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
  pow :: Double -> Int -> Double
  pow b p
    | p < 0 = 1 / pow b (abs p)
    | p == 0 = 1
    | p == 1 = b
    | otherwise = b * pow b (p - 1)

  fact :: Int -> Int
  fact number
    | number < 0 = 0
    | number == 0 = 1
    | otherwise = number * fact (number - 1)
