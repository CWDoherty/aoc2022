def input = []
new File('input.txt').eachLine { line ->
    input << line
}

gridValues = 'abcdefghijklmnopqrstuvwxyz'
startValue = 'S'
exitValue = 'E'

grid = input.collect {
    it.split('').collect {it }
}

startRow = 0
startCol = 0

findIndex:
for (int i = 0; i < grid.size(); i++) {
    for (int j = 0; j < grid[i].size(); j++) {
        if (grid[i][j] == startValue) {
            startRow = i
            startCol = j
            break findIndex
        }
    }
}

def checkValid(grid, currentValue, row, col, visited) {
    if (row >= 0 && col >= 0 && row < grid.size() && col < grid[row].size()) {
        currentValueInt = currentValue == startValue ? gridValues.indexOf('a') : gridValues.indexOf(currentValue)
        nextValueInt = grid[row][col] == exitValue ? gridValues.indexOf('z') : gridValues.indexOf(grid[row][col])

        return nextValueInt - currentValueInt <= 1 && !visited.contains(new Tuple2(row, col))
    } else {
        return false
    }
}

def findStartingPoints() {
    startingPoints = []
    for (int i = 0; i < grid.size(); i++) {
        for (int j = 0; j < grid[i].size(); j++) {
            if (grid[i][j] == 'a') {
                startingPoints.add(new Tuple2(i, j))
            }
        }
    }
    return startingPoints
}

def search(startX, startY) {
    def visited = [new Tuple2(startX, startY)]
    def queue = [new Tuple(startX, startY, 0)] as Queue
    while (!queue.isEmpty()) {
        currentPoint = queue.remove();
        x = currentPoint[0]
        y = currentPoint[1]
        dist = currentPoint[2]
        currentValue = grid[x][y]

        if (currentValue == exitValue) {
            return dist
        }

        if (checkValid(grid, currentValue, x - 1, y, visited)) {
            queue.add(new Tuple(x - 1, y, dist + 1))
            visited.add(new Tuple2(x - 1, y))
        }
        if (checkValid(grid, currentValue, x + 1, y, visited)) {
            queue.add(new Tuple(x + 1, y, dist + 1))
            visited.add(new Tuple2(x + 1, y))
        }
        if (checkValid(grid, currentValue, x, y - 1, visited)) {
            queue.add(new Tuple(x, y - 1, dist + 1))
            visited.add(new Tuple2(x, y - 1))
        }
        if (checkValid(grid, currentValue, x, y + 1, visited)) {
            queue.add(new Tuple(x, y + 1, dist + 1))
            visited.add(new Tuple2(x, y + 1))
        }
    }
}

println "Part 1: ${search(startRow, startCol)}"
startingPoints = findStartingPoints()
println "Part 2: ${startingPoints.collect { search(it.first, it.second) }.min()}"
