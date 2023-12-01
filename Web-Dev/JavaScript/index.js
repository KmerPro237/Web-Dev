// A variable is a container for storing data
// A variable behaves as if it was the value that it contains

// Two steps:
// 1. Declaration (var, let, const)
// 2. Assignment  (= assignment operator)

let firstName = "Bro"; //strings
let age = 21; //number
let student = true; //booleans

console.log("Hello", firstName);
console.log("You are", age, "years old");
console.log("Enrolled:", student);

//document.getElementById("p1").innerHTML = "Hello2 " + firstName;
//document.getElementById("p2").innerHTML = "You are " + age + " years old";
//document.getElementById("p3").innerHTML = "Enrolled: " + student;

// let vs var
function testVar() {
    if (true) {
      var x = 5;
      console.log("Value of var within block: ----> "+ x); // 5
    }
    console.log("Value of var outside block but same scope: ----> "+x); // 5 (var is function-scoped)
  }

  function testLet() {
    if (true) {
      let y = 10;
      console.log("Value of let within block: ----> " +y); // 10
    }
    console.log("Value of var within block: ----> " +y); // ReferenceError: y is not defined (let is block-scoped)
  }

  //console.log(testLet());
  console.log(testVar());

// type conversion = change the datatype of a value to another
//                                 (strings, numbers, booleans)

let userAge = window.prompt("How old are you?");

console.log(typeof userAge);
userAge = Number(userAge);
console.log(typeof userAge);
userAge += 1;

console.log("Happy Birthday! You are now", userAge, "years old");

/* chrome.runtime.onMessage.addListener(
    function(request, sender, sendResponse) {
      // Process the message
      console.log(request);
  
      // Send a response if needed
      sendResponse({ result: "Message received" });
    }
  );
  
  // Content script or popup script
  chrome.runtime.sendMessage({ data: "Hello from content script" }, function(response) {
    // Handle the response
    console.log(response);
  });
 */

