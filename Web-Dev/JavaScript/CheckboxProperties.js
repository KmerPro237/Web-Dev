document.getElementById("submitButton").onclick = function() {      
    const myCheckBox = document.getElementById("myCheckBox");
    const visaButton = document.getElementById("visaButton");
    const masterCardButton = document.getElementById("masterCardButton");
    const americanExpressButton = document.getElementById("americanExpressButton");
    const payPalButton = document.getElementById("payPalButton");

    if (myCheckBox.checked) {
       console.log("Congratulations! You have now subscribed to our newsletter!");
    } else {
         console.log("You have not subscribed to our newsletter. Please check the box to subscribe.");
     } 

     if(visaButton.checked) {
        console.log("You have selected Visa as your payment method.");
     } else if (masterCardButton.checked) {         
        console.log("You have selected MasterCard as your payment method.");
     } else if (americanExpressButton.checked) {
        console.log("You have selected American Express as your payment method.");
     } else if (payPalButton.checked) {
        console.log("You have selected PayPal as your payment method.");
     } else {
        console.log("Please select a payment method.");
     }
}