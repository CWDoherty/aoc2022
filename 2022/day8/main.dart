import 'dart:io';
import 'dart:math';

Set<String> getVisibleFromRight(rowNum, rowToCheck) {
  var visible = new Set<String>();
  for (int i = 0; i < rowToCheck.length - 1; i++) {
    bool isVisible = rowToCheck.sublist(i + 1).fold(true, (acc, element) => acc && rowToCheck[i] > element);
    if (isVisible) {
      visible.add("$rowNum,${i + 1}");
    }
  }
  return visible;
}

Set<String> getVisibleFromBottom(colNum, colToCheck) {
  var visible = new Set<String>();
  for (int i = 0; i < colToCheck.length - 1; i++) {
    bool isVisible = colToCheck.sublist(i + 1).fold(true, (acc, element) => acc && colToCheck[i] > element);
    if (isVisible) {
      visible.add("${i + 1},$colNum");
    }
  }
  return visible;
}

Set<String> getVisibleFromTop(colNum, colToCheck) {
  var visible = new Set<String>();
  for (int i = colToCheck.length - 1; i > 0; i--) {
    var sublist = colToCheck.sublist(0, i);
    bool isVisible = sublist.fold(true, (acc, element) => acc && colToCheck[i] > element);
    if (isVisible) {
      visible.add("$i,$colNum");
    }
  }
  return visible;
}

Set<String> getVisibleFromLeft(rowNum, rowToCheck) {
  var visible = new Set<String>();
  for (int i = rowToCheck.length - 1; i > 0; i--) {
    var sublist = rowToCheck.sublist(0, i);
    bool isVisible = sublist.fold(true, (acc, element) => acc && rowToCheck[i] > element);
    if (isVisible) {
      visible.add("$rowNum,$i");
    }
  }
  return visible;
}

Set<String> getVisible(row, forest) {
  var visible = new Set<String>();
  var visibleFromRight = getVisibleFromRight(row, forest[row].sublist(1));
  var visibleFromLeft = getVisibleFromLeft(row, forest[row].sublist(0, forest[row].length - 1));

  var column = forest.map((s) => s[row]).toList();
  var visibleFromBottom = getVisibleFromBottom(row, column.sublist(1));
  var visibleFromTop = getVisibleFromTop(row, column.sublist(0, column.length - 1));
  visible.addAll(visibleFromRight);
  visible.addAll(visibleFromLeft);
  visible.addAll(visibleFromBottom);
  visible.addAll(visibleFromTop);
  return visible;
}

int getScenicScore(row, col, forest) {

  var val = forest[row][col];
  var left = [];
  var right = [];
  var up = [];
  var down = [];
  for (int i = col - 1; i >= 0; i--) {
    left.add(forest[row][i]);
  }
  for (int i = col + 1; i < forest[row].length; i++) {
    right.add(forest[row][i]);
  }
  for(int i = row - 1; i >= 0; i--) {
    up.add(forest[i][col]);
  }
  for (int i = row + 1; i < forest[row].length; i++) {
    down.add(forest[i][col]);
  }

  var scores = [];
  var localScore = 0;
  for (int tree in left) {
    localScore++;
    if (tree >= val) {
      break;
    }
  }
  scores.add(localScore);
  localScore = 0;
  for (int tree in right) {
    localScore++;
    if (tree >= val) {
      break;
    }
  }
  scores.add(localScore);
  localScore = 0;
  for (int tree in up) {
    localScore++;
    if (tree >= val) {
      break;
    }
  }
  scores.add(localScore);
  localScore = 0;
  for (int tree in down) {
    localScore++;
    if (tree >= val) {
      break;
    }
  }
  scores.add(localScore);

  return scores.reduce((val, element) => val * element);
}

void main() {
  List forest = [];
  List<String> lines = new File('input.txt').readAsLinesSync();
  lines.forEach((line) {
    var row = line.split("").map((s) => int.parse(s)).toList();
    forest.add(row);
  });
  var rows = forest.length;
  var cols = forest[0].length;

  var perimeterVisible = (rows * 2) + (cols * 2) - 4;

  var visibleTrees = new Set<String>();
  var scenicScores = new List<int>.empty(growable: true);
  for (int i = 1; i < rows - 1; i++) {
    visibleTrees.addAll(getVisible(i, forest));
    for (int j = 1; j < cols - 1; j++) {
      scenicScores.add(getScenicScore(i, j, forest));
    }
  }

  print("Part 1: ${visibleTrees.length + perimeterVisible}");
  print("Part 2: ${scenicScores.reduce(max)}");
}
