document.addEventListener('DOMContentLoaded', function () {
    AdicionarEventos();
});

function AdicionarEventos() {
    /*
    * Atrelar os eventos da página   
    * A tabela terá os seguintes eventos:
    *   - Limpar campos
    *   - Cadastrar usuário
    *   - Editar Usuário
    *   - Carregar o combo de estados    
    */
    $selEstados = document.getElementById("selEstados");
    $btnCadastrar = document.getElementById("btnCadastrar");
    $btnAlterar = document.getElementById("btnAlterar");
    $btnNovo = document.getElementById("btnNovo");
    $selEstados.addEventListener("focusin", function () {
        BuscarEstados($selEstados);
    });

    $btnCadastrar.addEventListener("click", function (e) {
        CadastrarUsuario(e);
    });

    $btnAlterar.addEventListener("click", function () {
        //EditarUsuario(e);
    });

    $btnNovo.addEventListener("click", function () {
        //NovoUsuario(e);
    });

}


/**
 * Busca os estados no banco de dados e preenche o select com esses valores
 * 
 * @param {HTMLSelectElement} idElemento 
 */
function BuscarEstados(idElemento) {
    if (!idElemento) {
        return false;
    }
    return $.ajax({
        url: "../Servidor/Controllers/estado.asp?fnTarget=BuscarEstados",
        type: 'GET',
        contentType: 'application/json',
        success: function (data) {
            var estados = data['Registros'];
            for (var i = 0; i < estados.length; i++) {
                var opt = document.createElement('option');
                opt.innerHTML = estados[i]['Nome'];
                opt.value = estados[i]['Id'];
                idElemento.appendChild(opt);
            }
        }
    });
}
function CapturaCamposFormulario(formularioHtml) {
    var n = 0;
    var objRetorno = {};
    while (formularioHtml[n]) {
        var campo = formularioHtml[n];
        objRetorno[campo.name] = campo.value === "" ? null : campo.value;
        n++;
    }
    return objRetorno;
}
function CadastrarUsuario(e) {
    /*
    * Lógica para cadastrar um usuario
    */
    var usuario = CapturaCamposFormulario(e.currentTarget.form);
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
            PreencheTabela(data);
        },
        error: function (xhr, status, error) {
            alert("Erro: " + xhr + status + error);
        }
    });
}


/**
 * Retorna os dados de um usuario pelo Id e preenche o formulário
 * 
 * @param {number} idUser 
 */
function buscaDados(idUser) {
    if (!idUser) {
        return false;
    }
    var formularioHtml = document.getElementById('frmUser');
    // TODO - Melhorar a forma de construção da url 
    return $.ajax({
        url: "./AspPages/user.asp?usuid=" + idUser + "&acao=Editar",
        data: "",
        type: 'GET',
        contentType: 'application/json',
        success: function (data) {
            setFormCampos(formularioHtml, JSON.parse(data));
        }
    });
}


/**
 *
 * Preenche um formulário com o objeto JSON, e retorna o próprio formulário
 *
 * @author Lino Pegoretti
 * @param {formularioHtml} formularioHtml
 * @param {JSON} prJSON
 * @returns {formularioHtml}
 */
function setFormCampos(formularioHtml, prJSON) {
    var n = 0;
    while (formularioHtml[n]) {
        var txtNome = formularioHtml[n].name;
        formularioHtml[n].value = prJSON[txtNome] || '';
        n++;
    }
    return formularioHtml;
}