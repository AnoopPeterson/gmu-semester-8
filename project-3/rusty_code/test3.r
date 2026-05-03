fn test (a: i32, b:i32 ) -> i32 { 
	if (true || false) { 
		print(b); let c = 5; c;
        } else { print(b);
	         let c = 6; c;
        };
		a;
}

fn whilefn(a: i32, b: i32, c:i32) -> i32 {
	if (a * b > 1) { 
	if (a - c < 0) {a; }
	else {c;};

     }	else {if (b % c == 2) {b;} else {c;};
     };
}


fn main ( ) {
	let mut a = 2 + 2 ; let a = test(5,22+9) + a; print(test(2,a+a+a));
	whilefn(a,a,3);
}


