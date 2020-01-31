const url = "../Servidor/Controllers/tarefa.asp";
var RegistrosPorPagina = Number(document.getElementById("txtQtdRegistros").value) || 10;
var PaginaPesquisa = Number(document.getElementById("txtPagina").value) || 1;
window.addEventListener('DOMContentLoaded', function () {
    BuscarTarefas(RegistrosPorPagina, PaginaPesquisa);
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
    BuscarTarefas(RegistrosPorPagina, 1);
}
function VoltaPagina(event) {
    var $txtPagina = document.getElementById("txtPagina");
    PaginaPesquisa = isNaN($txtPagina.value) ? 1 : Number($txtPagina.value) - 1;
    BuscarTarefas(RegistrosPorPagina, PaginaPesquisa)
}
function AvancaPagina(event) {
    var $txtPagina = document.getElementById("txtPagina");
    PaginaPesquisa = isNaN($txtPagina.value) ? 1 : Number($txtPagina.value) + 1;
    BuscarTarefas(RegistrosPorPagina, PaginaPesquisa);
}
function UltimaPagina(event) {
    BuscarTarefas(RegistrosPorPagina, 32767);
}
function Pagina(event) {
    var $txtPagina = document.getElementById("txtPagina");
    PaginaPesquisa = isNaN($txtPagina.value) ? 1 : Number($txtPagina.value);
    BuscarTarefas(RegistrosPorPagina, PaginaPesquisa);
}
function QtdRegistros(event) {
    var $txtQtdRegistros = document.getElementById("txtQtdRegistros");
    RegistrosPorPagina = isNaN($txtQtdRegistros.value) ? RegistrosPorPagina : Number($txtQtdRegistros.value);
    BuscarTarefas(RegistrosPorPagina, PaginaPesquisa);
}

function CriaInput(event) {
    event.stopImmediatePropagation();
    elemento = event.currentTarget;
    var valorOriginal = elemento.innerText;
    var input = document.createElement("input");
    input.type = 'text';
    input.className = 'col-2 textfield';
    input.value = valorOriginal;
    input.id = elemento.id;
    input.addEventListener("keyup", function (event) {
        if (event.key === "Enter") {
            EditarTitulo(event);
            event.currentTarget.remove();
        }
        if (event.key === "Escape") {
            elemento.innerText = valorOriginal;
            event.currentTarget.remove();
        }
    });
    input.addEventListener("blur", function (event) {
        elemento.innerText = valorOriginal;
        event.currentTarget.remove();
    });
    elemento.innerText = '';
    elemento.appendChild(input);
}

function EditarTitulo(event) {
    var titulo = event.currentTarget.value;
    if (titulo == null || titulo == "") {
        alert('Título não pode ser vazio');
        return;
    }
    data = {
        fnTarget: "EditarTitulo",
        idTarefa: event.currentTarget.id,
        titulo: titulo
    }
    return $.ajax({
        url: url,
        type: 'POST',
        data: data,
        success: function (data) {
            if (data.Erro) {
                alert("Erro: " + data.Erro);
            }
            window.location.reload();
        },
        error: function (xhr, status, error) {
            alert("Erro: " + xhr + status + error);
        }
    });
}
function AlterarStatus(event) {
    // TODO - Melhorar esses IF´s não está legal
    var status = event.currentTarget.getAttribute("Status");
    var imagem = event.currentTarget;
    if (status == '0' || status == '1') {
        imagem.src = "../Cliente/Images/7.gif";
        imagem.setAttribute("Status", 7);
        statusNovo = 7
    } else if (status == '7') {
        imagem.src = "../Cliente/Images/9.gif";
        imagem.setAttribute("Status", 9);
        statusNovo = 9
    } else if (status == '9') {
        imagem.src = "../Cliente/Images/1.gif";
        imagem.setAttribute("Status", 1);
        statusNovo = 1
    }
    data = {
        fnTarget: "AlterarStatus",
        idTarefa: event.currentTarget.getAttribute("IdTarefa"),
        status: statusNovo
    }
    return $.ajax({
        url: url,
        type: 'POST',
        data: data,
        success: function (data) {
            if (data.Erro) {
                alert("Erro: " + data.Erro);
            }
        },
        error: function (xhr, status, error) {
            alert("Erro: " + xhr + status + error);
        }
    });
}

function BuscarTarefas(RegistrosPorPagina, PaginaPesquisa) {
    dadosPesquisa = {
        "fnTarget": "BuscarTarefasPaginada",
        "RegistrosPorPagina": RegistrosPorPagina,
        "PaginaPesquisa": PaginaPesquisa,
    }
    return $.ajax({
        url: url,
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
    var $tabela = document.getElementById("tblTarefas");
    if ($tabela.getElementsByTagName('tbody').length != 0) {
        var row = document.getElementsByTagName('tbody')[0];
        row.parentNode.removeChild(row);
    }
    var tbody = $tabela.createTBody();
    for (var element of dados.Registros) {
        var row = tbody.insertRow();
        for (key in element) {
            var cell = row.insertCell();
            if (key == 'IdTarefa') {
                var a = document.createElement("a");
                var params = new URLSearchParams();
                params.append(key, element[key]);
                var url = 'TarefaCadastro.asp?' + params.toString();
                a.href = url;
                a.innerText = element[key];
                cell.appendChild(a);
                continue;
            };
            if (key == 'Titulo') {
                cell.id = element.IdTarefa;
                cell.addEventListener("dblclick", function (e) {
                    e.stopImmediatePropagation();
                    e.stopPropagation();
                    CriaInput(e);
                    var ipt = document.getElementById(element.IdTarefa);
                    ipt.focus();
                });
            }
            if (key == 'Status' && element[key] != 0) {
                var imagem = document.createElement("IMG");
                imagem.src = "../Cliente/Images/" + element[key] + ".gif";
                imagem.alt = "Não Iniciada";
                imagem.setAttribute("Status", element[key]);
                imagem.setAttribute("IdTarefa", element['IdTarefa']);
                imagem.addEventListener("dblclick", function (e) {
                    AlterarStatus(e);
                });
                cell.appendChild(imagem);
                continue;

            };
            var text = document.createTextNode(element[key]);
            cell.appendChild(text);
        }
    }
    var $detalhesRegistros = document.getElementById("txtDetalhesRegistros");
    var $txtQtdRegistros = document.getElementById("txtQtdRegistros");
    var $txtPagina = document.getElementById("txtPagina");
    $detalhesRegistros.innerText = "Mostrando " + dados.TotalRegistros + " de " + 15 + " Registros";
    $txtQtdRegistros.value = dados.RegistrosPorPagina;
    $txtPagina.value = dados.PaginaAtual
}
