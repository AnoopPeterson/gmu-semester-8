// no errors in this


fn incr (x: i32, y:i32 ) -> i32 {
	let mut result = 0;
       if (x <= 0) {result = y;}
       else { result = y + incr(x-1,y);
 	};   result;       
}


fn main() {
	print (incr(42,2)); print(incr(64,3));
}

