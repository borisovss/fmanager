module Main (main) where

--import Lib()
--import Control.Concurrent
import UI.NCurses

-- main :: IO ()
-- main = do
--     putStrLn "Hello World"
--     threadDelay oneSec
--     main
--     where
--         oneSec = 1000000



--showCurses :: Curses (Integer, Integer) -> IO String
--showCurses x = show x

-- showCurses :: (Integer, Integer) -> IO ()
-- showCurses (x, y) = do
--     --(x,y) <- v
--     -- putStrLn . show $ x
--     putStrLn "A"

main :: IO ()
main = runCurses $ createCurses


-- main :: IO ()
-- main = runCurses $ do
--     setEcho False

--     (maxRows, maxCols) <- screenSize
--     --print "Hello"

--     w <- defaultWindow
--     updateWindow w $ do
--         moveCursor 1 10
--         drawString "Hello world!"
--         moveCursor 3 10
--         drawString "(press q to quit)"
--         moveCursor 0 0
--     render
--     waitFor w (\ev -> ev == EventCharacter 'q' || ev == EventCharacter 'Q')

waitFor :: Window -> (Event -> Bool) -> Curses ()
waitFor w p = loop where
    loop = do
        ev <- getEvent w Nothing
        case ev of
            Nothing -> loop
            Just ev' -> if p ev' then return () else loop

createCurses :: Curses ()
createCurses = do
    setEcho False

    --w <- defaultWindow

    --maxx <- getmaxx w

    (maxRows, maxCols) <- screenSize
    win1 <- newWindow maxRows (maxCols `div` 2) 0 0
    win2 <- newWindow maxRows (maxCols `div` 2) 0 (maxCols `div` 2) 

    updateWindow win1 $ do
        drawBox Nothing Nothing
        moveCursor 1 1
        drawString "Green"
        moveCursor 2 1
        drawString "Red"
        moveCursor 3 1
        drawString "Blue"
        moveCursor 4 1
        drawString "Black"

    updateWindow win2 $ do
        drawBox Nothing Nothing
        moveCursor 1 1
        drawString "Yellow"
        moveCursor 2 1
        drawString "Brown"

    -- w <- defaultWindow
    -- updateWindow w $ do
    --     moveCursor 1 10
    --     drawString "Hello world!"
    --     moveCursor 3 10
    --     drawString "(press q to quit)"
    --     moveCursor 0 0
    render
    waitFor win1 (\ev -> ev == EventCharacter 'q' || ev == EventCharacter 'Q')