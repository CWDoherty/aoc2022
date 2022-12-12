import Data.List (findIndex, intersect, isInfixOf)
import Data.List.Split
import Data.Maybe
import Data.Set (fromList, toList)

createCompartments :: String -> (String, String)
createCompartments x = splitAt (div (fromIntegral (length x)) 2) x

identifyDuplicates :: ([Char], [Char]) -> Char
identifyDuplicates x =
  if (elem (head (fst x)) (snd x))
    then head (fst x)
    else identifyDuplicates ((drop 1 (fst x), (snd x)))

calculatePrioritiesScores :: Char -> String -> Int
calculatePrioritiesScores x values = (fromMaybe 0 (findIndex (== x) values)) + 1

sumList :: [Int] -> Int
sumList x = if length x == 0 then 0 else (head x) + (sumList (drop 1 x))

getBadges :: [String] -> String
getBadges x = toList (fromList (intersect (x !! 0) (intersect (x !! 1) (x !! 2))))

main = do
  input <- readFile ("input.txt")
  let priorityValues = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

  -- Part 1
  let rucksacks = splitOn "\n" input
  let compartments = map createCompartments rucksacks

  let priorities = map identifyDuplicates compartments
  let scores = map (`calculatePrioritiesScores` priorityValues) priorities

  -- Part 2
  let groups = chunksOf 3 rucksacks
  let badges = concat (map getBadges groups)
  let badgeScores = map (`calculatePrioritiesScores` priorityValues) badges

  print (sumList scores)
  print (sumList badgeScores)
