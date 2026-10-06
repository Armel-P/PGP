{-
-- EPITECH PROJECT, 2026
-- PGP
-- File description:
-- Parsing
-}

module Parsing where

import Types (CryptoSystem(..), Mode(..), )

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
parseMode ["-c", "-b", key] msg _ 
    | length key == 2 * length msg = Just $ Cipher key msg
    | otherwise = Nothing

parseMode ["-c", key] msg _ = Just $ Cipher key msg

parseMode ["-d", "-b", key] msg _
    | length key == length msg = Just $ Decipher key msg
    | otherwise = Nothing

parseMode ["-d", key] msg _ = Just $ Decipher key msg

parseMode ["-g", p, q] _ True = Just $ Generate p q

parseMode _ _ _ = Nothing