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

readFiles :: [String] -> IO String
readFiles filenames = concat `fmap` mapM readFile filenames
      
parse :: [String] -> IO Int
parse [] = getContents >>= return . countLines
parse ["-w"] = getContents >>= return . countWords
parse ["-c"] = getContents >>= return . countChars
parse ["-l"] = getContents >>= return . countLines
parse ["-L"] = getContents >>= return . maxLineLength
parse ("-w":filenames) = readFiles filenames >>= return . countWords
parse ("-c":filenames) = readFiles filenames >>= return . countChars
parse ("-l":filenames) = readFiles filenames >>= return . countLines
parse ("-L":filenames) = readFiles filenames >>= return . maxLineLength
parse ["--help"] = usage >> exit
parse ["--version"] = version >> exit
parse filenames = readFiles filenames >>= return . countLines

main :: IO ()
main = getArgs >>= parse >>= print
