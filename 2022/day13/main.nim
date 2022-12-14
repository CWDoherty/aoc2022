import json
import sequtils
import std/strformat
import std/strutils
import sugar

let pairs = collect(newSeq):
  for line in readAll(open("input.txt")).strip().split("\n\n"):
    map(line.split("\n"), proc(l: string): JsonNode = parseJson(l))

proc isInOrder(left: JsonNode, right: JsonNode): bool =
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

var sumInOrder = 0
for i in 1..len(pairs):
  let pair = pairs[i - 1]
  if (isInOrder(pair[0], pair[1])):
    sumInOrder += i


echo fmt"Part 1: {sumInOrder}"
