document.addEventListener('DOMContentLoaded', function () {
    AdicionarEventos();
});

function AdicionarEventos() {
    var $usuario = document.getElementById("txtUsuario");
    var $senha = document.getElementById("pwdSenha");
    var $btnLogin = document.getElementById("btnLogin");
    $usuario.addEventListener('focusout', function (e) {
        if ($usuario.value == "") {
            mostraAlerta("Preencha o campo usuário!!!");
            $usuario.focus();
        }
    });
    $senha.addEventListener('focusout', function (e) {
        if ($senha.value == "") {
            mostraAlerta("Preencha o campo senha!!!");
            $senha.focus();
        }
    });
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
        return false;
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
    return $.ajax({
        url: "../Servidor/Controllers/login.asp",
        type: 'POST',
        data: data,
        success: function(data){
            ValidaLogin(data);
        },
        error: function(xhr, status, error){
            MostraErro(xhr, status, error);
        }
    });
}

function MostraErro(xhr, status, error) {
    alert("XHR: " + xhr + "\r\nstatus: " + status + "\r\nerror: " + error);
}

function ValidaLogin(data) {
    var retorno = JSON.parse(data);
    if (retorno.logado) {
        // TODO Verificar como colocar os dados na sessão do usuário        
        alert("Logado com sucesso");
        window.location.replace("./Principal.asp");
    } else {
        alert("erro no login");
    }
}

function mostraAlerta(mensagem) {
    var $alerta = document.getElementById("divAlerta");
    $alerta.innerHTML = mensagem;
    $alerta.classList.add('alerta-show');
    setTimeout(function () {
        $alerta.className = $alerta.className.replace("alerta-show", "");
    }, 3000);
}
