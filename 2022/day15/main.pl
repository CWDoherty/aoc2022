#!/usr/bin/perl
use strict;
use warnings;

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

# get max x given a x,y and a manhattan distance
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

sub calculate {
    my($y, @sensorMap) = @_;

    my $maxX = getMaxX(@sensorMap);
    my @range = (($maxX * 2 * -1)..($maxX * 2));
    my $count = 0;

    for (@range) {
        if ($_ % 10000 == 0) {
            print "$_\n";
        }
        my $x = $_;
        my $closerThanSensor = 1;
        foreach my $sensor (@sensorMap) {
            if ($sensor->{-bX} == $x && $sensor->{-bY} == $y) {
                last;
            }
            my $dist = $sensor->{-dist};
            my $manhattanDistance = manhattanDistance($x, $y, $sensor->{-x}, $sensor->{-y});
            # print "$x,$y. Dist: $dist, manhattanDist: $manhattanDistance\n";
            if ($manhattanDistance <= $dist) {
                $closerThanSensor++;
                last;
            }
        }
        if ($closerThanSensor == length @sensorMap ) {
            $count++;
        }
    }
    print "$count\n";
}

my @sensorMap = map {mapSensors $_} @input;

calculate(2000000, @sensorMap);


