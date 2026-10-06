{-
-- EPITECH PROJECT, 2026
-- PGP
-- File description:
-- types
-}

module Types where

import Data.Word (Word8)

data CryptoSystem
    = Help
    | XOR Mode
    | AES Mode
    | RSA Mode
    | PGP_XOR Mode
    | PGP_AES Mode

data Mode
    = Cipher [Word8] [Word8]
    | Decipher [Word8] [Word8]
    | Generate [Word8] [Word8]
