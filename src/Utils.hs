{-
-- EPITECH PROJECT, 2026
-- PGP
-- File description:
-- Utils
-}

module Utils where

import System.Exit (ExitCode(ExitFailure), exitWith)
import Data.Word (Word8)

import Conversion (bytesToHex)

failure :: IO()
failure = exitWith (ExitFailure 84)

dropFinalNewline :: String -> String
dropFinalNewline []     = []
dropFinalNewline "\n"   = []
dropFinalNewline (x:xs) = x : dropFinalNewline xs
