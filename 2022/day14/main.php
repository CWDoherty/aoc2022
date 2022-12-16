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
                        if (!in_array("$currentX,$j", $occupied)) {
                            $occupied[] = "$currentX,$j";
                        }
                    }
                } else {
                    for ($j = $currentY; $j <= $nextY; $j++) {
                        if (!in_array("$currentX,$j", $occupied)) {
                            $occupied[] = "$currentX,$j";
                        }
                    }
                }
            } else {
                $currentX = (int) $currentCoords[0];
                $nextX = (int) $nextCoords[0];
                $currentY = $currentCoords[1];

                if ($currentX > $nextX) {
                    for ($j = $currentX; $j >= $nextX; $j--) {
                        if (!in_array("$,$currentY", $occupied)) {
                            $occupied[] = "$j,$currentY";
                        }
                    }
                } else {
                    for ($j = $currentX; $j <= $nextX; $j++) {
                        if (!in_array("$,$currentY", $occupied)) {
                            $occupied[] = "$j,$currentY";
                        }
                    }
                }
            }
        }
    }

    function moveSand($coord ,&$atAbyss) {
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

        if ($nextY > $abyss * 2) {
            $atAbyss = true;
            return;
        }


        if (!in_array($down, $occupied)) {
            moveSand($down, $atAbyss);
        } else if (!in_array($left, $occupied)) {
            moveSand($left, $atAbyss);
        } else if (!in_array($right, $occupied)) {
            moveSand($right, $atAbyss);
        } else {
            if (!in_array($coord, $occupied)) {
//                echo "Adding: $coord\n";
                $occupied[] = $coord;
            }
        }
    }

    $abyss = array_reduce(array_map(fn($coord): int => (int) explode(",", $coord)[1], $coords), "max") + 1;
    $atAbyss = false;
    $grains = 0;

    echo $abyss;
    while ($atAbyss == false) {
        moveSand("500,0", $atAbyss);
        if ($atAbyss == true) {
            break;
        }
        $grains++;
    }

    echo "Part 1: $grains\n";


