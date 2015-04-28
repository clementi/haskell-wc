module Main where

import System.Environment
import System.Exit

countLines :: String -> Int
countLines = length . lines

countChars :: String -> Int
countChars = length

maxLineLength :: String -> Int
maxLineLength s = maximum . map length $ lines s

countWords :: String -> Int
countWords = length . words

usage = do
  progName <- getProgName
  putStrLn ("Usage: " ++ progName ++ " [OPTION]... [FILE]...")

version = putStrLn "Haskell wc 0.1"

exit = exitWith ExitSuccess
die = exitWith (ExitFailure 1)

parse ["-h"] = usage >> exit
parse ["-v"] = version >> exit

parse args = case args of
               [] -> usage >> exit
               (a:as) -> case a of
                           "-h" -> usage >> exit
                           "-v" -> version >> exit

main :: IO ()
main = getArgs >>= parse

