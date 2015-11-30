// validates sign up
function valSignUp() 
{
    var a = false;
    $("#signupalert").hide();
    $("#signupalert").html("");
    if ($("#tbEmployeeId").val().length == 0) {
        $("#signupalert").append("Enter Employee Id<br>");
        a = true;
    }
    if ($("#tbFirstName").val().length == 0) {
        $("#signupalert").append("Enter First Name<br>");
        a = true;
    }
    if ($("#tbLastName").val().length == 0) {
        $("#signupalert").append("Enter Last Name<br>");
        a = true;
    }
    if ($("#tbPassword").val().length == 0) {
        $("#signupalert").append("Enter Password<br>");
        a = true;
    }
    if ($("#tbConfPassword").val().length == 0) {
        $("#signupalert").append("Enter Confirm Password<br>");
        a = true;
    }
    if ($("#tbEmailId").val().length == 0) {
        $("#signupalert").append("Enter Email ID<br>");
        a = true;
    }
    if (($("#tbPassword").val().length > 0) && ($("#tbConfPassword").val().length > 0)) {
        if ($("#tbPassword").val() != $("#tbConfPassword").val()) {
            $("#signupalert").append("Password and Confirm Password do not match<br>");
            a = true;
        }
    }

    if (a == true) {
        $("#signupalert").removeClass("alert-success");
        $("#signupalert").addClass("alert-danger");
        $("#signupalert").show();
        return false;
    }
    else {
        return true;
    }
}

//validates login
function valLogin()
{
    var a = false;
    $("#loginAlert").hide();
    $("#loginAlert").html("");
    if ($("#tbLoginUserName").val().length == 0) {
        $("#loginAlert").append("Enter Employee Id<br>");
        a = true;
    }
    if ($("#tbLoginPassword").val().length == 0) {
        $("#loginAlert").append("Enter Password<br>");
        a = true;
    }
    
    if (a == true) {
        $("#loginAlert").removeClass("alert-success");
        $("#loginAlert").addClass("alert-danger");
        $("#loginAlert").show();
        return false;
    }
    else {
        return true;
    }
}