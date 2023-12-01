import Control.Monad
import Data.Char
import Data.Maybe
import System.IO
import System.Environment

filterDigit :: Char -> Maybe Int
filterDigit a = let
                    x = (fromEnum a) - (fromEnum '0')
                in
                    if x >= 0 && x <= 9 then Just x else Nothing

filterMap :: String -> [Int]
filterMap line = catMaybes (map filterDigit line)

joinFirstAndLast :: [Int] -> Int
joinFirstAndLast x = (head x) * 10 + (last x)

main :: IO()
main = do 
    args <- getArgs
    content <- readFile (head args)
    putStrLn $ show $ sum $ map (joinFirstAndLast . filterMap) $ lines content
