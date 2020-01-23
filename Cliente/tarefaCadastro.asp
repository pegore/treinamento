<!DOCTYPE html>
<html lang="pt-br">

<head>
  <!--#include file="./Includes/HtmlSecaoHead.inc"-->
</head>

<body>
  <!--#include file="./Includes/TopMenu.inc"-->
 
 <main class="col-12">
    <div class="centralizar">
      <form class="column spacing col-12" name="frmUser" id="frmUser" autoComplete="off">
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
        <label for="txtData" class="col-3">Data:</label>
        <input type="date" class="col-9 textfield" id="txtData" name="txtData" placeholder="Data">
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
        <button type="submit" class="button button-primary col-3">Cadastrar</button>
        <button type="submit" class="button button-warning col-3">Alterar</button>
        <button type="submit" class="button button-secondary col-3">Novo</button>
        <button type="submit" class="button button-danger col-3">Excluir</button>
      </div>
    </form>
  </main>
</body>

</html>