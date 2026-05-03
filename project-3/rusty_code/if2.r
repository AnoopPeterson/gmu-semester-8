// no errors in this


fn main ( ) {
	let  a = read();
	let b = read();
	let c = read();
	print(a);   print (b); print(c);
	print("Max: ");
	if (a > b) {
		if (a > c)  {print (a); }
		else { print(c);  };
	} else {
		if (b > c) {print(b); }
		else { print(c); };
	} ;
}

