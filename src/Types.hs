{-
-- EPITECH PROJECT, 2026
-- PGP
-- File description:
-- types
-}

module Types where

data CryptoSystem
    = Help
    | XOR Mode
    | AES Mode
    | RSA Mode
    | PGP_XOR Mode
    | PGP_AES Mode

data Mode
    = Cipher String String
    | Decipher String String
    | Generate String String
