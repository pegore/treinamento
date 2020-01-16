$(document).ready(function () {
    $btnPesquisaUsuario = document.getElementById("btnPesquisaUsuario");
    $btnPesquisaUsuario.addEventListener("click", e => BuscarUsuarios(e));
});


function BuscarUsuarios(e) {
    e.preventDefault();
    e.stopImmediatePropagation();
    var url = './AspPages/user.asp?acao=Pesquisa&vlrPesquisa=' + document.getElementById('txtPesquisaUsuario').value || '';

    var traducao = {
        "sEmptyTable": "Nenhum registro encontrado",
        "sInfo": "Mostrando de _START_ até _END_ de _TOTAL_ registros",
        "sInfoEmpty": "Mostrando 0 até 0 de 0 registros",
        "sInfoFiltered": "(Filtrados de _MAX_ registros)",
        "sInfoPostFix": "",
        "sInfoThousands": ".",
        "sLengthMenu": "_MENU_ Resultados por página",
        "sLoadingRecords": "Carregando...",
        "sProcessing": "Processando...",
        "sZeroRecords": "Nenhum registro encontrado",
        "sSearch": "Pesquisar",
        "oPaginate": {
            "sNext": "Próximo",
            "sPrevious": "Anterior",
            "sFirst": "Primeiro",
            "sLast": "Último"
        },
        "oAria": {
            "sSortAscending": ": Ordenar colunas de forma ascendente",
            "sSortDescending": ": Ordenar colunas de forma descendente"
        }
    };
    $.ajax({
        url: url,
        type: 'get',
        success: function (registros) {
            registros2 = JSON.parse(registros);
            debugger;
            var dataSet = [];
            registros2.Usuarios.forEach(registro => {
                var data = [];
                var acoes = '<td>' +
                    '<a href="usuario.asp?usuID=' + registro.UsuId + '" class="btn btn-outline-warning link-editar">Editar</a>' +
                    '<a href="usuario.asp?usuID=' + registro.UsuId + '" class="btn btn-outline-danger">Excluir</a>' +
                    '</td>'
                data.push(registro.Usuario);
                data.push(registro.Senha);
                data.push(registro.Nome);
                data.push(registro.Endereco);
                data.push(registro.Cidade);
                data.push(registro.Cep);
                data.push(registro.Estado);
                data.push(acoes);
                dataSet.push(data);
            });
            $("#tblUsuario").DataTable({
                data: dataSet, 
                "language": traducao
            })
        },
        error: function (xhr, status, error) {
            alert("Erro: " + error.Message);
        }
    });

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
    // TODO - Melhorar a forma de construção da url 
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