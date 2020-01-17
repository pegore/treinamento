document.addEventListener('DOMContentLoaded', function () {
    //AdicionarEventos();
    BuscarUsuarios("BuscarUsuariosPaginadosJson", 20, 1);
});

function AdicionarEventos() {
    /*
    * Atrelar os eventos da página   
    * A tabela terá os seguintes eventos:
    *   - avançar registros
    *   - recuar registros
    *   - preencher a pagina
    *   - qtd registros por pagina
    *   - botão editar registro
    */
    $body = document.getElementsByTagName("BODY")[0];
    $body.addEventListener("load", function () {
        BuscarUsuarios("BuscarUsuariosPaginadosJson", 10, 1);
    });
}

function BuscarUsuarios(fnTarget, RegistrosPorPagina, PaginaPesquisa) {
    /*
    * Lógica para preenchimento dos dados iniciais da tabela de usuários    
    */
   data = {
       "fnTarget": fnTarget,
       "RegistrosPorPagina": RegistrosPorPagina,
       "PaginaPesquisa": PaginaPesquisa,
    }
    return $.ajax({
        url: "../Servidor/Controllers/user.asp",
        type: 'POST',
        data: data,
        success: function (data) {
            debugger;
            registros = JSON.parse(data);
            PreencheTabela(registros.Registros);
        },
        error: function (xhr, status, error) {
            alert("Erro: " + xhr + status + error);
        }
    });
}


function generateTableHead(table, data) {
    let thead = table.createTHead();
    let row = thead.insertRow();
    for (let key of data) {
      let th = document.createElement("th");
      let text = document.createTextNode(key);
      th.appendChild(text);
      row.appendChild(th);
    }
  }
  function generateTable(table, data) {
    for (let element of data) {
      let row = table.insertRow();
      for (key in element) {
        let cell = row.insertCell();
        let text = document.createTextNode(element[key]);
        cell.appendChild(text);
      }
    }
  }
  
function PreencheTabela(registros) {

    var tblUsuarios = document.getElementById("tblUsuarios");
    let data = Object.keys(registros[0]);
    generateTableHead(tblUsuarios, data);
    generateTable(tblUsuarios, registros);
    generateFooter(tblUsuarios,dados);
}

function generateFooter (tabela,dados) {
//  <tfoot>
// <tr>
//   <th colspan=100%>
//     <div class="pagination">
//       <ul>
//         <a href="#">
//           <li>
//             <<</li> </a> <a href="#">
//           <li>
//             <</li> </a> <input type="text" name="" id="">
//               <a href="#">
//           <li>></li>
//         </a>
//         <a href="#">
//           <li>>></li>
//         </a>
//         <li>Mostrando 2 de 2 registros</li>
//       </ul>
//     </div>
//   </th>
// </tr>
// </tfoot>
}


// debugger;
// registros = JSON.parse(data);
// var dataSet = [];
// registros.Registros.forEach(registro => {
//     var data = [];
//     var acoes = '<td>' +
//         '<a href="usuario.asp?usuID=' + registro.UsuId + '" class="btn btn-outline-warning link-editar">Editar</a>' +
//         '<a href="usuario.asp?usuID=' + registro.UsuId + '" class="btn btn-outline-danger">Excluir</a>' +
//         '</td>'
//     data.push(registro.Usuario);
//     data.push(registro.Senha);
//     data.push(registro.Nome);
//     data.push(registro.Endereco);
//     data.push(registro.Cidade);
//     data.push(registro.Cep);
//     data.push(registro.Estado);
//     data.push(acoes);
//     dataSet.push(data);
// });
// debugger;












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