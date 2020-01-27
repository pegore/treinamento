const url = "../Servidor/Controllers/tarefa.asp";

document.addEventListener('DOMContentLoaded', function () {
    var queryString = window.location.search;
    var urlParams = new URLSearchParams(queryString);
    var idTarefa = urlParams.get('IdTarefa');
    AdicionarEventos(idTarefa);
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
 * @param {Number} idTarefa
 */
function AdicionarEventos(idTarefa) {
    $selGerador = document.getElementById("selGerador");
    $btnCadastrar = document.getElementById("btnCadastrar");
    $btnAlterar = document.getElementById("btnAlterar");
    $btnExcluir = document.getElementById("btnExcluir");
    $btnNovo = document.getElementById("btnNovo");
    BuscarGeradores($selGerador);
    $btnNovo.addEventListener("click", function () {
        window.location.href = 'TabelaCadastro.asp';
    });
    if (!idTarefa) {
        $btnExcluir.remove();
        $btnAlterar.remove();
        $btnCadastrar.classList.toggle('col-6');
        $btnNovo.classList.toggle('col-6');
        $btnCadastrar.addEventListener("click", function (e) {
            CadastrarTarefa(e);
        });
        return;
    }
    $btnCadastrar.remove();
    $btnAlterar.addEventListener("click", function (e) {
        EditarTarefa(e, idTarefa);
    });
    $btnExcluir.addEventListener("click", function (e) {
        ExcluirTarefa(e, idTarefa);
    });
    PreencherDadosTarefa(idTarefa);
}

/**
 * Busca os estados no banco de dados e preenche o select com esses valores
 * 
 * @author Lino Pegoretti
 * @param {HTMLSelectElement} elemento
 * @returns {HTMLOptionElement} 
 */
function BuscarGeradores(elemento) {
    if (!elemento) {
        return false;
    }
    return $.ajax({
        url: "../Servidor/Controllers/user.asp",
        type: 'GET',
        contentType: 'application/json',
        data: {
            fnTarget: "BuscarGeradores"
        },
        success: function (data) {
            var geradores = data['Registros'];
            for (var i = 0; i < geradores.length; i++) {
                var opt = document.createElement('option');
                opt.innerHTML = geradores[i]['Nome'];
                opt.value = geradores[i]['UsuId'];
                elemento.appendChild(opt);
            }
        }
    });
}

/**
 * Cadastra uma tarefa no servidor e retorna o identificador desse cadastro
 *
 * @author Lino Pegoretti
 * @param {Event} event
 * @returns {Object} 
 */
function CadastrarTarefa(event) {
    var tarefa = CapturaCamposFormulario(event.currentTarget.form);
    data = {
        fnTarget: "CadastrarTarefa",
        Titulo: tarefa.txtTitulo,
        Gerador: tarefa.selGerador,
        DataGeracao: tarefa.txtDataGeracao,
        Status: tarefa.selStatus,
        Descricao: tarefa.txtDescricao
    }
    return $.ajax({
        url: url,
        type: 'POST',
        data: data,
        success: function (data) {
            if (data.Erro) {
                alert("Erro: " + data.Erro);
            }
            window.location.href = 'TarefaCadastro.asp?IdTarefa=' + data.IdTarefa;
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
function EditarTarefa(event, idTarefa) {
    // TODO - Fazer a validação dos dados antes de enviar ao servidor
    var tarefa = CapturaCamposFormulario(event.currentTarget.form);
    data = {
        fnTarget: "EditarTarefa",
        idTarefa: idTarefa,
        Titulo: tarefa.txtTitulo,
        Gerador: tarefa.selGerador,
        DataGeracao: tarefa.txtDataGeracao,
        Status: tarefa.selStatus,
        Descricao: tarefa.txtDescricao
    }
    return $.ajax({
        url: url,
        type: 'POST',
        data: data,
        success: function (data) {
            if (data.Erro) {
                alert("Erro: " + data.Erro);
            }
            window.location.href = 'TarefaCadastro.asp?IdTarefa=' + data.IdTarefa;
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
function ExcluirTarefa(event, IdTarefa) {
    data = {
        fnTarget: "ExcluirTarefa",
        IdTarefa: IdTarefa
    }
    return $.ajax({
        url: url,
        type: 'POST',
        data: data,
        success: function (data) {
            if (data.Erro) {
                alert("Erro: " + data.Erro);
            }
            if (data.RegistrosAfetados) {
                alert("Foram Excluídos " + data.RegistrosAfetados + " usuários do banco de dados");
            }
            window.location.href = "TarefaTabela.asp";
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
 * @param {number} idTarefa
 * @returns {object} 
 */
function PreencherDadosTarefa(idTarefa) {
    if (!idTarefa) {
        return false;
    }
    return $.ajax({
        url: url,
        type: 'GET',
        contentType: 'application/json',
        data: {
            fnTarget: "BuscarTarefaPorId",
            idTarefa: idTarefa
        },
        success: function (data) {
            PreencheCamposFormulario(document.getElementById("frmTarefa"), data);
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