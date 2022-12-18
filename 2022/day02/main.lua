local lines = {}
for line in io.lines('input.txt') do
    lines[#lines + 1] = line
end

function split(s, delimiter)
    result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result;
end

local decrypted = {
    X="A",
    Y="B",
    Z="C",
}

local scores = {
    A=1,
    B=2,
    C=3,
}

local rankings = {
    A="C",
    B="A",
    C="B",
}

local rankingsPartTwo = {
    A={"B", "C"},
    B={"C", "A"},
    C={"A", "B"},
}

local partOneScore = 0;
local partTwoScore = 0;

for _, v in pairs(lines) do
    local choices = split(v, " ");
    local opponentsChoice = choices[1];
    local myChoice = decrypted[choices[2]];

    -- Part 1
    if (opponentsChoice == myChoice) then
        partOneScore = partOneScore + 3;
        partOneScore = partOneScore + scores[myChoice];
    elseif (rankings[opponentsChoice] == myChoice) then
        partOneScore = partOneScore + scores[myChoice];
    else
        partOneScore = partOneScore + 6;
        partOneScore = partOneScore + scores[myChoice];
    end

    -- Part 2
    local myChoicePartTwo = choices[2];

    if (myChoicePartTwo == "Y") then
        partTwoScore = partTwoScore + 3;
        partTwoScore = partTwoScore + scores[opponentsChoice];
    elseif (myChoicePartTwo == "X") then
        partTwoScore = partTwoScore + scores[rankingsPartTwo[opponentsChoice][2]];
    else
        partTwoScore = partTwoScore + 6;
        partTwoScore = partTwoScore + scores[rankingsPartTwo[opponentsChoice][1]];
    end
end

print("Part 1: "..partOneScore.."");
print ("Part 2: "..partTwoScore.."");