let x = 3.65;
let p = 2.2;

x = Math.round(x);
let y = Math.floor(2);
let z = Math.ceil(x);

console.log(x);
console.log(y);
console.log(z);

x = Math.pow(2, 3);
console.log(x);
x = Math.sqrt(9);
console.log(x);

s = Math.random();
console.log(s);

s = s**2;
console.log(s);
console.log(Math.abs(-5));

q = Math.max(1, 2, 3, 4, 5, 6, 7, 8, 9);
console.log(q);

q = Math.min(1, 2, 3, 4, 5, 6, 7, 8, 9);
console.log(q);

d = Math.fround(3.65);
console.log(d);

// Find hypothenuse of a triangle

let a, b, c;

a = window.prompt("Enter the length of side a: ");
a = Number(a);

b = window.prompt("Enter the length of side a: ");
b = Number(b);

c = Math.sqrt(a**2 + b**2);
console.log("The length of the hypothenuse is: ", c);

document.getElementById("calcBtn").onclick = function() { 
    let a, b, c;

    a = document.getElementById("ATextBox").value;
    a = Number(a);

    b = document.getElementById("BTextBox").value;
    b = Number(b);

    c = Math.sqrt(a**2 + b**2);
    //console.log("The length of the hypothenuse is: ", c);
    document.getElementById("lblC").innerHTML = "The length of the hypothenuse is: " + c;
}