
function reverseString(string){
	var arr = [];
	var j   = -1; 
	for (var i=string.length-1; i>-1; i--){
		j++; 
		arr[j]=string[i];
	}
	console.log(string); 
	console.log(arr.join('')); 
}

var str = 'ABCDEFG'; 

reverseString(str);

