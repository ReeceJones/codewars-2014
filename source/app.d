import std.stdio;
import std.string;
import std.conv;
import std.array;
import std.range;
import std.math;
import std.algorithm;
import std.typecons;
import std.regex;


import codewars.shortcuts;
import codewars.math;

version(prob00)
{
	void invoke()
	{
		writeln("Team XXXX is ready for HP CodeWars 17!");
	}
}

version(prob01)
{
	void invoke()
	{
		uint r = dumbRead!uint;
		alias P = (t) => 100 * sqrt(cast(double)t) + 201/(cast(double)t+1) + 1;
		while (r != 0)
		{
			writeln(r, " ", cast(int)(P(r) + 0.5));
			r = dumbRead!uint;
		}
	}
}

version(prob02)
{
	int checkDigit(int[] arr)
	{
		int odd;
		int even;
		foreach(i, val; arr)
		{
			switch ((i+1) % 2)
			{
				case 0:
					even += val;
				break;
				default:
					odd += val;
				break;
			}
		}
		odd *= 3;
		int sum = odd + even;
		return sum % 10 == 0 ? 0 : 10 - (sum % 10);
	}
	void invoke()
	{
		uint n = dumbRead!uint;
		foreach(_; n.iota)
		{
			string ln = readln.stripRight;
			writeln(ln, " ", checkDigit(ln.split(" ").map!(a => a.to!int).array));
		}
	}
	/*

	*/
}

version(prob03)
{
	int[char] power;
	int milliamps(string s)
	{
		int m;
		foreach(c; s)
		{
			if(c != ':')
				m += power[c] * 15;
			else
				m += 20;
		}
		return m;
	}
	unittest
	{
		power = [
			'1' : 2,
			'2' : 5,
			'3' : 5,
			'4' : 4,
			'5' : 5,
			'6' : 6,
			'7' : 3,
			'8' : 7,
			'9': 7,
			'0' : 6
		];
		assert(milliamps("1:23") == 200);
		assert(milliamps("10:58") == 320);
		assert(milliamps("12:00") == 305);
		assert(milliamps("3:14") == 185);
		assert(milliamps("1:11") == 110);
		assert(milliamps("7:38") == 245);
	}
	void invoke()
	{
		power = [
			'1' : 2,
			'2' : 5,
			'3' : 5,
			'4' : 4,
			'5' : 5,
			'6' : 6,
			'7' : 3,
			'8' : 7,
			'9' : 7,
			'0' : 6
		];
		uint n = dumbRead!uint;
		foreach(_; n.iota)
		{
			writeln(readln.stripRight.milliamps, " milliamps");
		}
	}
}

version(prob04)
{
	int val;
	alias Guess = Tuple!(int, "guess", string, "name");
	bool cond(const Guess left, const Guess right)
	{
		return abs(left.guess - val) < abs(right.guess - val);
	}
	void invoke()
	{
		val = dumbRead!uint;
		uint n = dumbRead!uint;
		Guess[] guesses;
		foreach(_; n.iota)
		{
			guesses ~= cast(Guess)treadf!("%d %s\n", int, string);
		}
		guesses.sort!cond;
		string[] winners;
		int winnerDelta = cast(int)abs(guesses[0].guess - val);
		writeln(guesses);
		foreach(guess; guesses)
		{
			if (cast(int)abs(guess.guess - val) != winnerDelta) break;
			else winners ~= guess.name;
		}
		writeln(winners);
		winners.each!((a) => write(a, " "));
		writeln;
	}
}

