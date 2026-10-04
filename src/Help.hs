{-
-- EPITECH PROJECT, 2026
-- PGP
-- File description:
-- Help
-}

module Help where

import System.Exit
import Data.List (intercalate)


helpTextDescrpitionArgs :: [String]
helpTextDescrpitionArgs = [
    "        key                  Key used to cipher/decipher MESSAGE \
    \(incompatible with -g MODE)"]

helpTextDescrpitionOptions :: [String]
helpTextDescrpitionOptions = ["    OPTIONS"
    , "        -b                  for XOR, AES and PGP, only works on one block.\
    \ The MESSAGE and the symmetric key must be the same size"
    , ""]

helpTextDescrpitionMode :: [String]
helpTextDescrpitionMode = ["    MODE"
    , "        -c                  MESSAGE is clear and we want to cipher it"
    , "        -d                  MESSAGE is ciphered and we want to decipher it"
    , "        -g P Q              RSA only: don't read a MESSAGE, but instead \
    \generate a public and private key pair from the prime number P and Q"
    , ""]

helpTextDescrpitionCryptoSystem :: [String]
helpTextDescrpitionCryptoSystem = ["    CRYPTO_SYSTEM"
    , "        \"xor\"            computation using XOR algorithm"
    , "        \"aes\"            computation using AES algorithm"
    , "        \"rsa\"            computation using RSA algorithm"
    , "        \"pgp-xor\"        computation using both RSA and XOR algorithm"
    , "        \"pgp-aes\"        computation using both RSA and AES algorithm"
    , ""]

helpTextDescrpitionHeader :: [String]
helpTextDescrpitionHeader = ["DESCRIPTION"
    , "Cipher or decipher MESSAGE using a given CRYPTO_SYSTEM. The MESSAGE is read from the standard input."
    , ""]

helpTextDescription :: [String]
helpTextDescription = concat
        [ helpTextDescrpitionHeader
        , helpTextDescrpitionCryptoSystem
        , helpTextDescrpitionMode
        , helpTextDescrpitionOptions
        , helpTextDescrpitionArgs
        ]

helpTextUsage :: [String]
helpTextUsage = ["USAGE"
    , "    ./my_pgp CRYPTO_SYSTEM MODE [OPTIONS] [key]"
    , ""]

helpText :: String
helpText = intercalate "\n" (helpTextUsage ++ helpTextDescription)

help :: IO()
help = putStrLn helpText >> exitSuccess
