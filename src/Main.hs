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

parse [] = getContents
parse ["-h"] = usage >> exit
parse ["-v"] = version >> exit
parse fs = concat `fmap` mapM readFile fs

main :: IO ()
main = getArgs >>= parse

