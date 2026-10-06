{-
-- EPITECH PROJECT, 2026
-- PGP
-- File description:
-- Conversion
-}

module Conversion(toBytes, hexToBytes, fromBytes, bytesToHex) where

import Data.Char (chr, digitToInt, intToDigit, isHexDigit, ord)
import Data.Word (Word8)

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
