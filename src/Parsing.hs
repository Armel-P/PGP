{-
-- EPITECH PROJECT, 2026
-- PGP
-- File description:
-- Parsing
-}

module Parsing where

import Data.Word (Word8)

import Types (CryptoSystem(..), Mode(..))
import Conversion (hexToBytes, toBytes)

parseArgs :: [String] -> String -> Maybe CryptoSystem
-- help
parseArgs ["-h"] _ = Just Help

-- xor
parseArgs ("xor" : args) msg = case parseMode args msg False of
    Just mode -> Just $ XOR mode
    Nothing -> Nothing

-- aes
parseArgs ("aes" : args) msg = case parseMode args msg False of
    Just mode -> Just $ AES mode
    Nothing -> Nothing

-- rsa
parseArgs ("rsa" : args) msg = case parseMode args msg True of
    Just mode -> Just $ RSA mode
    Nothing -> Nothing

-- pgp-xor
parseArgs ("pgp-xor" : args) msg = case parseMode args msg False of
    Just mode -> Just $ PGP_XOR mode
    Nothing -> Nothing

-- pgp-aes
parseArgs ("pgp-aes" : args) msg = case parseMode args msg False of
    Just mode -> Just $ PGP_AES mode
    Nothing -> Nothing

-- fallback
parseArgs _ _ = Nothing

parseMode :: [String] -> String -> Bool -> Maybe Mode
parseMode ["-c", "-b", key] msg _ =
    parseModeBytes ["-c", "-b"] (hexToBytes key) (Just $ toBytes msg)

parseMode ["-c", key] msg _ =
    parseModeBytes ["-c"] (hexToBytes key) (Just $ toBytes msg)

parseMode ["-d", "-b", key] msg _ =
    parseModeBytes ["-d", "-b"] (hexToBytes key) (hexToBytes msg)

parseMode ["-d", key] msg _ =
    parseModeBytes ["-d"] (hexToBytes key) (hexToBytes msg)

parseMode ["-g", p, q] _ True =
    parseModeBytes ["-g"] (hexToBytes q) (hexToBytes q)

parseMode _ _ _ = Nothing

parseModeBytes :: [String] -> Maybe [Word8] -> Maybe [Word8] -> Maybe Mode
parseModeBytes ["-c", "-b"] (Just key) (Just msg)
    | length key == length msg = Just $ Cipher key msg
    | otherwise = Nothing

parseModeBytes ["-c"] (Just key) (Just msg) = Just $ Cipher key msg

parseModeBytes ["-d", "-b"] (Just key) (Just msg)
    | length key == length msg = Just $ Decipher key msg
    | otherwise = Nothing

parseModeBytes ["-d"] (Just key) (Just msg) = Just $ Decipher key msg

parseModeBytes ["-g"] (Just key) (Just msg) = Just $ Generate key msg

parseModeBytes _ _ _ = Nothing