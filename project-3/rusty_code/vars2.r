// no errors in this


fn main ( ) {
	print("104 = ");
	let a = 99 + 5;
	print(a);
	{ let a = 2;  print(" 2 = ");  print(a);};
	let mut b = 10* (11-1);
	b = b + 1;
	{ let b = 12;
	    { let a = 42; print(" 42 = ");   print(a); };
	    print("  12 = ");  print(b);
	};
	print("   101 = ");
	print(b);
	print(" 104 = ");
	print(a);
}

