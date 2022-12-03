import Data.List (findIndex, intersect, isInfixOf)
import Data.List.Split
import qualified Data.Map.Strict as HM
import Data.Maybe
import Data.Set (fromList, toList)

createCompartments :: String -> (String, String)
createCompartments x = splitAt (div (fromIntegral (length x)) 2) x

identifyDuplicates :: ([Char], [Char]) -> Char
identifyDuplicates x =
  if (elem (head (fst x)) (snd x))
    then head (fst x)
    else identifyDuplicates ((drop 1 (fst x), (snd x)))

calculatePrioritiesScores :: Char -> HM.Map Char Int -> Int
calculatePrioritiesScores x values = (fromMaybe 0 (HM.lookup x values))

sumList :: [Int] -> Int
sumList x = if length x == 0 then 0 else (head x) + (sumList (drop 1 x))

getBadges :: [String] -> String
getBadges x = toList (fromList (intersect (x !! 0) (intersect (x !! 1) (x !! 2))))

main = do
  input <- readFile ("input.txt")
  let priorityValues = HM.fromList [
        ('a', 1), ('b', 2), ('c', 3), ('d', 4), ('e', 5), ('f', 6), ('g', 7), ('h', 8), ('i', 9), ('j', 10), ('k', 11), ('l', 12), ('m', 13),
        ('n', 14), ('o', 15), ('p', 16), ('q', 17), ('r', 18),('s', 19), ('t', 20), ('u', 21), ('v', 22), ('w', 23), ('x', 24), ('y', 25), ('z', 26),
        ('A', 27), ('B', 28), ('C', 29), ('D', 30), ('E', 31), ('F', 32), ('G', 33), ('H', 34), ('I', 35), ('J', 36), ('K', 37), ('L', 38), ('M', 39),
        ('N', 40), ('O', 41), ('P', 42), ('Q', 43), ('R', 44), ('S', 45), ('T', 46), ('U', 47), ('V', 48), ('W', 49), ('X', 50), ('Y', 51), ('Z', 52)]

  -- Part 1
  let rucksacks = splitOn "\n" input
  let compartments = map createCompartments rucksacks
  let priority = 0

  let priorities = map identifyDuplicates compartments
  let scores = map (`calculatePrioritiesScores` priorityValues) priorities

  let groups = chunksOf 3 rucksacks
  let badges = map getBadges groups
  let badgeScores = map (`calculatePrioritiesScores` priorityValues) (concat badges)

  print (sumList scores)
  print (sumList badgeScores)