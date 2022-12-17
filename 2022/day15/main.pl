#!/usr/bin/perl
use strict;
use warnings;
use Math::Geometry::Planar qw(SegmentLineIntersection);
use Try::Tiny;

my @input = ();
open my $lines, 'input.txt' or die;
while( my $line = <$lines>)  {
    push(@input, $line)
}
close $lines;

sub manhattanDistance {
    my($x1, $y1, $x2, $y2) = @_;

    return abs($x1-$x2) + abs($y1-$y2);
}

sub mapSensors {
    my ($line) = @_;
    my @parts = split(':', $line);
    my @sensorParts = split(',', $parts[0]);
    my @beaconParts = split(',', $parts[1]);

    my $sensorX = int((split('=', $sensorParts[0]))[-1]);
    my $sensorY = int((split('=', $sensorParts[-1]))[-1]);
    my $beaconX = int((split('=', $beaconParts[0]))[-1]);
    my $beaconY = int((split('=', $beaconParts[-1]))[-1]);

    return {
        -x    => $sensorX,
        -y    => $sensorY,
        -bX   => $beaconX,
        -bY   => $beaconY,
        -dist => manhattanDistance($sensorX, $sensorY, $beaconX, $beaconY),
    };
}

sub getMaxX {
    my (@sensorMap) = @_;
    my $max = 0;

    foreach my $sensor (@sensorMap) {
        if ($sensor->{-x} > $max) {
            $max = $sensor->{-x};
        }
    }
    return $max;
}

my @sensorMap = map {mapSensors $_} @input;
sub part1 {
    my($y) = @_;

    my $maxX = getMaxX(@sensorMap);
    my @range = (($maxX * 2 * -1)..($maxX * 2));
    my $count = 0;

    for (@range) {
        my $x = $_;
        my $closerThanSensor = 1;
        foreach my $sensor (@sensorMap) {
            if ($sensor->{-bX} == $x && $sensor->{-bY} == $y) {
                last;
            }
            my $dist = $sensor->{-dist};
            my $manhattanDistance = manhattanDistance($x, $y, $sensor->{-x}, $sensor->{-y});
            if ($manhattanDistance <= $dist) {
                $closerThanSensor++;
                last;
            }
        }
        if ($closerThanSensor == length scalar @sensorMap ) {
            $count++;
        }
    }
    return $count;
}

sub createLines() {
    my @lineSegments = ();
    foreach my $sensor (@sensorMap) {
        my $x = $sensor->{-x};
        my $y = $sensor->{-y};
        my $dist = $sensor->{-dist};
        my $pointA = [$x, $y - $dist];
        my $pointB = [$x + $dist, $y];
        my $pointC = [$x, $y + $dist];
        my $pointD = [$x - $dist, $y];
        my $lineA = [$pointA, $pointB]; # top to right
        my $lineB = [$pointB, $pointC]; # right to bottom
        my $lineC = [$pointC, $pointD]; # bottom to left
        my $lineD = [$pointD, $pointA]; # left to top
        push(@lineSegments, [$lineA, $lineB, $lineC, $lineD]);
    }
    return @lineSegments;
}

sub part2 {
    my @lineSegments = createLines();

    my @test = SegmentLineIntersection([[10, 0], [0, 0], [5, -10], [5, 10]]);
    print join(",", @{$test[0]})
}

my $part1 = part1(2000000);
print "Part 1: $part1\n";

# part2();
