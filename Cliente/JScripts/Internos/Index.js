document.addEventListener('DOMContentLoaded', function () {
    debugger;
    AdicionarEventos();
});

function AdicionarEventos() { 
    debugger; 
    var $usuario = document.getElementById("txtUsuario");
    var $senha = document.getElementById("pwdSenha");
    $btnLogin = document.getElementById("btnLogin");
    $usuario.addEventListener('focusout', function (e) {
        debugger
        if ($usuario.value == "") {
            mostraAlerta("Preencha o campo usuário!!!");
            $usuario.focus();
        }
    });
    $senha.addEventListener('focusout', function (e) {
        debugger
        if ($senha.value == "") {
            mostraAlerta("Preencha o campo senha!!!");
            $senha.focus();
        }
    });   
    $btnLogin.addEventListener("click", function () {
        debugger
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
        url: "../Servidor/Controllers/login.asp",
        type: 'POST',
        data: data,
        success: function (data) {
            alert(data);
            window.location.replace("./Principal.asp");
        },
        error: function (xhr, status, error) {
            alert("Erro: " + xhr + status + error);
        }
    });
}

function verificarURL() {
    var url_string = window.location.href;
    var url = new URL(url_string);
    var login = url.searchParams.get("login");
    if (login == "vazio") {
        mostraAlerta("Preencha os campos corretamente!!!");
    };
}
function mostraAlerta(mensagem) {
    var $alerta = document.getElementById("divAlerta");
    $alerta.innerHTML = mensagem;
    $alerta.classList.add('alerta-show');
    setTimeout(function () {
        $alerta.className = $alerta.className.replace("alerta-show", "");
    }, 3000);
}
