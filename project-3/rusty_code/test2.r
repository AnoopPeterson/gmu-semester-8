
fn incr(a: i32) -> i32 { a+1;}

fn sum (a: i32, b: i32) -> i32 {
	if (a>0) {   
		sum(a+1,b); incr(b);
	} else { 0;};  

}

fn test (a: i32, b:i32 ) -> i32 { 
	if (b!= 2 ) {
		print(b);
	} else  { print(b); };
	a;
}

fn main ( ) {
	let mut a = 2 + 2 ; 
	{
	let a = test(a,a) + a; 
	print(test(2+3,5));
	};
}



