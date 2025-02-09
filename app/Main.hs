module Main (main) where

import Control.Monad
import Control.Monad.IO.Class
import UI.NCurses
import System.Directory
import Data.List

main :: IO ()
main = do
    runCurses $ createCurses

waitFor :: Window -> (Event -> Bool) -> Curses ()
waitFor win p = loop
    where
    loop = do
        ev <- getEvent win Nothing
        case ev of
            Nothing -> loop
            Just ev' -> if p ev' then return () else loop

createUpdate :: [String] -> Integer -> Update ()
createUpdate files row
    | length files /= 0 = do
        drawBox Nothing Nothing
        moveCursor row 1
        drawString $ head files
        createUpdate (tail files) (row + 1)
    | otherwise = do
        drawBox Nothing Nothing

createCurses :: Curses ()
createCurses = do
    setEcho False

    rootFiles <- liftIO $ getDirectoryContents "/"
    localFiles <- liftIO $ getDirectoryContents "./"

    (maxRows, maxCols) <- screenSize
    win1 <- newWindow maxRows (maxCols `div` 2) 0 0
    win2 <- newWindow maxRows (maxCols `div` 2) 0 (maxCols `div` 2)

    let sortedRootFiles = sort rootFiles
    let sortedLocalFiles = sort localFiles
    let startedRow = 1

    updateWindow win1 (createUpdate sortedRootFiles startedRow) 
    updateWindow win2 (createUpdate sortedLocalFiles startedRow) 

    render
    waitFor win1 (\ev -> ev == EventCharacter 'q' || ev == EventCharacter 'Q')
