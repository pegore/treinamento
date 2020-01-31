const url = "../Servidor/Controllers/user.asp";
document.addEventListener('DOMContentLoaded', function () {
    var queryString = window.location.search;
    var urlParams = new URLSearchParams(queryString);
    var usuid = urlParams.get('UsuId');
    AdicionarEventos(usuid);
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
    $selEstado = document.getElementById("selEstado");
    $btnCadastrar = document.getElementById("btnCadastrar");
    $btnAlterar = document.getElementById("btnAlterar");
    $btnExcluir = document.getElementById("btnExcluir");
    $btnNovo = document.getElementById("btnNovo");
    BuscarEstados($selEstado);
    $btnNovo.addEventListener("click", function () {
        window.location.href = 'usuarioCadastro.asp';
    });
    if (!usuid) {
        $btnExcluir.remove();
        $btnAlterar.remove();
        $btnCadastrar.classList.toggle('col-6');
        $btnNovo.classList.toggle('col-6');
        $btnCadastrar.addEventListener("click", function (e) {
            SalvarUsuario(e);
        });
        return;
    }
    $btnCadastrar.remove();
    $btnAlterar.addEventListener("click", function (e) {
        SalvarUsuario(e, usuid);
    });

    $btnExcluir.addEventListener("click", function (e) {
        ExcluirUsuario(usuid);
    });
    PreencherDadosUsuario(usuid);
}

/**
 * Busca os estados no banco de dados e preenche o select com esses valores
 * 
 * @author Lino Pegoretti
 * @param {HTMLSelectElement} elemento
 * @returns {HTMLOptionElement} 
 */
function BuscarEstados(elemento) {
    if (!elemento) {
        return;
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
            for (var i = 0; i < estados.length; i++) {
                var opt = document.createElement('option');
                opt.innerHTML = estados[i]['Nome'];
                opt.value = estados[i]['Id'];
                elemento.appendChild(opt);
            }
        }
    });
}

/**
 * Salva(Insere ou edita) um usuário no servidor e retorna o identificador desse cadastro
 *
 * @author Lino Pegoretti
 * @param {Event} event
 * @returns {Object} 
 */
function SalvarUsuario(event, usuid) {
    var usuario = CapturaCamposFormulario(event.currentTarget.form);
    if (!UsuarioValido(usuario)) {
        alert('Usuario invalido');
        return;
    }
    var usuid = usuid || 0;
    data = {
        fnTarget: "SalvarUsuario",
        usuid: usuid,
        usuario: usuario.txtUsuario,
        senha: usuario.pwdSenha,
        nome: usuario.txtNome,
        endereco: usuario.txtEndereco,
        cidade: usuario.txtCidade,
        cep: usuario.txtCep,
        estado: usuario.selEstado
    }
    return $.ajax({
        url: url,
        type: 'POST',
        data: data,
        success: function (data) {
            if (data.Erro) {
                alert("Erro: " + data.Erro);
            }
            window.location.href = 'usuarioCadastro.asp?UsuId=' + data.UsuId;
        },
        error: function (xhr, status, error) {
            alert("Erro: " + xhr + status + error);
        }
    });
}


/**
 * Exclue um usuário no servidor
 * 
 * @author Lino Pegoretti
 * @param {Event} event 
 * @returns {object}
 */
function ExcluirUsuario(usuid) {
    data = {
        fnTarget: "ExcluirUsuario",
        usuid: usuid
    }
    return $.ajax({
        url: "../Servidor/Controllers/user.asp",
        type: 'POST',
        data: data,
        success: function (data) {
            if (data.Erro) {
                alert("Erro: " + data.Erro);
            }
            if (data.RegistrosAfetados) {
                alert("Foram Excluídos " + data.RegistrosAfetados + " usuários do banco de dados");
            }
            window.location.href = "usuarioTabela.asp";
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
    return $.ajax({
        url: "../Servidor/Controllers/user.asp",
        type: 'GET',
        contentType: 'application/json',
        data: {
            fnTarget: "BuscarUsuarioPorId",
            usuId: usuId
        },
        success: function (data) {
            PreencheCamposFormulario(document.getElementById("frmUser"), data);
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
    for (var i = 0; i < formularioHtml.elements.length; i++) {   
        var txtNome = formularioHtml[i].name;
        formularioHtml[i].value = prJSON[txtNome] || '';
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
    var objRetorno = {};
    for (var i = 0; i < formularioHtml.elements.length; i++) {
        var campo = formularioHtml[i];
        if (campo.name != "") {
            objRetorno[campo.name] = campo.value === "" ? null : campo.value;
        }
    }
    return objRetorno;
}
/**
 * Função para validar os campso do usuário antes de salvar
 * 
 * @param {Object} usuario 
 */
function UsuarioValido(usuario) {
    for (var campo in usuario) {
        if (usuario.hasOwnProperty(campo) && usuario[campo] == null) {
            return false;
        }
    }
    return true;
}
