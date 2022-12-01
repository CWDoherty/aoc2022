package main

import (
	"fmt"
	"os"
	"sort"
	"strconv"
	"strings"
)

func main() {
	inputFile, _ := os.ReadFile("./input.txt")
	inputString := string(inputFile)
	elvesCalories := strings.Split(inputString, "\n\n")

	sums := make([]int, 0)
	for _, elf := range elvesCalories {
		sum := 0
		for _, calorie := range strings.Split(elf, "\n") {
			val, _ := strconv.Atoi(calorie)
			sum += val
		}
		sums = append(sums, sum)
	}
	sort.Ints(sums)

	mostCalories := sums[len(sums)-1]
	threeMostCalories := 0
	for _, cal := range sums[len(sums)-3:] {
		threeMostCalories += cal
	}

	fmt.Println(mostCalories)
	fmt.Println(threeMostCalories)
}
