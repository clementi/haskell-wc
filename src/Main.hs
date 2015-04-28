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
parse ["-w"] = getContents -- TODO
parse ["-c"] = getContents -- TODO
parse ["-l"] = getContents -- TODO
parse ["-L"] = getContents -- TODO
parse ("-w":filenames) = getContents -- TODO
parse ("-c":filenames) = getContents -- TODO
parse ("-l":filenames) = getContents -- TODO
parse ("-L":filenames) = getContents -- TODO
parse ["--help"] = usage >> exit
parse ["--version"] = version >> exit
parse filenames = concat `fmap` mapM readFile filenames

main :: IO ()
main = getArgs >>= parse >>= putStr
