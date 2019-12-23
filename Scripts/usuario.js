$(document).ready(function () {
    debugger;
    buscaEstados(document.getElementById('selEstados'));
    buscaDados(1);
});

function buscaEstados(idElemento) {
    if (!idElemento) {
        return false;
    }    
    return $.ajax({
        url: "./AspPages/estado.asp",
        type: 'GET',
        contentType: 'application/json',        
        success: function(data) {
            var d = JSON.parse(data);
            var estados = d['Estados'];
            for(var i = 0; i < estados.length; i++) {
                var opt = document.createElement('option');
                opt.innerHTML = estados[i]['Nome'];
                opt.value = estados[i]['Id'];
                idElemento.appendChild(opt);
            }      
        }
    });
}
function buscaDados(idUser) {
    debugger;
    if (!idUser) {
        return false;
    }
    var prForm= document.getElementById('frmUser');    
    return $.ajax({
        url: "./AspPages/user.asp?acao=Editar",
        type: 'GET',
        contentType: 'application/json',        
        success: function (prForm, data) {
            debugger;
            var n = 0;
            while (prForm[n]) {
                var txtNome = prForm[n].name;
                prForm[n].value = data[txtNome] || '';
                n++;
            }
            return prForm;
        }
    });
}
function preencheOptions(data) {
    var d = JSON.parse(data);
    var estados = d['Estados'];
    for(var i = 0; i < estados.length; i++) {
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
    debugger;
    var n = 0;
	while (prForm[n]) {
		var txtNome = prForm[n].name;
		prForm[n].value = prJSON[txtNome] || '';
		n++;
	}
	return prForm;
}