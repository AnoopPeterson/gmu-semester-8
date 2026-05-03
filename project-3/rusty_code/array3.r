fn fun2(a: i32[]) {
	a[3] = 6;
}

fn fun1(a: i32[]) {
	fun2 (a);
}

fn main() {
	let mut a [i32; 10] = 0;
        fun1(a);
	print(a[3]);
}
