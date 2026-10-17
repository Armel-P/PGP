{-
-- EPITECH PROJECT, 2026
-- PGP
-- File description:
-- Main
-}

import System.Exit
import System.Environment
import System.IO

import Utils (failure, dropFinalNewline)
import Types (CryptoSystem(..))
import Parsing (parseArgs)
import Doc.Help (help)
import Xor (xorMode)
import Aes (aesMode)
import Rsa (rsaMode)

main :: IO()
main = setBinary
    >> (parseArgs <$> getArgs <*> (dropFinalNewline <$> getContents))
    >>= maybe failure run

setBinary :: IO()
setBinary = mapM_ (`hSetBinaryMode` True) [stdin, stdout]

run :: CryptoSystem -> IO()
run Help          = help
run (XOR mode)    = xorMode mode
run (AES mode)    = aesMode mode
run (RSA mode)    = rsaMode mode
run (PGP_XOR _)   = exitSuccess  -- TODO
run (PGP_AES _)   = exitSuccess  -- TODO
