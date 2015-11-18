//<!Eden Cox>
//<Software Engineering>
//<!this is my login.js file that applies checks to the login information>

//----this function checks the first and last name of the form
//it makes sure the length is not more than 15 and that the first
//and last name start with a capital letter followed by a lowercase
function checkName()  // mandatory field, < 255 , error message inside alert
{

    $("#signupalert").html("Invalid Name");
    $("#signupalert").removeClass("alert-success");
    $("#signupalert").addClass("alert-danger");

    $("#signupalert").show(); // hide(); - hide the div//
    //change the css class to alert-success in case of successful validations, and set it to alert-danger in case of failed validations
    return false; // restricts the page submission - return true- would submit the page

}
//--this function checks to see if the username begins with a letter
//and is followed by any combination of numbers, letters, or periods
//as long as it's length is between 5 and 10 characters
function checkEmpId(event) {

    var username = event.currentTarget;
    var pos = username.value.search(/^([A-Z]|[a-z])/);

    //checks if username is the right length
    if (username.value.length > 10 || username.value.length < 5) {
        alert("The password you entered must be greater than 5 characters" +
            " and less than 10. ");
    }

    //checks if username starts with a letter
    if (pos != 0) {
        alert("The name you entered was not in the correct form.\n" +
            "You must start your username with a letter. \n" +
            " Please fix your username.");
    }

}

//this function checks the passwords to make sure it has at least 6 
//characters/numbers. if not correct pops up a message
function checkPassword(event) {

    var password = event.currentTarget;
    var pos = password.value.search(/^(?=.*\d)(?=.*[a-z])[0-9a-zA-Z]{6,}$/i);
    if (pos !=0) {
        alert("Your password must be at least 6 characters long. \n" +
            "It must contain at least one letter and one number. \n" +
            "Please fix your password.");
    }

    
}

//this function checks the password to make sure it matches the first one
//if not matched, displays error message and focuses
function checkPassword2() {
    
    var pass1 = document.getElementById('password');
    var pass2 = document.getElementById('password2');

    if (pass1.value == "") {
        alert("You did not enter a password \n" +
              "Please enter one now");
        document.getElementById("password2").focus();
        return false;
    }
    if (pass1.value != pass2.value) {
        alert("The two passwords you entered are not the same \n" +
              "Please re-enter both now");
        document.getElementById("password2").focus();
        return false;
    } else
        return true;
}


//---this function makes sure the phone number is correct
function checkPhone(event) {
    var myPhone = event.currentTarget;

   
    var pos = myPhone.value.search(/^\(?([0-9]{3})\)?\s ?([0-9]{3})-([0-9]{4})$/);
   
    if (pos != 0) {
        alert("The number you entered is not in the correct form. \n" +
            "The correct form is: ddd ddd-dddd \n" + "Or: (ddd) ddd-dddd \n" +
            "Please fix your phone number.");
    }    
 
}
// this function checks the email.
function checkEmail(event) {

    var email = event.currentTarget;
   
    var pos = email.value.search(/^([A-Z])([A-Z]|[0-9]|.)*(@mtsu.edu|@mtmail.mtsu.edu)$/i);

    if (pos != 0) {
        alert("The email address you have entered is not in the correct form. \n" +
            "It must be in the form: person@mtmail.mtsu.edu \n" +
            " Or: person@mtsu.edu. Please fix your email.");
    }
}