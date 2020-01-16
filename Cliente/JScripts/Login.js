document.addEventListener('DOMContentLoaded', function () {
    AdicionarEventos();
});

function AdicionarEventos() {
    // Atrelar os eventos da página   
    debugger; 
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
    if (!validaForm(usuario, senha)) {
        return false;
    };
    data = {
        "usuario": usuario,
        "senha": senha
    };
    debugger;
    return $.ajax({
        url: "./AspPages/Login.asp",
        type: 'POST',
        data: data,
        success: function (data) {
            alert(data);
            window.location.replace("./Index.html");
        },
        error: function (xhr, status, error) {
            alert("Erro: " + xhr + status + error);
        }
    });
}