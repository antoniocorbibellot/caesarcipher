
// The Caesar Cipher based on a Haskell implementation from
// "Programming in Haskell" by Graham Hutton.  Dlang implementation
// (c) Antonio Corbi, GPL3 code

import std.stdio, std.conv;
import std.algorithm, std.algorithm.searching, std.range;
import std.ascii, std.string : countchars;

int let2int(char c) pure @nogc {
  return (c - 'a').to!int;
}

char int2let(int n) pure {
  return (n >= 0 ? 'a' + n : 'z' + n + 1).to!char;
}

char shift(char c, int n) pure {
  return c.isLower ? ((c.let2int + n) % 26).int2let : c;
}

auto encode(int n, char[] s) pure {
  return s.map!(c => c.to!char.shift(n));
}

alias decode = (int n, char[] s) pure { return encode(-n, s); };

auto positions(float x, float[] fl) pure {
  return fl.zip(fl.length.iota).filter!(t => t[0]==x).map!(t => t[1]);
}

float chisqr(float[] os, float[] es) pure @nogc {
  return os.zip(es).map!(t => ((t[0]-t[1])^^2)/t[1]).sum;
}

float[] rotate(int n, float[] fl) pure {
  return (fl.drop(n) ~ fl.take(n)).array;
}

string crack(string s) pure {

  auto freqs(char[] s) pure {
    
    alias cccount = (char c, char[] s) pure {
      return countchars(s, to!string(c)).to!int;
    };
    alias percent = (int n, int m) pure @nogc { return n / m.to!float * 100; };
    alias lowers = (char[] s) pure { return count!isLower(s).to!int; };
	
    enum allChars = "abcdefghijklmnopqrstuvwxyz".to!(char[]);

    return allChars.
      map!(a => percent(cccount(a.to!char, s), lowers(s))).array;
  }

  // ASCII letters frequency from 'a'..'z'
  float[] table = [
    8.2, 1.5, 2.8, 4.3, 12.7, 2.2, 2.0, 6.1, 7.0, 0.2, 0.8, 4.0, 2.4,
    6.7, 7.5, 1.9, 0.1, 6.0,  6.3, 9.1, 2.8, 1.0, 2.4, 0.2, 2.0, 0.1];
  auto table2 = freqs(s.to!(char[]));

  auto chitab = table.length.to!uint.iota.
    map!(n => n.rotate(table2).chisqr(table)).
    array;
  auto minval = chitab.reduce!min;
  auto factor = positions(minval, chitab).front.to!int;

  return decode(factor, s.to!(char[])).to!string;
}
