{-
-- EPITECH PROJECT, 2026
-- PGP
-- File description:
-- Parsing
-}

module Parsing where

import Types (CryptoSystem(..), Mode(..), Option(..))
import Help

parseArgs :: [String] -> Maybe CryptoSystem
-- help
parseArgs ["-h"] = Just Help

-- xor
parseArgs ("xor" : args) = case parseMode args False of
    Just mode -> Just $ XOR mode
    Nothing -> Nothing

-- aes
parseArgs ("aes" : args) = case parseMode args False of
    Just mode -> Just $ AES mode
    Nothing -> Nothing

-- rsa
parseArgs ("rsa" : args) = case parseMode args True of
    Just mode -> Just $ RSA mode
    Nothing -> Nothing

-- pgp-xor
parseArgs ("pgp-xor" : args) = case parseMode args False of
    Just mode -> Just $ PGP_XOR mode
    Nothing -> Nothing

-- pgp-aes
parseArgs ("pgp-aes" : args) = case parseMode args False of
    Just mode -> Just $ PGP_AES mode
    Nothing -> Nothing

-- fallback
parseArgs _ = Nothing

parseMode :: [String] -> Bool -> Maybe Mode
parseMode ["-c", "-b", key] _ = Just $ Cipher Block key

parseMode ["-c", key] _ = Just $ Cipher NoOption key

parseMode ["-d", "-b", key] _ = Just $ Decipher Block key

parseMode ["-d", key] _ = Just $ Decipher NoOption key

parseMode ["-g", p, q, key] True = Just $ Generate p q key

parseMode _ _ = Nothing