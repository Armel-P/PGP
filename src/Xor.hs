{-
-- EPITECH PROJECT, 2026
-- PGP
-- File description:
-- Xor
-}


module Xor where

import System.Exit

import Types (Mode(..), Option(..))

xorCipher :: Option -> String -> String -> IO()
xorCipher Block key message = exitSuccess -- TODO: implement Block cipher
xorCipher NoOption key message = exitSuccess -- TODO: implement NoOption cipher

xorDecipher :: Option -> String -> String -> IO()
xorDecipher Block key message = exitSuccess -- TODO: implement Block decipher
xorDecipher NoOption key message = exitSuccess -- TODO: implement NoOption decipher

xor :: Mode -> IO()
xor (Cipher option key message) = xorCipher option key message

xor (Decipher option key message) = xorDecipher option key message

xor _ = exitWith (ExitFailure 84)