version(prob05)
{
	int panagram(string s)
	{
		string op = s.dup;
		op = op.replace(regex("[^a-zA-z]", "g"), "");
		int[char] occmap;
		foreach(c; op)
			occmap[c]++;
		bool perfect = true;
		bool panagram = occmap.length == 26;
		foreach(key, val; occmap.byPair)
		{
			if (val > 1)
			{
				perfect = false;
				break;
			}
		}
		if (perfect && panagram)
			return 2;
		if (panagram)
			return 1;
		return 0;
	}
	unittest
	{
		assert(panagram("THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG.") == 1);
		assert(panagram("ALL YOUR BASE ARE BELONG TO US; SOMEONE SET US UP THE BOMB.") == 0);
		assert(panagram("\"NOW FAX A QUIZ TO JACK!\" MY BRAVE GHOST PLED.") == 1);
		assert(panagram("QUICK HIJINX SWIFTLY REVAMPED THE GAZEBO.") == 1);
		assert(panagram("NEW JOB: FIX MR GLUCK'S HAZY TV, PDQ.") == 2);
		assert(panagram("LOREM IPSUM DOLOR SIT AMET CONSECTETUR ADIPISCING ELIT.") == 0);
		assert(panagram("PACK MY BOX WITH FIVE DOZEN LIQUOR JUGS.") == 1);
	}
	void invoke()
	{
		string s;
		while ((s = readln.stripRight) != ".")
		{
			switch (s.panagram)
			{
				case 2:
					write("PERFECT: ");
				break;
				case 1:
					write("PANAGRAM: ");
				break;
				default:
					write("NEITHER: ");
				break;
			}
			writeln(s);
		}
	}
}

version(prob06)
{
	string[] negatives = [ "DONT", "CANT", "HAVENT", "CANNOT", "WOULDNT", "COULDNT", "WONT", "NO", "NOT", "NEVER", "NOBODY", "NOWHERE", "NEITHER", "AINT" ];
	int countNegatives(string s)
	{
		auto tok = s.split(" ").map!(a => a.replace(regex("[^a-zA-z]", "g"), ""));
		tok.writeln;
		int cnt;
		foreach(neg; negatives)
		{
			bool cond(const string a)
			{
				return a == neg;
			}
			cnt += tok.count!cond;
		}
		writeln(cnt);
		return cnt;
	}
	unittest
	{
		assert( countNegatives("THERE NEVER WAS NO MAN NOWHERE SO VIRTUOUS.") == 3);
		assert( countNegatives("I CAN'T GET NO, NO, NO, NO, HEY, HEY, HEY, NO SATISFACTION") == 6);
	}
	void invoke()
	{
		string ln;
		while((ln = readln.stripRight) != ".")
		{
			writeln(countNegatives(ln), ": ", ln);
		}
	}
}

version(prob07)
{
	string digitToA(int n)
	{
		int p;
		int x = n;
		string s = "";
		string[int] convTable = [
			1 : "I",
			5 : "P",
			10 : "D",
			50 : "PD",
			100 : "H",
			500 : "PH",
			1000 : "C",
			5000 : "PC",
			10_000 : "M",
			50_000 : "PM"
		];
		// I heard you like cryptography
		int[] split(int z)
		{
			if (z == 0) return [];
			int[] a;
			int po = cast(int)log10(z);
			int b = cast(int)(cast(double)z * pow(10, -cast(double)po));
			if (b > 5)
			{
				a ~= 5;
				int f = b - 5;
				while (f > 0)
				{
					a ~= 1;
					f--;
				}
			}
			else if (b == 5)
			{
				a ~= b;
			}
			else
			{
				// split into ones
				int f = b;
				while (f > 0)
				{
					a ~= 1;
					f--;
				}
			}
			// reapply power
			int[] r;
			foreach(t; a)
			{
				r ~= t * (10 ^^ po);
			}
			return r;
		}
		while (x > 0)
		{
			int conv = (x % 10) * (10 ^^ p++);
			// convert the isolated number to the PENTATEWEGVSDgewgaeg
			auto splitted = split(conv);
			string t = "";
			foreach(v; splitted)
			{
				t ~= convTable[v];
			}
			s = t ~ s;
			x /= 10;
		}
		return s;
	}
	int aToDigit(string a)
	{
		int[string] convTable = [
			"I" : 1,
			"P" : 5,
			"D" : 10,
			"PD" : 50,
			"H" : 100,
			"PH" : 500,
			"C" : 1000,
			"PC" : 5000,
			"M" : 10_000,
			"PM" : 50_000
		];
		/*
			1 : "I",
			5 : "P",
			10 : "D",
			50 : "PD",
			100 : "H",
			500 : "PH",
			1000 : "C",
			5000 : "PC",
			10_000 : "M",
			50_000 : "PM"
		*/
		int result;
		for (int i = 0; i < a.length; i++)
		{
			int largestMatch;
			int single = convTable[[a[i]]];
			int doub = 0;
			if (i < a.length - 1)
			{
				string q = a[i..i+2];
				assert(q.length == 2);
				if ((q in convTable))
					doub = convTable[q];
			}
			largestMatch = single > doub ? single : doub;
			if (largestMatch == doub) i++;
			result += largestMatch;
		}
		return result;
	}
	unittest
	{
		writeln("RESULT: ", digitToA(8));
		writeln("RESULT: ", digitToA(50));
		writeln("RESULT: ", digitToA(475));
		writeln("RESULT: ", digitToA(5678));
		writeln("RESULT: ", digitToA(8642));
		writeln("eRWER: ", aToDigit("PCCCCPHHDDDDII"));
	}
	void invoke()
	{
		uint n = dumbRead!uint;
		loop(n, {
			string s = readln.stripRight;
			if (s.match(regex("[a-zA-z]", "g"))) // afuwe
			{
				writeln(s.aToDigit);
			}
			else // digit
			{
				writeln(s.to!int.digitToA);
			}
		});
	}
}

