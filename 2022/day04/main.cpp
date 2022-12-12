#include <fstream>

#include <iostream>

#include <sstream>

#include <vector>

#include <algorithm>

using namespace std;

int main() {
  vector < string > lines;
  string line;
  ifstream fin("input.txt");
  while (getline(fin, line)) {
    lines.push_back(line);
  }

  int countPart1 = 0;
  int countPart2 = 0;

  for (string l: lines) {
    int commaIndex = l.find(",");
    string firstPair = l.substr(0, commaIndex);
    string secondPair = l.substr(commaIndex + 1);

    int firstPairDashIndex = firstPair.find("-");
    int secondPairDashIndex = secondPair.find("-");
    string firstPairMinStr = firstPair.substr(0, firstPairDashIndex);
    string firstPairMaxStr = firstPair.substr(firstPairDashIndex + 1);
    string secondPairMinStr = secondPair.substr(0, secondPairDashIndex);
    string secondPairMaxStr = secondPair.substr(secondPairDashIndex + 1);

    int firstPairMin = stoi(firstPairMinStr);
    int firstPairMax = stoi(firstPairMaxStr);
    int secondPairMin = stoi(secondPairMinStr);
    int secondPairMax = stoi(secondPairMaxStr);

    if ((firstPairMin <= secondPairMin && firstPairMax >= secondPairMax) || (secondPairMin <= firstPairMin && secondPairMax >= firstPairMax)) {
      countPart1++;
    }

    // Part 2
    vector < int > firstRange;
    vector < int > secondRange;

    for (int i = firstPairMin; i <= firstPairMax; i++) {
      firstRange.push_back(i);
    }
    for (int i = secondPairMin; i <= secondPairMax; i++) {
      secondRange.push_back(i);
    }

    vector < int > intersection;
    std::set_intersection(firstRange.begin(), firstRange.end(),
      secondRange.begin(), secondRange.end(),
      back_inserter(intersection));

    if (intersection.size() > 0) {
      countPart2++;
    }

  }
  std::cout << countPart1 << endl;
  std::cout << countPart2 << endl;
}