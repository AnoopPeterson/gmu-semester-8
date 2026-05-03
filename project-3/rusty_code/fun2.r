// no errors in this

fn test1(a: i32) {
	print(a);
}


fn test (x: i32, y:i32 ) {
	 print(x);
	test1(x*y);
}


fn main() {
	test(42,2); test(64,3);
}