version(prob08)
{
	void invoke()
	{ // 4 PROXIMATE DISTANT EXTREME FARTHEST ULTIMATE $
		string s;
		while ((s = readln.stripRight) != "0 $")
		{
			auto tok = s.split(" ")[0..$-1]; // ignore the $
			writeln(tok[$-(tok[0].to!uint)]);
		}
	}
}

version(prob09)
{
	alias Conjecture = Tuple!(int, int);
	Conjecture goldbach(int n)
	{
		Conjecture[] pairs;
		for (int i = 2; i < n; i++)
		{
			int conj = n - i;
			assert(i+conj == n);
			if (conj.isPrime && i.isPrime)
			{
				pairs ~= Conjecture(i, conj);
			}
		}
		alias cond = (a,b) => abs(a[0] - a[1]) < abs(b[0] - b[1]);
		pairs.sort!cond;
		return pairs[0];
	}
	void invoke()
	{
		uint n = 0;
		while ((n = dumbRead!uint) != 0)
		{
			auto r = n.goldbach;
			writeln(r[0], " + ", r[1], " = ", n);
		}
	}
}

version(prob10)
{
	string decode(string s)
	{
		char[] lookup = [s[0]];
		while (lookup.length != s.length)
		{
			lookup ~= cast(char)0;
		}
		string decoded = [s[0]];
		char current = s[0];
		uint index = 0;
		while (decoded.length != s.length)
		{
			// calculate the jump distance
			version(unittest) decoded.writeln;
			version(unittest) writeln(cast(ubyte[])lookup);
			uint jump = cast(uint)(current.toUpper) - 0x40;
			if ([current].match(regex("[^a-zA-z]", "g")))
				jump = 1;
			version(unittest) jump.writeln;
			while (jump > 0)
			{
				index = (index + 1) % s.length;
				if (cast(uint)lookup[index] == 0) // empty spot
					jump--;
			}

			current = s[index];
			lookup[index] = current; // 0 is never used, might break?
			decoded ~= current;
		}
		return cast(string)decoded;
	}
	unittest
	{
		assert(decode("Do Tee!iscdh") == "Decode This!");
		assert(decode("Yotei! mcgaeos'rued a drn") == "You're a decoding master!");
	}
	
	void invoke()
	{
		string ln;
		while ((ln = readln.strip) != "0")
		{
			decode(ln[ln.indexOf(" ")+1..$]).writeln;
		}
	}
}

version(prob11)
{
	int lowest(int[] divisors, int[] remainders)
	{
		for(int i = 0; i < 1_000_000; i++)
		{
			bool aligned = true;
			for(int j = 0; j < divisors.length; j++)
			{
				if (i % divisors[j] != remainders[j])
					aligned = false;
			}
			if (aligned)
			{
				i.writeln;
				return i;
			}
		}
		return -1;
	}
	unittest
	{
		assert(lowest([3, 5, 7], [2, 0, 6]) == 20);
		assert(lowest([127, 541, 59], [17, 120, 15]) == 999_888);
	}
}

version(prob12)
{
	
}



























































version(unittest)
{

}
else
{
	void main()
	{
		invoke();
	}
}