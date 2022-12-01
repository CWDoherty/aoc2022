package main

import (
	"bufio"
	"fmt"
	"os"
	"sort"
	"strconv"
)

func check(e error) {
	if e != nil {
		panic(e)
	}
}

func main() {
	input, err := os.Open("./input.txt")
	check(err)
	defer input.Close()

	// Part 1
	scanner := bufio.NewScanner(input)
	totals := make([]int, 0)
	sum := 0
	for scanner.Scan() {
		line := scanner.Text()
		if line != "" {
			number, err := strconv.Atoi(line)
			check(err)
			sum += number
		} else {
			totals = append(totals, sum)
			sum = 0
		}
	}
	sort.Ints(totals)
	mostCalories := totals[len(totals)-1]
	secondMostCalories := totals[len(totals)-2]
	thirdMostCalories := totals[len(totals)-3]
	topThreeCalories := mostCalories + secondMostCalories + thirdMostCalories
	fmt.Print("Part 1: ")
	fmt.Println(mostCalories)
	fmt.Print("Part 2: ")
	fmt.Println(topThreeCalories)

}
