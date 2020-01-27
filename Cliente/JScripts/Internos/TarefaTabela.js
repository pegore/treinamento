const url = "../Servidor/Controllers/tarefa.asp";
var RegistrosPorPagina = 20;
var PaginaPesquisa = 0;
window.addEventListener('DOMContentLoaded', function () {
    BuscarTarefas("BuscarTarefasPaginada", RegistrosPorPagina, PaginaPesquisa);
    AdicionarEventos();
});

function AdicionarEventos() {
    /*
    * Atrelando os eventos da tabela
    * A tabela terá os seguintes eventos:
    *   - carregamento inicial com valores padrões
    *   - avançar registros
    *   - recuar registros
    *   - qtd registros por pagina
    *   - botão editar registro
    */

}

function CriaInput(event) {
    debugger;
    event.stopImmediatePropagation();
    elemento = event.currentTarget;
    var input = document.createElement("input");
    input.type = 'text';
    input.className = 'col-2 textfield';
    input.value = elemento.innerText;
    input.id = elemento.id;
    input.addEventListener("keydown", function (event) {
        if (event.key === "Enter") {
            EditarTitulo(event);
        }
    });
    elemento.innerText = '';
    elemento.appendChild(input);
}
function EditarTitulo(event) {
    // TODO - Fazer a validação dos dados antes de enviar ao servidor
    debugger;
    data = {
        fnTarget: "EditarTarefa",
        idTarefa: event.currentTarget.id,
        titulo: event.currentTarget.value       
    }
    return $.ajax({
        url: url,
        type: 'POST',
        data: data,
        success: function (data) {
            debugger;
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

function BuscarTarefas(fnTarget, RegistrosPorPagina, PaginaPesquisa) {
    dadosPesquisa = {
        "fnTarget": fnTarget,
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
    var dadosCabecalho = Object.keys(dados.Registros[0]);
    var dadosCorpo = dados.Registros;
    var dadosRodape = {
        "TotalRegistros": dados.TotalRegistros,
        "RegistrosPorPagina": dados.RegistrosPorPagina,
        "PaginaAtual": dados.PaginaAtual,
        "TotalPaginas": dados.TotalPaginas,
    }
    var $tblTarefas = document.getElementById("tblTarefas");
 //   TabelaCriarCabecalho($tblTarefas, dadosCabecalho);
    TabelaCriarCorpo($tblTarefas, dadosCorpo);
    TabelaCriarRodape($tblTarefas, dadosRodape);
}

function TabelaCriarCabecalho(tabela, dadosCabecalho) {
    var cabecalho = tabela.createTHead();
    var novaLinha = cabecalho.insertRow();
    for (var key of dadosCabecalho) {
        var th = document.createElement("th");
        var texto = document.createTextNode(key);
        if (key == 'IdTarefa') {
            texto = document.createTextNode('N°');
        }
        th.appendChild(texto);
        novaLinha.appendChild(th);
    }
}

function TabelaCriarCorpo(tabela, dadosCorpo) {
    var tbody = tabela.createTBody();
    for (var element of dadosCorpo) {
        var row = tbody.insertRow();
        for (key in element) {
            var cell = row.insertCell();
            if (key == 'IdTarefa') {
                var a = document.createElement("a");
                var params = new URLSearchParams();
                params.append(key, element[key]);
                // TODO - Melhorar a forma de construção da url criar objeto URL
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
}

function TabelaCriarRodape(tabela, dados) {
    debugger;
    var $detalhesRegistros = document.getElementById("txtDetalhesRegistros");
    $detalhesRegistros.innerText = "Mostrando " + dados.TotalRegistros + " de " + dados.TotalRegistros + " Registros";
    
    
    // var tfoot = tabela.createTFoot(); //<tfoot></tfoot>
    // var row = tfoot.insertRow(0); //<tr></tr>
    // var cell = row.insertCell(0);//<th></th>
    // cell.colSpan = tabela.rows[0].cells.length;

    // var div = document.createElement("div");//<div></div>
    // div.setAttribute("class", "pagination");//<div class="pagination">

    // var ul = document.createElement("ul");//<ul></ul>;

    // var linkPrimeiraPagina = document.createElement("a");//<a></a>
    // linkPrimeiraPagina.href = "usuarioTabela.asp?pagina=1&registrosPorPagina=20"; // href="usuarioTabela.asp?pagina=1&registrosPorPagina=20">
    // var liPrimeiraPagina = document.createElement("li");//<li></li>;
    // liPrimeiraPagina.innerText = "<<"; // <<
    // linkPrimeiraPagina.appendChild(liPrimeiraPagina);//<a href="#"><li> << </li></a>

    // var linkVoltaUmaPagina = document.createElement("a");//<a></a>
    // linkVoltaUmaPagina.href = "usuarioTabela.asp?pagina=1&registrosPorPagina=20"; // href="usuarioTabela.asp?pagina=1&registrosPorPagina=20">
    // var liVoltaUmaPagina = document.createElement("li");//<li></li>;
    // liVoltaUmaPagina.innerText = "<"; // <
    // linkVoltaUmaPagina.appendChild(liVoltaUmaPagina);//<a href="#"><li> < </li></a>

    // var inputPagina = document.createElement("input");// <input/>
    // inputPagina.type = "text";//type="text"
    // inputPagina.id = "txtPagina";// id="txtPagina"
    // inputPagina.name = "txtPagina";//name="txtPagina" 

    // var linkAvancaUmaPagina = document.createElement("a");//<a></a>
    // linkAvancaUmaPagina.href = "usuarioTabela.asp?pagina=1&registrosPorPagina=20"; // href="usuarioTabela.asp?pagina=1&registrosPorPagina=20">
    // var liAvancaUmaPagina = document.createElement("li");//<li></li>;
    // liAvancaUmaPagina.innerText = ">"; // >
    // linkAvancaUmaPagina.appendChild(liAvancaUmaPagina);//<a href="#"><li> < </li></a>

    // var linkUltimaPagina = document.createElement("a");//<a></a>
    // linkUltimaPagina.href = "usuarioTabela.asp?pagina=1&registrosPorPagina=20"; // href="usuarioTabela.asp?pagina=1&registrosPorPagina=20">
    // var liUltimaPagina = document.createElement("li");//<li></li>;
    // liUltimaPagina.innerText = ">>"; // >>
    // linkUltimaPagina.appendChild(liUltimaPagina);//<a href="#"><li> >> </li></a>


    // var liInfo = document.createElement("li");//<li></li>;
    // liInfo.innerText = "Mostrando " + dados.RegistrosPorPagina + " de " + dados.TotalRegistros + " Registros"; // Mostrando 2 de 2 registros

    // var liQtdRegistros = document.createElement("li");//<li></li>;
    // var inputQtdRegistros = document.createElement("input");// <input/>
    // inputQtdRegistros.type = "text";//type="text"
    // inputQtdRegistros.id = "txtQtdRegistros";// id="txtQtdRegistros"
    // inputQtdRegistros.name = "txtQtdRegistros";//name="txtQtdRegistros" 
    // inputQtdRegistros.value = dados.RegistrosPorPagina;
    // lblQtdRegistros = document.createElement("label");
    // lblQtdRegistros.innerText = "Quantidade de Registros por Página: "
    // liQtdRegistros.appendChild(lblQtdRegistros);
    // liQtdRegistros.appendChild(inputQtdRegistros);


    // ul.appendChild(linkPrimeiraPagina);
    // ul.appendChild(linkVoltaUmaPagina);
    // ul.appendChild(inputPagina);
    // ul.appendChild(linkAvancaUmaPagina);
    // ul.appendChild(linkUltimaPagina);
    // ul.appendChild(liInfo);
    // ul.appendChild(liQtdRegistros);
    // div.appendChild(ul);
    // cell.appendChild(div);
}