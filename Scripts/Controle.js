
/**
 *
 * comunicação com o server via ajax
 *
 * @author Lino Pegoretti
 * @param {String}
 *            prUrl
 * @param {String}
 *            prMethod
 * @param {Object}
 *            prDados
 * @param {Function}
 *            prDoneCallBack
 * @param {Function}
 *            prFailCallBack
 * @returns {jqXHR}
 */
function enviarAjax(prUrl, prMethod, prDados, prDoneCallBack, prFailCallBack) {
    debugger;
	var prUrl = prUrl || '';
	var prMethod = prMethod || 'GET';
	var prDados = prMethod != 'GET' ? JSON.stringify(prDados) : '';
	var prDoneCallBack = prDoneCallBack || ((resultado) => {
		alert('Requisição enviada com sucesso para a URI: ' + prURL);
		console.log(resultado);
	});
	var prFailCallBack = prFailCallBack || ((resultado) => {
		alert('URI não encontrada: ' + prURL);
		console.error(resultado);
	});
	return $.ajax({
		url: prUrl,
		type: prMethod.toUpperCase(),
		headers: {
			'Accept': 'application/json',
			'Content-Type': 'application/json',
			'Cache-Control': 'no-cache',
			'X-Requested-With': 'XMLHttpRequest',
			'Access-Control-Allow-Origin': '*',
			'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
			'Access-Control-Allow-Headers': 'Content-Type, Accept',
			'Access-Control-Max-Age': '1'
		},
		dataType: 'json',
		crossDomain: false,
		data: prDados,
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
	}).done(prDoneCallBack).fail(prFailCallBack);
}