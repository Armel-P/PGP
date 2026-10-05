{-
-- EPITECH PROJECT, 2026
-- PGP
-- File description:
-- Parsing
-}

module Parsing where

import Types (CryptoSystem(..), Mode(..), Option(..))

parseArgs :: [String] -> String -> Maybe CryptoSystem
-- help
parseArgs ["-h"] _ = Just Help

-- xor
parseArgs ("xor" : args) message = case parseMode args message False of
    Just mode -> Just $ XOR mode
    Nothing -> Nothing

-- aes
parseArgs ("aes" : args) message = case parseMode args message False of
    Just mode -> Just $ AES mode
    Nothing -> Nothing

-- rsa
parseArgs ("rsa" : args) message = case parseMode args message True of
    Just mode -> Just $ RSA mode
    Nothing -> Nothing

-- pgp-xor
parseArgs ("pgp-xor" : args) message = case parseMode args message False of
    Just mode -> Just $ PGP_XOR mode
    Nothing -> Nothing

-- pgp-aes
parseArgs ("pgp-aes" : args) message = case parseMode args message False of
    Just mode -> Just $ PGP_AES mode
    Nothing -> Nothing

-- fallback
parseArgs _ _ = Nothing

parseMode :: [String] -> String -> Bool -> Maybe Mode
parseMode ["-c", "-b", key] message _ = Just $ Cipher Block key message

parseMode ["-c", key] message _ = Just $ Cipher NoOption key message

parseMode ["-d", "-b", key] message _ = Just $ Decipher Block key message

parseMode ["-d", key] message _ = Just $ Decipher NoOption key message

parseMode ["-g", p, q, key] _ True = Just $ Generate p q key

parseMode _ _ _ = Nothing