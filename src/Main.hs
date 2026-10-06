{-
-- EPITECH PROJECT, 2026
-- PGP
-- File description:
-- Main
-}

import System.Exit
import System.Environment

import Utils (failure)
import Types (CryptoSystem(..))
import Parsing (parseArgs)
import Doc.Help (help)
import Xor (xorMode)

main :: IO()
main = do
    args <- getArgs
    message <- getContents
    case parseArgs args message of
        Nothing -> failure

        Just Help -> help

        Just (XOR mode) -> xorMode mode

        Just (AES mode) -> exitSuccess -- TODO: implement AES

        Just (RSA mode) -> exitSuccess -- TODO: implement RSA

        Just (PGP_XOR mode) -> exitSuccess -- TODO: implement PGP_XOR

        Just (PGP_AES mode) -> exitSuccess -- TODO: implement PGP_AES
