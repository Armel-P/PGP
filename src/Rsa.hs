{-
-- EPITECH PROJECT, 2026
-- PGP
-- File description:
-- Rsa
-}


module Rsa (rsaMode) where

import Data.Word (Word8)

import Utils (failure)
import Types (Mode(..))
import Conversion (fromBytes, hexToInteger, integerToHex, bytesToInteger, integerToBytes)

-- Encrypt / Decrypt

powMod :: Integer -> Maybe (Integer, Integer) -> Maybe Integer
powMod base (Just (expn, modulus))
    | modulus <= 0 = Nothing
    | expn < 0     = Nothing
    | otherwise    = Just $ go (base `mod` modulus) expn 1
  where
    go _ 0 acc = acc
    go b e acc
        | odd e     = go ((b * b) `mod` modulus)
                         (e `div` 2)
                         ((acc * b) `mod` modulus)
        | otherwise = go ((b * b) `mod` modulus)
                         (e `div` 2)
                         acc
powMod _ Nothing = Nothing

parseKey :: (String, String) -> Maybe (Integer, Integer)
parseKey (expHex, '-' : modulusHex) = case (hexToInteger expHex, hexToInteger modulusHex) of
    (Just expn, Just modulus)
        | modulus > 0 -> Just (expn, modulus)
    _ -> Nothing
parseKey _ = Nothing

retrieveKey :: [Word8] -> (String, String)
retrieveKey = break (== '-') . fromBytes

rsaEncrypt :: [Word8] -> [Word8] -> Maybe Integer
rsaEncrypt key msg = powMod (bytesToInteger msg) (parseKey (retrieveKey key))

rsaDecrypt :: [Word8] -> [Word8] -> Maybe Integer
rsaDecrypt key msg = powMod (bytesToInteger msg) (parseKey (retrieveKey key))

-- Generate part

fermatPrimes :: [Integer]
fermatPrimes = [3, 5, 17, 257, 65537]

rsaNMod :: Integer -> Integer -> Integer
rsaNMod prime1 prime2 = prime1 * prime2

rsaPgcd :: Integer -> Integer -> Integer
rsaPgcd = gcd

rsaPpcm :: Integer -> Integer -> Integer
rsaPpcm a b = (a * b) `div` gcd a b

rsaVerifyLambdaN :: Integer -> Maybe Integer
rsaVerifyLambdaN lambdaN
    | lambdaN == 2 || lambdaN == 3 = Nothing
    | otherwise = Just lambdaN

rsaLambdaN :: Integer -> Integer -> Maybe Integer
rsaLambdaN prime1 prime2
    | prime1 <= 1 || prime2 <= 1 = Nothing
    | otherwise =
        rsaVerifyLambdaN (rsaPpcm (prime1 - 1) (prime2 - 1))

rsaBiggestFermatPrime :: Integer -> Maybe Integer
rsaBiggestFermatPrime lambdaN =
    findPrime (reverse fermatPrimes)
  where
    findPrime [] = Nothing
    findPrime (e:rest)
        | e < lambdaN && gcd e lambdaN == 1 = Just e
        | otherwise = findPrime rest

rsaExtentedEuclideanAlgorithm :: Integer -> Integer -> (Integer, Integer, Integer)
rsaExtentedEuclideanAlgorithm a 0 = (a, 1, 0)
rsaExtentedEuclideanAlgorithm a b =
    let (g, x, y) = rsaExtentedEuclideanAlgorithm b (a `mod` b)
    in (g, y, x - (a `div` b) * y)

rsaDExp :: Integer -> Integer -> Maybe Integer
rsaDExp e lambdaN =
    let (g, x, _) = rsaExtentedEuclideanAlgorithm e lambdaN
    in if g == 1
        then Just (x `mod` lambdaN)
        else Nothing

rsaKeysToText :: Integer -> Integer -> Integer -> String
rsaKeysToText e d n =
    "public key: " ++ integerToHex e
    ++ "-" ++ integerToHex n
    ++ "\nprivate key: " ++ integerToHex d
    ++ "-" ++ integerToHex n

rsaGenerate :: Integer -> Integer -> Maybe String
rsaGenerate prime1 prime2 =
    case rsaLambdaN prime1 prime2 of
        Nothing -> Nothing
        Just lambdaN ->
            case rsaBiggestFermatPrime lambdaN of
                Nothing -> Nothing
                Just e ->
                    case rsaDExp e lambdaN of
                        Nothing -> Nothing
                        Just d ->
                            Just (rsaKeysToText e d (rsaNMod prime1 prime2))

-- Entry point

rsaMode :: Mode -> IO ()
rsaMode (Cipher pbKey msg)       = case rsaEncrypt pbKey msg of
        Just encrypted -> putStrLn (integerToHex encrypted)
        Nothing        -> failure
rsaMode (Decipher pvKey msg)     = case rsaDecrypt pvKey msg of
        Just decrypted -> putStrLn (fromBytes (integerToBytes decrypted))
        Nothing        -> failure
rsaMode (Generate prime1 prime2) = case rsaGenerate prime1 prime2 of
    Just key_text -> putStrLn key_text
    Nothing       -> failure
