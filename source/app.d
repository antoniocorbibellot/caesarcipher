import std.stdio;
import caesar;

void main()
{
	writeln("Edit source/app.d to start your project.");

    // writeln ("Shift z by 3: ", shift (3, 'z'));
    // writeln ("Shift c by -3: ", shift (-3, 'c'));
    // writeln ("Shift ' ' by 3: ", shift (3, ' '));

    // writeln ("'z': ", cast(int)'z');
    // writeln ("l2i 'z': ", let2int('z'));
    // writeln ("'c': ", cast(int)'c');
    // writeln ("l2i 'c': ", let2int('c'));

    // foreach (s ; -3..0) {
    //   writefln ("Shift c by %s: %c", s, shift (s, 'c'));
    // }

    // foreach (c ; 0..26) {
    //    writefln ("letters[%d] = %c", c, letters[c]);
    // }

    // writeln ("-1 % 26 = ", -1 % 26);

    foreach (k ; 0..5) {
      writefln ("hola (%d): %s", k, encode(k, "hola"));
    }

    writeln ("Decode jqnc = ", decode (2, "jqnc"));
}
