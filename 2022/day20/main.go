package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
)

type Pair struct {
	number        int
	originalIndex int
}

func findPairIndex(index int, items []Pair) int {
	for i := 0; i < len(items); i++ {
		current := items[i]
		if current.originalIndex == index {
			return i
		}
	}
	return -1
}

func findIndex(num int, items []int) int {
	for i := 0; i < len(items); i++ {
		current := items[i]
		if current == num {
			return i
		}
	}
	return -1
}

func removeAtIndex(slice []Pair, s int) []Pair {
	return append(slice[:s], slice[s+1:]...)
}

func getNums(numberMap []Pair) []int {
	var numbers []int
	for i := 0; i < len(numberMap); i++ {
		numbers = append(numbers, numberMap[i].number)
	}
	return numbers
}

func decrypt(numbers []int, decryptionKey int) []int {
	var decrypted []int
	for i := 0; i < len(numbers); i++ {
		decrypted = append(decrypted, numbers[i]*decryptionKey)
	}
	return decrypted
}

func getNumberMap(numbers []int) []Pair {
	var numberMap []Pair
	for i := 0; i < len(numbers); i++ {
		numberMap = append(numberMap, Pair{numbers[i], i})
	}
	return numberMap
}

func mix(numbers []int, numberMap []Pair, numberOfMixes int) []int {
	for n := 0; n < numberOfMixes; n++ {
		for i := 0; i < len(numbers); i++ {
			index := findPairIndex(i, numberMap)
			number := numberMap[index].number
			numberMap = removeAtIndex(numberMap, index)
			newIndex := (index + number) % (len(numbers) - 1)
			if newIndex <= 0 {
				newIndex = len(numbers) - 1 + newIndex
			}
			numberMap = append(numberMap[:newIndex+1], numberMap[newIndex:]...)
			numberMap[newIndex] = Pair{number, i}
		}
	}
	return getNums(numberMap)
}

func main() {
	file, _ := os.Open("input.txt")
	defer file.Close()
	scanner := bufio.NewScanner(file)
	var numbers []int
	for scanner.Scan() {
		n, _ := strconv.Atoi(scanner.Text())
		numbers = append(numbers, n)
	}

	numberMap := getNumberMap(numbers)
	mixed := mix(numbers, numberMap, 1)
	zeroIndex := findIndex(0, mixed)

	groveCoord1 := mixed[(zeroIndex+1000)%len(mixed)]
	groveCoord2 := mixed[(zeroIndex+2000)%len(mixed)]
	groveCoord3 := mixed[(zeroIndex+3000)%len(mixed)]
	fmt.Printf("Part 1: %d\n", groveCoord1+groveCoord2+groveCoord3)

	decryptedNumbers := decrypt(numbers, 811589153)
	decryptedNumberMap := getNumberMap(decryptedNumbers)

	mixedPart2 := mix(decryptedNumbers, decryptedNumberMap, 10)
	zeroIndexPart2 := findIndex(0, mixedPart2)

	groveCoord1Part2 := mixedPart2[(zeroIndexPart2+1000)%len(mixedPart2)]
	groveCoord2Part2 := mixedPart2[(zeroIndexPart2+2000)%len(mixedPart2)]
	groveCoord3Part2 := mixedPart2[(zeroIndexPart2+3000)%len(mixedPart2)]
	fmt.Printf("Part 2: %d\n", groveCoord1Part2+groveCoord2Part2+groveCoord3Part2)
}
