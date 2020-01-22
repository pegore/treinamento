document.addEventListener('DOMContentLoaded', function () {
    var queryString = window.location.search;
    var urlParams = new URLSearchParams(queryString);
    var usuid = urlParams.get('UsuId');
    AdicionarEventos(usuid);
    PreencherDadosUsuario(usuid);
    BuscarEstados($selEstados);
});

/**
 * Vincula os eventos da página as ações correspondentes
 *      - Botão Cadastrar: Cadastrar usuário
 *      - Botão Editar: Editar Usuário
 *      - Botão Novo : Limpa o formulário para novo preenchimento
 *      - Carrega o combo de estados na inicialização da página
 *      - Carrega os dados de um usuário quando entra na página se o id estiver na url
 * 
 * @author Lino Pegoretti
 * @param {Number} usuid
 */
function AdicionarEventos(usuid) {
    // TODO - Verificar os eventos do select e
    $selEstados = document.getElementById("selEstados");
    $btnCadastrar = document.getElementById("btnCadastrar");
    $btnAlterar = document.getElementById("btnAlterar");
    $btnNovo = document.getElementById("btnNovo");

    $btnCadastrar.addEventListener("click", function (e) {
        CadastrarUsuario(e);
    });

    $btnAlterar.addEventListener("click", function (e) {
        EditarUsuario(e, usuid);
    });

    $btnNovo.addEventListener("click", function () {
        //NovoUsuario(e);
    });

    $selEstados.addEventListener("load", function () {
        BuscarEstados($selEstados);
    });

    document.addEventListener("load", function (e) {
        PreencherDadosUsuario(usuid);
    });
}

/**
 * Busca os estados no banco de dados e preenche o select com esses valores
 * 
 * @author Lino Pegoretti
 * @param {HTMLSelectElement} idElemento
 * @returns {HTMLOptionElement} 
 */
function BuscarEstados(idElemento) {
    if (!idElemento) {
        return false;
    }
    return $.ajax({
        url: "../Servidor/Controllers/estado.asp",
        type: 'GET',
        contentType: 'application/json',
        data: {
            fnTarget: "BuscarEstados"
        },
        success: function (data) {
            var estados = data['Registros'];
            // var opt = document.createElement('option');
            // opt.innerHTML = "Selecione Estado";
            // opt.value = 0;
            // idElemento.appendChild(opt);
            for (var i = 0; i < estados.length; i++) {
                var opt = document.createElement('option');
                opt.innerHTML = estados[i]['Nome'];
                opt.value = estados[i]['Id'];
                idElemento.appendChild(opt);
            }
        }
    });
}
/**
 * Cadastra um usuário no servidor e retorna o identificador desse cadastro
 *
 * @author Lino Pegoretti
 * @param {Event} event
 * @returns {Object} 
 */
function CadastrarUsuario(event) {
    /*
    * Lógica para cadastrar um usuario
    */
    var usuario = CapturaCamposFormulario(event.currentTarget.form);
    data = {
        fnTarget: "CadastrarUsuario",
        usuario: usuario.txtUsuario,
        senha: usuario.pwdSenha,
        nome: usuario.txtNome,
        endereco: usuario.txtEndereco,
        cidade: usuario.txtCidade,
        cep: usuario.txtCep,
        estado: usuario.selEstados
    }
    return $.ajax({
        url: "../Servidor/Controllers/user.asp",
        type: 'POST',
        data: data,
        success: function (data) {
            debugger;
            if (data.Erro) {
                alert("Erro: " + data.Erro);
            }
            PreencheCamposFormulario(document.getElementById("frmUser"), {});
            PreencherDadosUsuario(data.UsuId);
        },
        error: function (xhr, status, error) {
            alert("Erro: " + xhr + status + error);
        }
    });
}

/**
 * Edita um usuário no servidor e retorna o identificador desse cadastro
 * 
 * @author Lino Pegoretti
 * @param {Event} event 
 * @returns {object}
 */
function EditarUsuario(event, usuid) {
    // TODO - Fazer a validação dos dados antes de enviar ao servidor
    debugger
    var usuario = CapturaCamposFormulario(event.currentTarget.form);
    data = {
        fnTarget: "EditarUsuario",
        usuid: usuid,
        usuario: usuario.txtUsuario,
        senha: usuario.pwdSenha,
        nome: usuario.txtNome,
        endereco: usuario.txtEndereco,
        cidade: usuario.txtCidade,
        cep: usuario.txtCep,
        estado: usuario.selEstados
    }
    return $.ajax({
        url: "../Servidor/Controllers/user.asp",
        type: 'POST',
        data: data,
        success: function (data) {
            debugger;
            if (data.Erro) {
                alert("Erro: " + data.Erro);
            }
            PreencheCamposFormulario(document.getElementById("frmUser"), {});
            PreencherDadosUsuario(data.UsuId);
        },
        error: function (xhr, status, error) {
            alert("Erro: " + xhr + status + error);
        }
    });
}

/**
 * Retorna os dados de um usuario pelo Id e preenche o formulário
 * 
 * @author Lino Pegoretti
 * @param {number} usuId
 * @returns {object} 
 */
function PreencherDadosUsuario(usuId) {
    if (!usuId) {
        return false;
    }
    var formularioHtml = document.getElementById("frmUser");
    return $.ajax({
        url: "../Servidor/Controllers/user.asp",
        type: 'GET',
        contentType: 'application/json',
        data: {
            fnTarget: "BuscarUsuarioPorId",
            usuId: usuId
        },
        success: function (data) {
            PreencheCamposFormulario(formularioHtml, data);
        },
        error: function (xhr, status, error) {
            alert("Erro: " + xhr + status + error);
        }
    });
}

/**
 * Preenche um formulário com o objeto JSON, e retorna o próprio formulário
 *
 * @author Lino Pegoretti
 * @param {HTMLFormElement} formularioHtml
 * @param {JSON} prJSON
 * @returns {HTMLFormElement}
 */
function PreencheCamposFormulario(formularioHtml, prJSON) {
    // TODO - Verificar uma melhor forma de pegar os campos, sugestões:
    //          - Deixar o id do jeito que está e colocar o name com o nome do objeto
    //          - Verificar outra forma de fazer o laço, utilizar for in  
    var n = 0;
    while (formularioHtml[n]) {
        var txtNome = formularioHtml[n].name;
        formularioHtml[n].value = prJSON[txtNome.substring(3)] || '';
        n++;
    }
    return formularioHtml;
}

/**
 * Captura os dados de um formulário HTML e retorna um objeto com os dados 
 * desse formulário
 * 
 * @author Lino Pegoretti
 * @param {HTMLFormElement} formularioHtml 
 * @returns {Object}
 *  
 */
function CapturaCamposFormulario(formularioHtml) {
    // TODO - Verificar uma melhor forma de pegar os campos, sugestões:
    //          - Deixar o id do jeito que está e colocar o name com o nome do objeto
    //          - Verificar outra forma de fazer o laço, utilizar for in  
    var n = 0;
    var objRetorno = {};
    while (formularioHtml[n]) {
        var campo = formularioHtml[n];
        objRetorno[campo.name] = campo.value === "" ? null : campo.value;
        n++;
    }
    return objRetorno;
}