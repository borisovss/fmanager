module Main (main) where

import Lib
import Control.Concurrent

main :: IO ()
main = do
    putStrLn "Hello World"
    threadDelay oneSec
    main
    where
        oneSec = 1000000

