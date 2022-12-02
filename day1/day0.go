package main

import (
	"fmt"
	"os"
	"sort"
	"strconv"
	"strings"
)

type Elf struct {
	index    int
	calories int
}

type Elves []Elf

func (e Elves) Len() int {
	return len(e)
}

func (e Elves) Swap(i, j int) {
	e[i], e[j] = e[j], e[i]
}

func (e Elves) Less(i, j int) bool {
	return e[i].calories > e[j].calories
}

func main() {
	fileName := os.Args[1]

	file, _ := os.ReadFile(fileName)

	fileContents := string(file)

	elfLists := strings.Split(fileContents, "\n\n")

	var elves Elves = []Elf{}

	for i, elfList := range elfLists {
		calories := strings.Split(elfList, "\n")

		totalCalories := 0

		for _, calorie := range calories {
			calorieValue, _ := strconv.Atoi(calorie)

			totalCalories += calorieValue
		}

		fmt.Printf("elf %d has %d calories\n", i, totalCalories)
		elves = append(elves, Elf{index: i, calories: totalCalories})

	}

	sort.Sort(elves)

	fmt.Printf("Most calories: %d (%d)\n", elves[0].calories, elves[0].index+1)
	fmt.Printf("Second most calories: %d (%d)\n", elves[1].calories, elves[1].index+1)
	fmt.Printf("Third most calories: %d (%d)\n", elves[2].calories, elves[2].index+1)

	fmt.Printf("Sum of calories: %d", elves[0].calories+elves[1].calories+elves[2].calories)

}
