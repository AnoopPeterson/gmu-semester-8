// no errors in this


fn main ( ) {
	let  a = read();
	let b = read();
	let c = read();
	print(a);   print (b); print(c);
	print("Max: ");
	let max = if (a > b) {
		if (a > c)  {a; }
		else { c;  };
	} else {
		if (b > c) {b; }
		else { c; };
	} ;
	print(max);
}

