input = readlines("input.txt")

interestingCycles = [20, 60, 100, 140, 180, 220]
interstingCyclesSum = 0
currentInputLine = 1
cycleSum = 1
cycle = 1
addxValue = nothing
cycleToAddAt = 0

pixels = [fill(".", 40) for _ = 1:6]
currentSpriteRow = 1

isPixelVisible(position) =
    cycleSum >= -1 &&
    (position == cycleSum || position - 1 == cycleSum || position + 1 == cycleSum)

while (currentInputLine <= length(input))
    if (cycle in interestingCycles)
        global interstingCyclesSum = interstingCyclesSum + (cycle * cycleSum)
    end
    if (isPixelVisible((cycle - 1) % 40))
        col = ((cycle - 1) % 40)
        pixels[currentSpriteRow][col + 1] = "#"
    end
    if (startswith(input[currentInputLine], "addx"))
        if (addxValue == nothing)
            global addxValue = parse(Int64, last(split(input[currentInputLine], " ")))
            global cycleToAddAt = cycle + 1
        elseif (cycle == cycleToAddAt)
            global cycleSum = cycleSum + addxValue
            global addxValue = nothing
            global currentInputLine = currentInputLine + 1
            global cycleToAddAt = 0
        end
    else # noop
        global currentInputLine = currentInputLine + 1
    end
    global cycle += 1
    if ((cycle - 1) % 40 == 0)
        global currentSpriteRow = currentSpriteRow + 1
    end
end

println("Part 1: $interstingCyclesSum")
println("Part 2:")
for row in pixels
    println(row)
end
