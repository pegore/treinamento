(function () {
    debugger;
    verificarURL();
    adicionarEventos();
})();

function adicionarEventos() {
    var $usuario = document.getElementById("txtUsuario");
    var $senha = document.getElementById("pwdSenha");
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
    $alerta.className += " show";
    setTimeout(function () {
        $alerta.className = $alerta.className.replace("show", "");
    }, 3000);
}
