using System;
using System.Linq;
using System.Collections.Generic;

string input = File.ReadAllText("input.txt");
List<string> inputParts = input.Split("\n\n").ToList();
List<string> crates = inputParts[0].Split("\n").ToList();
List<string> commands = inputParts[1].Split("\n").ToList();
Console.WriteLine(crates);

crates.RemoveAt(crates.Count - 1);
int numStacks = crates[crates.Count - 1].Split(" ").ToList().Count;
crates.Reverse();

List<Stack<char>> stacksPart1 = new List<Stack<char>>();
List<Stack<char>> stacksPart2 = new List<Stack<char>>();
for (int i = 0; i < numStacks; i++) {
    stacksPart1.Add(new Stack<char>());
    stacksPart2.Add(new Stack<char>());
}

foreach (var crate in crates){
    Console.WriteLine(crate);
}

foreach (var crate in crates)
{
    for (int i = 0; i < numStacks; i++)
    {
        var crateValue = crate[(i * 4) + 1];
        if (crateValue != ' ') {
            stacksPart1[i].Push(crateValue);
            stacksPart2[i].Push(crateValue);
        }
    }
}

foreach (var command in commands)
{
    List<string> commandParts = command.Split(" ").ToList();
    int numberToMove = Int32.Parse(commandParts[1]);
    int stackToMoveFrom = Int32.Parse(commandParts[3]);
    int stackToMoveTo = Int32.Parse(commandParts[5]);

    List<char> containersToMove = new List<char>();
    for (int i = 0; i < numberToMove; i++) {
        // Part 1
        stacksPart1[stackToMoveTo - 1].Push(stacksPart1[stackToMoveFrom - 1].Pop());

        // Part 2
        containersToMove.Add(stacksPart2[stackToMoveFrom - 1].Pop());
    }

    // Part 2 cont.
    containersToMove.Reverse();
    foreach (var container in containersToMove)
    {
        stacksPart2[stackToMoveTo - 1].Push(container);
    }
}



string topContainersPart1 = "";
string topContainersPart2 = "";

foreach (var stack in stacksPart1)
{
    char container = stack.Pop();
    topContainersPart1 += container;
}

foreach (var stack in stacksPart2)
{
    char container = stack.Pop();
    topContainersPart2 += container;
}

Console.WriteLine(topContainersPart1);
Console.WriteLine(topContainersPart2);