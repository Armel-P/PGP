{-
-- EPITECH PROJECT, 2026
-- PGP
-- File description:
-- Conversion
-}

module Conversion where

import Data.Char (chr, digitToInt, intToDigit, isHexDigit, ord, toLower)
import Data.Bits (shiftL, shiftR, (.&.))
import Data.Word (Word8)

import Numeric (showHex)

toBytes :: String -> [Word8]
toBytes = map (fromIntegral . ord)

hexDigit :: Char -> Maybe Word8
hexDigit c
    | isHexDigit c = Just (fromIntegral (digitToInt c))
    | otherwise    = Nothing

hexToBytes :: String -> Maybe [Word8]
hexToBytes []         = Just []
hexToBytes (h:l:rest) = (\hi lo bs -> (hi * 16 + lo) : bs)
                        <$> hexDigit h <*> hexDigit l <*> hexToBytes rest
hexToBytes _          = Nothing

fromBytes :: [Word8] -> String
fromBytes = map (chr . fromIntegral)

bytesToHex :: [Word8] -> String
bytesToHex = concatMap (digits . (`divMod` 16) . fromIntegral)
  where digits (hi, lo) = [intToDigit hi, intToDigit lo]

chunksOf :: Int -> [a] -> [[a]]
chunksOf _ [] = []
chunksOf n xs = let (h, t) = splitAt n xs in h : chunksOf n t

hexToInteger :: String -> Maybe Integer
hexToInteger [] = Nothing
hexToInteger hex
    | odd (length hex) = Nothing
    | otherwise = Just $
        foldl' (\acc (i, byte) ->
            acc + toInteger byte * (256 ^ i)
        ) 0 (zip [0 :: Int ..] (parseBytes hex))
  where
    parseBytes [] = []
    parseBytes (a:b:rest) =
        digitToInt a * 16 + digitToInt b : parseBytes rest
    parseBytes _ = []

bytesToInteger :: [Word8] -> Integer
bytesToInteger = foldr (\b acc -> toInteger b + 256 * acc) 0

integerToHex :: Integer -> String
integerToHex 0 = "00"
integerToHex n = concatMap toHexByte (toBytesLE n)
  where
    toBytesLE 0 = []
    toBytesLE x = x `mod` 256 : toBytesLE (x `div` 256)

    toHexByte byte =
        let hex = showHex byte ""
        in if length hex == 1 then '0' : hex else hex

integerToBytes :: Integer -> [Word8]
integerToBytes 0 = []
integerToBytes n =
    fromIntegral (n `mod` 256) : integerToBytes (n `div` 256)

reverseChunksOf4 :: [Word8] -> [Word8]
reverseChunksOf4 = concatMap reverse . chunksOf 4
