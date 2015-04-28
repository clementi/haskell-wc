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

usage :: IO ()
usage = do
  progName <- getProgName
  putStrLn ("Usage: " ++ progName ++ " [OPTION]... [FILE]...")

version :: IO ()
version = putStrLn "Haskell wc 0.1"

exit :: IO a
exit = exitWith ExitSuccess

die :: IO a
die = exitWith (ExitFailure 1)

parse :: [String] -> IO String
parse [] = getContents
parse ["-h"] = usage >> exit
parse ["-v"] = version >> exit
parse filenames = concat `fmap` mapM readFile filenames

main :: IO ()
main = getArgs >>= parse >>= putStr
