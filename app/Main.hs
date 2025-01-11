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



--showCurses :: Curses (Integer, Integer) -> String
--showCurses y  = show y

main :: IO ()
main = runCurses $ do
    setEcho False

    --print (showCurses size1)

    w <- defaultWindow
    updateWindow w $ do
        moveCursor 1 10
        drawString "Hello world!"
        moveCursor 3 10
        drawString "(press q to quit)"
        moveCursor 0 0
    render
    waitFor w (\ev -> ev == EventCharacter 'q' || ev == EventCharacter 'Q')
    where
        size1 = screenSize

waitFor :: Window -> (Event -> Bool) -> Curses ()
waitFor w p = loop where
    loop = do
        ev <- getEvent w Nothing
        case ev of
            Nothing -> loop
            Just ev' -> if p ev' then return () else loop

