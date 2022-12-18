@main def main(): Unit = {
  val input = scala.io.Source.fromFile("input.txt")
  val lines = input.mkString
  input.close()

  val cubeCoords = lines.trim().split("\n")
  var exposed = 0

  cubeCoords.foreach(coord => {
    val coords = coord.split(",").map(_.toInt)
    val adjacent = getAdjacentCoords(coords(0), coords(1), coords(2)).map { _.mkString(",") }
    var exposedSides = 6

    adjacent.foreach(a => {
      if (cubeCoords.contains(a)) {
        exposedSides -= 1
      }
    })

    exposed += exposedSides
  })

  println(s"Part 1: $exposed")
}


def getAdjacentCoords(x: Int, y: Int, z: Int): List[List[Int]] = {
  val coord1 = List(x - 1, y, z)
  val coord2 = List(x + 1, y, z)
  val coord3 = List(x, y - 1, z)
  val coord4 = List(x, y + 1, z)
  val coord5 = List(x, y, z - 1)
  val coord6 = List(x, y, z + 1)

  List(coord1, coord2, coord3, coord4, coord5 ,coord6)
}
