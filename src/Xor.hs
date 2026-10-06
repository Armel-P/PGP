{-
-- EPITECH PROJECT, 2026
-- PGP
-- File description:
-- Xor
-}

module Xor (xorMode) where

import Control.Monad (mfilter)
import Data.Bits (xor)
import Data.Char (digitToInt, intToDigit, isHexDigit, ord)
import Data.Word (Word8)
import System.IO (hPutStrLn, stderr)

import Utils (failure)
import Conversion(bytesToHex, fromBytes)
import Types (Mode(..))

-- Blocks

chunksOf :: Int -> [a] -> [[a]]
chunksOf _ [] = []
chunksOf n xs = h : chunksOf n t
  where (h, t) = splitAt n xs

padChunks :: Int -> [Word8] -> [[Word8]]
padChunks n = map (\blk -> take n (blk ++ repeat 0)) . chunksOf n

cipherBlock :: [Word8] -> [Word8] -> [Word8]
cipherBlock key = zipWith xor key . reverse

decipherBlock :: [Word8] -> [Word8] -> [Word8]
decipherBlock key = reverse . zipWith xor key

xorWith :: ([Word8] -> [Word8] -> [Word8]) -> [Word8] -> [Word8] -> [Word8]
xorWith block key = concatMap (block key) . padChunks (length key)

-- Cipher / decipher (pure)

xorCipher :: [Word8] -> [Word8] -> String
xorCipher key msg = bytesToHex (xorWith cipherBlock key msg)

xorDecipher :: [Word8] -> [Word8] -> String
xorDecipher key msg = fromBytes (xorWith decipherBlock key msg)

-- Entry point

xorMode :: Mode -> IO()
xorMode (Cipher key msg)   = putStr $ xorCipher key msg
xorMode (Decipher key msg) = putStr $ xorDecipher key msg
xorMode _                  = failure
