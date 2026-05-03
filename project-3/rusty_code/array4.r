fn readarray(a: i32[], size: i32) {
	let mut i = 0;
	while (i < 10) {
		let x = read(); print(x);
		a[i]=x;
		i = i + 1;
	};
}

fn writearray(a: i32[], size: i32) {
	let mut i = 0;
	while (i < 10) {
		print(a[i]);
		i = i + 1;
	};
}

fn find_smallest(arr: i32[], start: i32, stop: i32) -> i32 {
	let mut small_index = start;
	let mut i = start+1;
	while (i <= stop) {
		small_index = if (arr[small_index] > arr[i]) {i;}
		             else {small_index;};
		i = i + 1;
	};   small_index;   // return 
}

fn swapelems(arr: i32[], e1: i32, e2:i32) {
	let t = arr[e1];
	arr[e1] = arr[e2];
	arr[e2] = t;
}

fn sortarray(arr :i32[], size: i32) {
	let mut i = 0;
	let last_elem = size -1;
	while (i < (size)) {
		let small = find_smallest(arr,i,last_elem);
		swapelems(arr,i,small);
		i = i + 1;
	};
}

fn main() {
	let mut a [i32; 10] = 0;
	let mut i = 0;
	print("Unsorted:   ");
	readarray(a,10);
	sortarray(a,10);
	print("\nSorted:   ");
	writearray(a,10);

}
