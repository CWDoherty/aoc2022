import json
import sequtils
import std/algorithm
import std/strformat
import std/strutils
import sugar

let pairs = collect(newSeq):
  for line in readAll(open("input.txt")).strip().split("\n\n"):
    map(line.split("\n"), proc(l: string): JsonNode = parseJson(l))

proc isInOrder(left, right: JsonNode): bool =
  if (left.kind == JInt and right.kind == JInt):
    let leftInt = left.getInt()
    let rightInt = right.getInt()
    return leftInt < rightInt
  elif (left.kind == JInt and right.kind == JArray):
    let leftInt = left.getInt()
    let leftArr = parseJson(fmt"[{leftInt}]")
    return isInOrder(leftArr, right)
  elif (right.kind == JInt and left.kind == JArray):
    let rightInt = right.getInt()
    let rightArr = parseJson(fmt"[{rightInt}]")
    return isInOrder(left, rightArr)
  else: # both arrays
    let leftElems = left.getElems();
    let rightElems = right.getElems();

    let zipped = zip(leftElems, rightElems)
    for p in zipped:
      if (isInOrder(p[0], p[1])):
          return true
      if (isInOrder(p[1], p[0])):
        return false

    let leftJson = newJInt(len(leftElems))
    let rightJson = newJInt(len(rightElems))
    return isInOrder(leftJson, rightJson)

var part1 = 0
for i in 1..len(pairs):
  let pair = pairs[i - 1]
  if (isInOrder(pair[0], pair[1])):
    part1 += i

echo fmt"Part 1: {part1}"

let lines = collect(newSeq):
  for line in filter(readAll(open("input.txt")).strip().split("\n"), proc(l: string): bool = l != ""):
    parseJson(line)

proc compare(left, right: JsonNode): int =
  if (left == right):
    return 0
  elif (isInOrder(left, right)):
    return -1
  else:
    return 1

let dividerPacketTwo = parseJson("[[2]]")
let dividerPacketSix = parseJson("[[6]]")
var part2Input = concat(lines, @[dividerPacketTwo], @[dividerPacketSix])
part2Input.sort(compare)
let twoIndex = find(part2Input, dividerPacketTwo) + 1
let sixIndex = find(part2Input, dividerPacketSix) + 1
let part2 = twoIndex * sixIndex

echo fmt"Part 2: {part2}"
