$(document).ready(function () {
    debugger;
    buscaEstados(document.getElementById('selEstados'));
   buscaDados(20);
});

function buscaEstados(idElemento) {
    if (!idElemento) {
        return false;
    }
    return $.ajax({
        url: "./AspPages/estado.asp",
        type: 'GET',
        contentType: 'application/json',
        success: function (data) {
            preencheOptions(idElemento,JSON.parse(data));
        }
    });
}
function buscaDados(idUser) {
    if (!idUser) {
        return false;
    }
    var prForm = document.getElementById('frmUser');
    return $.ajax({
        url: "./AspPages/user.asp?usuid="+idUser+"&acao=Editar",
        data:"",
        type: 'GET',
        contentType: 'application/json',
        success: function (data) {
            setFormCampos(prForm, JSON.parse(data));
        }
    });
}
function preencheOptions(idElemento,data) {   
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
 * @param {HTMLForm}
 *            prForm
 * @param {JSON}
 *            prJSON
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