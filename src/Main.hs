{-
-- EPITECH PROJECT, 2026
-- PGP
-- File description:
-- Main
-}

import System.Exit
import System.Environment

import Types (CryptoSystem(..))
import Parsing (parseArgs)
import Doc.Help (help)
import Xor (xor)

main :: IO()
main = do
    args <- getArgs
    message <- getContents
    case parseArgs args message of
        Nothing -> exitWith (ExitFailure 84)

        Just Help -> help

        Just (XOR mode) -> exitSuccess -- TODO: implement XOR

        Just (AES mode) -> exitSuccess -- TODO: implement AES

        Just (RSA mode) -> exitSuccess -- TODO: implement RSA

        Just (PGP_XOR mode) -> exitSuccess -- TODO: implement PGP_XOR

        Just (PGP_AES mode) -> exitSuccess -- TODO: implement PGP_AES
