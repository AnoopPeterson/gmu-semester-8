fn readarray( arr: i32[], size:i32) {
	let mut i = 0;
	while (i < size) {
		let x = read();
		arr[i]= x;
		i = i+1;
	};
}

fn writearray( arr: i32[], size:i32) {
	let mut i = 0;
	while i < size {
		print(arr[i]); print(" ");
		i = i+1;
	};
}

fn find_smallest(arr: i32[], start: i32, stop: i32) -> i32 {
	let mut small_index = start;
	let mut i = start+1;
	while (i <= stop){
		small_index = 
				if (arr[small_index] > arr[i]) {i;}
		                  else {small_index;};
		i = i + 1;
	};
	small_index;    // returning that index of smallest element
}

fn swapelems(arr: i32[], e1: i32, e2: i32) {
	let t = arr[e1]; 
	arr[e1] = arr[e2];
	arr[e2] = t;
}
fn sortarray(arr: i32[], size:i32) {
	// selection sort
	let mut i = 0;
	while (i < (size-1)) {
		let small = find_smallest(arr,i,size-1);
		swapelems(arr,i,small);
		i = i + 1;
	};
}

fn main() {
	let mut a [i32 ; 10] = 0;   // array size 10 of 0 values
	readarray(a,10);
	sortarray(a,10);
	writearray(a,10);
}

