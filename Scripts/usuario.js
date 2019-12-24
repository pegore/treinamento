$(document).ready(function () {
    buscaEstados(document.getElementById('selEstados'));
    bindEvents();
});

function bindEvents(e) {
    // Atrelar os eventos dos botões
}


/**
 * Busca os estados no banco de dados e preenche o select com esses valores
 * 
 * @param {HTMLSelectElement} idElemento 
 */
function buscaEstados(idElemento) {
    if (!idElemento) {
        return false;
    }
    return $.ajax({
        url: "./AspPages/estado.asp",
        type: 'GET',
        contentType: 'application/json',
        success: function (data) {
            preencheOptions(idElemento, JSON.parse(data));
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
    var prForm = document.getElementById('frmUser');
    // TODO - Melhor a forma de construção da url 
    return $.ajax({
        url: "./AspPages/user.asp?usuid=" + idUser + "&acao=Editar",
        data: "",
        type: 'GET',
        contentType: 'application/json',
        success: function (data) {
            setFormCampos(prForm, JSON.parse(data));
        }
    });
}

/**
 * 
 * Preenche os options do elect de estados com os valores recebidos do banco
 * 
 * @param {HTMLForm} idElemento 
 * @param {Array} data 
 */
function preencheOptions(idElemento, data) {
    var estados = data['Estados'];
    for (var i = 0; i < estados.length; i++) {
        var opt = document.createElement('option');
        opt.innerHTML = estados[i]['Nome'];
        opt.value = estados[i]['Id'];
        idElemento.appendChild(opt);
    }
}

/**
 *
 * Preenche um formulário com o objeto JSON, e retorna o próprio formulário
 *
 * @author Lino Pegoretti
 * @param {HTMLForm} prForm
 * @param {JSON} prJSON
 * @returns {HTMLForm}
 */
function setFormCampos(prForm, prJSON) {
    var n = 0;
    while (prForm[n]) {
        var txtNome = prForm[n].name;
        prForm[n].value = prJSON[txtNome] || '';
        n++;
    }
    return prForm;
}