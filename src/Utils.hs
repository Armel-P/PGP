{-
-- EPITECH PROJECT, 2026
-- PGP
-- File description:
-- Utils
-}

module Utils where

import System.Exit (ExitCode(ExitFailure), exitWith)

failure :: IO()
failure = exitWith (ExitFailure 84)
