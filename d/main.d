import std.algorithm.iteration : filter, fold, map;
import std.array : array, join, split;
import std.conv : to;
import std.file : readText, write;
import std.path : sep = dirSeparator;
import std.stdio : stderr;

enum Points : int {
  win = 3,
  draw = 1,
  lose = 0
}

void main(string[] args) {
  immutable infile = args[1];
  immutable outfile = (infile.split(sep)[0 .. $ - 1] ~ "result.csv").join(sep);

  try {
    infile.readText.parseCSV.processData.printResult(outfile);
  } catch (Exception e) {
    stderr.writeln("Exception has occured: ", e.msg);
  }
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

bool tryValidate(string pair, out int[] result) {
  try {
    string[] paired = pair.split(':');
    if (paired.length == 0 || paired[0].length == 0 || paired[1].length == 0)
      return false;

    int[] nums = paired.map!(to!int).array;
    if (nums[0] < 0 || nums[1] < 0) return false;

    result = nums;
  } catch (Throwable) {
    return false;
  }
  return true;
}

int[string] processData(string[][] data) {
  return data.fold!((res, line) {
    res[line[0]] = line[1 .. $].map!((pair) {
      int[] nums;
      if (!tryValidate(pair, nums))
        throw new Exception("Invalid input: <" ~ pair ~ "> in 'validate' function");
      return nums;
    }).fold!((acc, score) => acc + points(score))(0);
    return res;
  })( (int[string]).init );
}

void printResult(int[string] data, string outfile, string delim = ",") {
  string result = data.keys.map!(team => [team, data[team].to!string].join(delim)).join('\n');
  outfile.write(result);
}
