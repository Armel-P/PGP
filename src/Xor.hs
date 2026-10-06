{-
-- EPITECH PROJECT, 2026
-- PGP
-- File description:
-- Xor
-}

module Xor (xorMode) where

import Control.Applicative (liftA2)
import Control.Monad (mfilter)
import Data.Bits (xor)
import Data.Char (chr, digitToInt, intToDigit, isHexDigit, ord)
import Data.Word (Word8)
import System.IO (hPutStrLn, stderr)

import Utils (failure)
import Types (Mode(..))

-- Hex <-> bytes

hexDigit :: Char -> Maybe Word8
hexDigit c
    | isHexDigit c = Just (fromIntegral (digitToInt c))
    | otherwise    = Nothing

hexToBytes :: String -> Maybe [Word8]
hexToBytes []         = Just []
hexToBytes (h:l:rest) = (\hi lo bs -> (hi * 16 + lo) : bs)
                        <$> hexDigit h <*> hexDigit l <*> hexToBytes rest
hexToBytes _          = Nothing

parseKey :: String -> Maybe [Word8]
parseKey = mfilter (not . null) . hexToBytes

bytesToHex :: [Word8] -> String
bytesToHex = concatMap (digits . (`divMod` 16) . fromIntegral)
  where digits (hi, lo) = [intToDigit hi, intToDigit lo]

toBytes :: String -> [Word8]
toBytes = map (fromIntegral . ord)

fromBytes :: [Word8] -> String
fromBytes = map (chr . fromIntegral)

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

xorCipher :: String -> String -> Maybe String
xorCipher keyHex msg =
    (\key -> bytesToHex (xorWith cipherBlock key (toBytes msg))) <$> parseKey keyHex

xorDecipher :: String -> String -> Maybe String
xorDecipher keyHex msg =
    liftA2 (\key bytes -> fromBytes (xorWith decipherBlock key bytes))
           (parseKey keyHex) (hexToBytes msg)

output :: Maybe String -> IO()
output = maybe failure putStrLn

xorMode :: Mode -> IO()
xorMode (Cipher key msg)   = output (xorCipher key msg)
xorMode (Decipher key msg) = output (xorDecipher key msg)
xorMode _                  = failure
