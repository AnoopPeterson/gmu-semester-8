fn main ( ) {
	let mut a = 2 + 2 ; 
	{
	let a = test(a+a) + a; 
	println(test(2,3,5));
	}

}

fn incr(a: i32) -> i32 { a+1;}

fn sum (a: i32, b: i32) -> i32 {
	if (a) then {    // if a > 0 
		sum(a-1,b); incr(b);
	} 
}
fn test (a: i32, b:i32 ) -> i32 { 
	if (2 ) then 
		println(b);
	else 
	println(b);
	a;
}



