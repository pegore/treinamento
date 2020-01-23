<!DOCTYPE html>
<html lang="pt-br">

<head>
  <!--#include file="./Includes/HtmlSecaoHead.inc"-->
</head>

<body>
  <!--#include file="./Includes/TopMenu.inc"-->

  <main class="col-12">
    <div class="centralizar">
      <form class="column spacing col-12" name="frmTarefa" id="frmTarefa" autoComplete="off">
        <h3 class="center col-12">Cadastro de Tarefas</h3>
        <div class="row form-group items-center">
          <label class="col-3" for="txtTitulo">Título:</label>
          <input type="text" class="col-9 textfield" id="txtTitulo" name="txtTitulo" placeholder="Título da tarefa">
        </div>
        <div class="row form-group items-center">
          <label class="col-3" for="selGerador">Gerador:</label>
          <select class="col-9 textfield" id="selGerador" name="selGerador">
            <option value="0">Selecione o Gerador</option>
          </select>
        </div>
        <div class="row form-group items-center">
          <label for="txtDescricao" class="col-3">Descrição:</label>
          <input type="text" class="col-9 textfield" id="txtDescricao" name="txtDescricao"
            placeholder="Descrição da tarefa">
        </div>
        <div class="row form-group items-center">
          <label for="txtDataGeracao" class="col-3">Data:</label>
          <input type="datetime-local" class="col-9 textfield" id="txtDataGeracao" name="txtDataGeracao" placeholder="Data">
        </div>

        <div class="row form-group items-center">
          <label for="selStatus" class="col-3">Status:</label>
          <select class="col-9 textfield" id="selStatus" name="selStatus">
            <option value="-1">Selecione o Status</option>
            <option value="0">Não Iniciado</option>
            <option value="1">Em andamento</option>
            <option value="7">Cancelada</option>
            <option value="9">Concluída</option>
          </select>
        </div>
        <div class="row form-group items-center">
          <button type="button" id="btnCadastrar" class="button button-primary col-4">Cadastrar</button>
          <button type="button" id="btnAlterar" class="button button-warning col-4">Alterar</button>
          <button type="button" id="btnExcluir" class="button button-danger col-4">Excluir</button>
          <button type="button" id="btnNovo" class="button button-secondary col-4">Novo</button>
        </div>
      </form>
  </main>
  <script src="JScripts/Externos/Jquery-3-4-1.js" type="text/javascript"></script>
  <script src="JScripts/Internos/TarefaCadastro.js" type="text/javascript"></script>
</body>

</html>