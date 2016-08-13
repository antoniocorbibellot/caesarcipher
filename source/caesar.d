
// The Caesar Cipher based on a Haskell implementation from "Learning Haskell".
// (c) Antonio Corbi, GPL3 code

// static this () {
//   import std.stdio;
  
//   writeln ("Module constructor.");
//   foreach (c ; 0..26) {
//     writefln ("%c: %d", cast(char)c, c);
//     letters[c] = cast(char)(c +'a');
//   }

// }

// char[26] letters;

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
  import std.ascii;
  
  return isLower (c) ? int2let ((let2int (c) + n) % 26) : c;
}

string encode (int n, string s) {
  import std.algorithm;
  string r;

  s.each!(c => r ~= shift(n, c));
  return r;
}

string decode (int n, string s) { return encode (-n, s); }

float percent (int n, int m) {
  return (n/cast(float)m) * 100;
}

int count (char c, string s) {
  import std.string : countchars;
  import std.conv : to;

  return cast(int) countchars(s, to!string(c));
}

float[] freqs (string s) {
  float[] f;

  return f;
}
