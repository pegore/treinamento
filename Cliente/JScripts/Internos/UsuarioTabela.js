const url = "../Servidor/Controllers/tarefa.asp";
var RegistrosPorPagina = Number(document.getElementById("txtQtdRegistros").value) || 10;
var PaginaPesquisa = Number(document.getElementById("txtPagina").value) || 1;
window.addEventListener('DOMContentLoaded', function () {
    BuscarUsuarios(RegistrosPorPagina, PaginaPesquisa);
    AdicionarEventos();
});

function AdicionarEventos() {
    var $btnPrimeiraPagina = document.getElementById("btnPrimeiraPagina");
    var $btnVoltaPagina = document.getElementById("btnVoltaPagina");
    var $btnAvancaPagina = document.getElementById("btnAvancaPagina");
    var $btnUltimaPagina = document.getElementById("btnUltimaPagina");
    var $txtPagina = document.getElementById("txtPagina");
    var $txtQtdRegistros = document.getElementById("txtQtdRegistros");
    $btnPrimeiraPagina.addEventListener("click", function (e) {
        PrimeiraPagina(e);
    });
    $btnVoltaPagina.addEventListener("click", function (e) {
        VoltaPagina(e);
    });
    $btnAvancaPagina.addEventListener("click", function (e) {
        AvancaPagina(e);
    });
    $btnUltimaPagina.addEventListener("click", function (e) {
        UltimaPagina(e);
    });
    $txtPagina.addEventListener("keydown", function (e) {
        if (event.key === "Enter") {
            Pagina(e);
        }
    });
    $txtQtdRegistros.addEventListener("keydown", function (e) {
        if (event.key === "Enter") {
            QtdRegistros(e);
        }
    });
}


function PrimeiraPagina(event) {
    BuscarUsuarios(RegistrosPorPagina, 1);
}
function VoltaPagina(event) {
    var $txtPagina = document.getElementById("txtPagina");
    PaginaPesquisa = isNaN($txtPagina.value) ? 1 : Number($txtPagina.value) -1;
    BuscarUsuarios(RegistrosPorPagina, PaginaPesquisa)
}
function AvancaPagina(event) {
    var $txtPagina = document.getElementById("txtPagina");
    PaginaPesquisa = isNaN($txtPagina.value) ? 1 : Number($txtPagina.value) + 1;
    BuscarUsuarios(RegistrosPorPagina, PaginaPesquisa);
}
function UltimaPagina(event) {    
    BuscarUsuarios(RegistrosPorPagina, 32767);
}
function Pagina(event) {
    var $txtPagina = document.getElementById("txtPagina");
    PaginaPesquisa = isNaN($txtPagina.value) ? 1 : Number($txtPagina.value);
    BuscarUsuarios(RegistrosPorPagina, PaginaPesquisa);
}
function QtdRegistros(event) {
    var $txtQtdRegistros = document.getElementById("txtQtdRegistros");
    RegistrosPorPagina = isNaN($txtQtdRegistros.value) ? RegistrosPorPagina : Number($txtQtdRegistros.value);
    BuscarUsuarios(RegistrosPorPagina, PaginaPesquisa);
}
function BuscarUsuarios(RegistrosPorPagina, PaginaPesquisa) {
    dadosPesquisa = {
        "fnTarget": "BuscarUsuariosPaginados",
        "RegistrosPorPagina": RegistrosPorPagina,
        "PaginaPesquisa": PaginaPesquisa,
    }
    return $.ajax({
        url: "../Servidor/Controllers/user.asp",
        type: 'POST',
        data: dadosPesquisa,
        success: function (data) {
            PreencheTabela(data);
        },
        error: function (xhr, status, error) {
            alert("Erro: " + xhr + status + error);
        }
    });
}

function PreencheTabela(dados) {
    var $tabela = document.getElementById("tblUsuarios");
    if ($tabela.getElementsByTagName('tbody').length != 0) {
        var row = document.getElementsByTagName('tbody')[0];
        row.parentNode.removeChild(row);
    }
    var dadosCorpo = dados.Registros;
    var tbody = $tabela.createTBody();
    for (var element of dadosCorpo) {
        var row = tbody.insertRow();
        for (key in element) {
            var cell = row.insertCell();
            if (key == 'UsuId') {
                var a = document.createElement("a");
                var params = new URLSearchParams();
                params.append(key, element[key]);
                var url = 'usuarioCadastro.asp?' + params.toString();
                a.href = url;
                var imagem = document.createElement("IMG");
                imagem.src = "../Cliente/Images/editar.png";
                a.appendChild(imagem);
                cell.appendChild(a);
                continue;
            }
            var text = document.createTextNode(element[key]);
            cell.appendChild(text);
        }
    }   
    var $detalhesRegistros = document.getElementById("txtDetalhesRegistros");
    var $txtQtdRegistros = document.getElementById("txtQtdRegistros");
    var $txtPagina = document.getElementById("txtPagina");
    $detalhesRegistros.innerText = "Mostrando " + dados.RegistrosPorPagina + " de " + dados.TotalRegistros + " Registros";
    $txtQtdRegistros.value = dados.RegistrosPorPagina;
    $txtPagina.value = dados.PaginaAtual
}