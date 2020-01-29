/**
 *
 * Envia objeto json para o restful via ajax
 *
 * @author Lino Pegoretti
 * @param {String}
 *            url
 * @param {String}
 *            metodo
 * @param {Object}
 *            dados
 * @param {Function}
 *            funcaoSucesso
 * @param {Function}
 *            funcaoErro
 * @returns {jqXHR}
 */
function MontaRequisicaoAjax(url, metodo, dados, funcaoSucesso, funcaoErro) {
	debugger;
	var url = url || '';
	var metodo = metodo || 'GET';
	var dados = metodo != 'GET' ? JSON.stringify(dados) : '';
	var funcaoSucesso = funcaoSucesso || ((resultado) => {
		alert('Requisição enviada com sucesso para a URI: ' + url);
		console.log(resultado);
	});
	var funcaoErro = funcaoErro || ((resultado) => {
		alert('URI não encontrada: ' + url);
		console.error(resultado);
	});
	return $.ajax({
		url: url,
		type: metodo.toUpperCase(),
		headers: {
			'Accept': 'application/json',
			'Cache-Control': 'no-cache',
			'X-Requested-With': 'XMLHttpRequest',
			'Access-Control-Allow-Origin': '*',
			'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
			'Access-Control-Allow-Headers': 'Content-Type, Accept',
			'Access-Control-Max-Age': '1'
		},
		dataType: 'json',
		crossDomain: false,
		data: dados,
		statusCode: {
			200: () => {
				alert('200 - WebService encontrado, dados carregados');
			},
			404: () => {
				alert('404 - WebService não encontrado');
			},
			415: () => {
				alert('415 - Método não suportado');
			},
			500: () => {
				alert('500 - Ocorreu um erro interno');
			}
		}
	}).done(funcaoSucesso).fail(funcaoErro);
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
