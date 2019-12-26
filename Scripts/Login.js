$(document).ready(function () {
    AdicionarEventos();
});

function AdicionarEventos() {
    // Atrelar os eventos da página    
    $btnLogin = document.getElementById("btnLogin");
    $btnLogin.addEventListener("click", function () {
        $txtUsuario = document.getElementById("txtUsuario").value;
        $pwdSenha = document.getElementById("pwdSenha").value;
        if (!validaForm($txtUsuario, $pwdSenha)) {
            return false;
        };
        fazerLogin($txtUsuario, $pwdSenha);
    });
}

function validaForm(usuario, senha) {
    if (!usuario || !senha) {
        alert('Preencha os campos');
        return false
    }
    return true;
}
function fazerLogin(usuario, senha) {
    if (!usuario || !senha) {
        alert('Preencha os campos');
        return false
    };
    data = {
        "usuario": usuario,
        "senha": senha
    };
    return $.ajax({
        url: "./AspPages/Login.asp",
        type: 'POST',
        data: data,
        success: function (data) {
            alert(data);
            window.location.replace("./Index.html");
        },
        error: function (xhr, status, error) {
            alert("Erro: " + error.Message);
        }
    });
}