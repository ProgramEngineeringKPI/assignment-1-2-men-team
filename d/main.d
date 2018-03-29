import std.algorithm.iteration : filter, fold, map;
import std.array : array, join, split;
import std.conv : to;
import std.file : readText, write;
import std.path : sep = dirSeparator;

enum Points : int {
  win = 3,
  draw = 1,
  lose = 0
}

void main(string[] args) {
  immutable infile = args[1];
  immutable outfile = (infile.split(sep)[0 .. $ - 1] ~ "result.csv").join(sep);

  infile.readText.parseCSV.processData.printResult(outfile);
}

/// Actually, it is possible to do all the work using `std.csv` but it wouldn't be fair
string[][] parseCSV(string data, string delim = ",") {
  return data.split('\n').map!(line => line.split(delim)).filter!(el => !!el).array;
}

int points(int[] score) {
  if (score[0] > score[1]) return Points.win;
  if (score[0] == score[1]) return Points.draw;
  return Points.lose;
}

int[string] processData(string[][] data) {
  int[string] result;
  foreach (line; data) {
    result[line[0]] = line[1 .. $].map!(pair => (
      pair.split(':').map!(to!int).array
    )).fold!((acc, score) => acc + points(score))(0);
  }
  return result;
}

void printResult(int[string] data, string outfile, string delim = ",") {
  string result = data.keys.map!(team => [team, data[team].to!string].join(delim)).join('\n');
  outfile.write(result);
}
