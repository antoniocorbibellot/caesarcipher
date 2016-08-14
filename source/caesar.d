
// The Caesar Cipher based on a Haskell implementation from
// "Programming in Haskell" by Graham Hutton.  Dlang implementation
// (c) Antonio Corbi, GPL3 code

/////////////
// IMPORTS //
/////////////
import std.stdio, std.conv;
import std.algorithm, std.algorithm.searching, std.range;
import std.ascii, std.string : countchars;

//////////
// CODE //
//////////
int let2int (char c) {
  return cast(int) (c - 'a');
}

char int2let (int n) {
  if (n >= 0)
    return cast(char) ('a' + n);
  else
    return cast(char) ('z' + n + 1);
}

char shift (int n, char c) {
  return isLower (c) ? int2let ((let2int (c) + n) % 26) : c;
}

string encode (int n, string s) {
  string r;

  s.each!(c => r ~= shift(n, c));
  return r;
}

alias decode = (int n, string s) { return encode (-n, s); };

float percent (int n, int m) {
  return (n / cast(float) m) * 100;
}

int[] positions (float x, float[] fl) {
  int[] il;
  
  auto r = zip (fl, iota(fl.length)).filter!(t => t[0]==x).map!(t => t[1]);

  r.each!(a => il ~= cast(int)a);
  
  return il;
}

int lowers (string s) {
  return cast(int) count!(a => a.isLower)(s);
}

int cccount (char c, string s) {
  return cast(int) countchars(s, to!string(c));
}

float[] freqs (string s) {
  float[] f;
  auto allChars = "abcdefghijklmnopqrstuvwxyz";
  auto n = lowers(s);

  auto r = allChars.map!(a => percent (cccount(to!char(a), s), n) );
  r.each!(a => f ~= a);
  
  return f;
}

////////////////////////////
// Cracking the cipher... //
////////////////////////////

float chisqr (float[] os, float[] es) {
  return zip(os, es).map!(t => ((t[0]-t[1])^^2)/t[1]).sum;
}

float[] rotate (int n, float[] fl) {
  float[] f;
  
  auto r = fl.drop(n) ~ fl.take(n);
  r.each!(a => f ~= a);
  
  return f;
}

string crack (string s) {
  // English letters frequency
  float[] table = [8.2, 1.5, 2.8, 4.3, 12.7, 2.2, 2.0, 6.1, 7.0, 0.2, 0.8, 4.0, 2.4,
                   6.7, 7.5, 1.9, 0.1, 6.0,  6.3, 9.1, 2.8, 1.0, 2.4, 0.2, 2.0, 0.1];
  float[] table2 = s.freqs;

  auto chitabr = iota(26).map!(n => rotate(n, table2).chisqr(table));
  float[] chitab;
  chitabr.each!(a => chitab ~= a);
  auto minval = reduce!(min)(chitab);
  auto factor = positions (minval, chitab)[0];
  
  return decode (factor, s);
}
