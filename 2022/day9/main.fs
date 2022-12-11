open System.IO

type Knot(x: int, y: int, visited: Set<string>, child: option<Knot>) =
    let mutable x = x;
    let mutable y = y;
    let mutable visited = visited;
    let mutable child = child;

    member this.X with get() = x and set(value) = x <- value
    member this.Y with get() = y and set(value) = y <- value
    member this.Visited with get() = visited and set(value) = visited <- value
    member this.Child with get() = child and set(value) = child <- value

    member this.Move(newX, newY) =
        x <- newX
        y <- newY
        visited <- visited.Add(sprintf "%d,%d" x y)

        if child.IsSome then
            let childKnot = child.Value
            let horizontalDiff = x - child.Value.X
            let verticalDiff = y - child.Value.Y

            if (horizontalDiff < -1) then // Left
                childKnot.Move(childKnot.X - 1, y)
            elif (horizontalDiff > 1) then // Right
                childKnot.Move(childKnot.X + 1, y)
            elif (verticalDiff < -1) then // Down
                childKnot.Move(x, childKnot.Y - 1)
            elif (verticalDiff > 1) then // Up
                childKnot.Move(x, childKnot.Y + 1)
            elif (horizontalDiff + verticalDiff >= 3) then // Diagonal
                let xDir = if horizontalDiff >= 0 then 1 else -1;
                let yDir = if verticalDiff >= 0 then 1 else -1;
                childKnot.Move(childKnot.X + xDir, childKnot.Y + yDir)

let moveKnots(direction: string, count: int, head: Knot) =
    let mutable x = head.X
    let mutable y = head.Y
    for i in 1..count do (
        match direction with
        | "R" ->
            x <- x + 1
        | "U" ->
            y <- y + 1
        | "L" ->
            x <- x - 1
        | "D" ->
            y <- y - 1

        head.Move(x, y)
    )


let input = File.ReadLines("input.txt")

let tail = Knot(0, 0, Set.empty.Add("0,0"), None)
let head = Knot(0, 0, Set.empty.Add("0,0"), Some tail)

let tail9 = Knot(0, 0, Set.empty.Add("0,0"), None)
let tail8 = Knot(0, 0, Set.empty.Add("0,0"), Some tail9)
let tail7 = Knot(0, 0, Set.empty.Add("0,0"), Some tail8)
let tail6 = Knot(0, 0, Set.empty.Add("0,0"), Some tail7)
let tail5 = Knot(0, 0, Set.empty.Add("0,0"), Some tail6)
let tail4 = Knot(0, 0, Set.empty.Add("0,0"), Some tail5)
let tail3 = Knot(0, 0, Set.empty.Add("0,0"), Some tail4)
let tail2 = Knot(0, 0, Set.empty.Add("0,0"), Some tail3)
let tail1 = Knot(0, 0, Set.empty.Add("0,0"), Some tail2)
let head2 = Knot(0, 0, Set.empty.Add("0,0"), Some tail1)

// Part 1
input |> Seq.iter(fun line ->
    let direction = line.Split(" ")[0]
    let count = line.Split(" ")[1] |> int
    moveKnots(direction, count, head)
    moveKnots(direction, count, head2)
)

printfn $"Part 1: {tail.Visited.Count}"
printfn $"Part 2: {tail9.Visited.Count}"
