fn main() {
	let mut a [i32; 10] = 0;
	let mut i = 0;
	while (i < 10) {
		let x = read(); print(x);
		a[i] = x;
		i = i+1;
	};
	print("\n");
	i = 0;
	while (i < 10) {
		print(a[i]);
		i = i+1;
	};

}
