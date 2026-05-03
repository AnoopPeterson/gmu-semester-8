// no errors in this


fn test (x: i32, y:i32 ) -> i32 {
	 let a = x + 1;
	 a*y;
}

fn middle(x: i32, y:i32) -> i32 {
	test(x,y);
}

fn main() {
	print("86 = ");
	print(middle(42,2)); 
	print("  33 = ");
	print(middle(10,3));
}

