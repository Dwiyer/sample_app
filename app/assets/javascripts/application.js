// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require_tree .
function validateForm(){
  var v_name=document.getElementById("user_name");
  var v_email=document.getElementById("user_email");
  var v_password=document.getElementById("user_password");
  var v_password_confirmation=document.getElementById        ("user_password_confirmation");
  var name=document.getElementById("user_name").value;
  var email=document.getElementById("user_email").value;
  var password=document.getElementById("user_password").value;
  var password_confirmation=document.getElementById("user_password_confirmation").value;
  if(!isUserName(name)){
    v_name.value="Not a valid username!";
    return false;

  }
  var atpos=email.indexOf("@");
  var dotpos=email.lastIndexOf(".");
  if (atpos<1 || dotpos<atpos+2 || dotpos+2>=email.length){
    v_email.value="Not a valid e-mail address";
    return false;
  }
  if(password.length<6||password.lenght>20){
    alert("Not a valid length password!");
    v_password.value="";
    return false;
  }
  if(password!=password_confirmation){
    alert("password not match!");
    v_password_confirmation.value="";
    return false;
  }
}

function isUserName(value){   
  var regu="^[0-9a-zA-Z\_]{6,20}$"
    var re=new RegExp(regu);
    if(re.test(value)){
      return true;
    }else{
      return false;
    }
} 
