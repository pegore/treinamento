<!doctype html>
<html lang="pt-br">

<head>
  <!--#include file="./Includes/HtmlSecaoHead.inc"-->
</head>

<body>
  <!--#include file="./Includes/TopMenu.inc"-->
  <main class="col-12">
    <div class="centralizar">
      <table class="table" id="tblTarefas">
        <caption>
          <h3 class="center col-12">Lista de Tarefas</h3>
        </caption>
        <thead>
          <tr>
            <th>Nº</th>
            <th>Título</th>
            <th>Descrição</th>
            <th>Data da Geração</th>
            <th>Status</th>
          </tr>
        </thead>
        <tfoot>
          <tr>
            <td colspan="3">
              <div class="pagination">
                <ul>
                  <li>
                    <button type="button" id="btnPrimeiraPagina" class="button button-default col-1">
                      <<</button> </li> <li>
                        <button type="button" id="btnVoltaPagina" class="button button-default col-1">
                          <</button> </li> <li>
                            <input type="text" class="col-1 textfield" id="txtPagina" name="txtPagina" />
                  </li>
                  <li>
                    <button type="button" id="btnAvancaPagina" class="button button-default col-1">
                      ></button>
                  </li>
                  <li><button type="button" id="btnUltimaPagina" class="button button-default col-1">
                      >></button>
                  </li>
                  <li id="txtDetalhesRegistros">Mostrando Registros</li>
                </ul>
              </div>
            </td>
            <td colspan="2">
              <div class="pagination">
                Quantidade de Registros por Página: <input type="text" class="col-2 textfield" id="txtQtdRegistros">
              </div>
            </td>
          </tr>
        </tfoot>
      </table>
    </div>
  </main>
  <script src="JScripts/Externos/Jquery-3-4-1.js" type="text/javascript"></script>
  <script src="JScripts/Internos/TarefaTabela.js" type="text/javascript"></script>
</body>

</html>