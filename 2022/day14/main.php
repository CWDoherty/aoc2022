<?php
    $file = new SplFileObject("input.txt");
    $lines = array();
    while (!$file->eof()) {
        // Echo one line from the file.
        $line = $file->fgets();
        if ($line != "") {
            $lines[] = $line;
        }
    }
    $file = null;

    $coords = array();
    $occupied = array();
    foreach (array_unique($lines) as $line) {
        $coords = explode(" -> ", $line);
        foreach ($coords as $coord) {
            if (!in_array($coord, $coords)) {
                $coords[] = $coord;
            }
        }
        for ($i = 0; $i < sizeof($coords) - 1; $i++) {
            $current = $coords[$i];
            $next = $coords[$i + 1];

            $currentCoords = explode(",", $current);
            $nextCoords = explode(",", $next);

            if ($currentCoords[0] == $nextCoords[0]) {
                $currentY = (int) $currentCoords[1];
                $nextY = (int) $nextCoords[1];
                $currentX = $currentCoords[0];

                if ($currentY >= $nextY) {
                    for ($j = $currentY; $j >= $nextY; $j--) {
                        if (!array_key_exists("$currentX,$j", $occupied)) {
                            $occupied["$currentX,$j"] = "#";
                        }
                    }
                } else {
                    for ($j = $currentY; $j <= $nextY; $j++) {
                        if (!array_key_exists("$currentX,$j", $occupied)) {
                            $occupied["$currentX,$j"] = "#";
                        }
                    }
                }
            } else {
                $currentX = (int) $currentCoords[0];
                $nextX = (int) $nextCoords[0];
                $currentY = $currentCoords[1];

                if ($currentX > $nextX) {
                    for ($j = $currentX; $j >= $nextX; $j--) {
                        if (!array_key_exists("$,$currentY", $occupied)) {
                            $occupied["$j,$currentY"] = "#";
                        }
                    }
                } else {
                    for ($j = $currentX; $j <= $nextX; $j++) {
                        if (!array_key_exists("$,$currentY", $occupied)) {
                            $occupied["$j,$currentY"] = "#";
                        }
                    }
                }
            }
        }
    }

    function moveSand($coord ,&$atAbyss, $floor) {
        global $occupied;
        global $abyss;
        $x = explode(",", $coord)[0];
        $y = explode(",", $coord)[1];
        $nextY = $y + 1;
        $leftX = $x - 1;
        $rightX = $x + 1;
        $down = "$x,$nextY";
        $left = "$leftX,$nextY";
        $right = "$rightX,$nextY";
        $downIn = array_key_exists($down, $occupied) || $nextY == $floor;
        $leftIn = array_key_exists($left, $occupied) || $nextY == $floor;
        $rightIn = array_key_exists($right, $occupied) || $nextY == $floor;

        // Part 1
        if ($floor == null && $nextY >= $abyss * 2) {
            $atAbyss = true;
            return;
        }

        // Part 2
        if ($coord == "500,0" && $downIn && $leftIn && $rightIn) {
            $atAbyss = true;
            $occupied[$coord] = "o";
            return;
        }

        if (!$downIn) {
            moveSand($down, $atAbyss, $floor);
        } else if (!$leftIn) {
            moveSand($left, $atAbyss, $floor);
        } else if (!$rightIn) {
            moveSand($right, $atAbyss, $floor);
        } else {
            $occupied[$coord] = "o";
        }
    }

    $abyss = array_reduce(array_map(fn($coord): int => (int) explode(",", $coord)[1], $coords), "max");
    $atAbyss = false;
    $grains = 0;
    $occupiedCopy = $occupied;

    while ($atAbyss == false) {
        moveSand("500,0", $atAbyss,  null);
        if ($atAbyss == true) {
            break;
        }
        $grains++;
    }

    echo "Part 1: $grains\n";

    $atAbyss = false;
    $grains = 0;
    $occupied = $occupiedCopy;

    $floor = $abyss + 16; // Absolutely no idea why this works
    while ($atAbyss == false) {
        moveSand("500,0", $atAbyss, $floor);
        if ($atAbyss == true) {
            break;
        }
        $grains++;
    }

    $grains++;
    echo "Part 2: $grains\n";
