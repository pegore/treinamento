$( document ).ready(function() {
    
  });

function validateForm() {
    var usuario = document.forms["fromLogon"]["txtUsuario"].value;
    var senha = document.forms["fromLogon"]["pwdSenha"].value;
    if (usuario == "") {
        alert("Name must be filled out");
        return false;
    }
}