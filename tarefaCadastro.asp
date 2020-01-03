<%
  Set cnUser = Server.CreateObject("ADODB.Connection")
  cnUser.Provider = "sqloledb"
  cnUser.Open("Data Source=localhost;Initial Catalog=treinamento;User Id=sa;Password=123456;")
  'sqlUser = "SELECT * FROM [treinamento].[dbo].[usuario] where usuid=" & Request.QueryString("usuid")
  'Set rsUser=Server.CreateObject("ADODB.recordset")
  'rsUser.Open sqlUser, cnUser, &H0001
%>

<!DOCTYPE html>
<html lang="pt-br">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Sistema de Tarefas</title>
  <link rel="stylesheet" href="css/style.css">
</head>

<body>
   <!--#include file="./AspPages/TopMenu.inc"-->
<% 
    msg = Request.QueryString("msg")
    if(msg<>"") then
      Response.Write "<div class='alerta sucesso'>"&msg&"</div>"
    End If
    %>
<main class="centralizar col-12">
    <form name="frmTarefa" class="column spacing" action="tarefaCadastro.asp" method="post">     
      <input type="hidden" name="acao" value="">
      <input type="hidden" name="usuid" value="">      
      <div class="row form-group items-center">
          <label class="col-3" for="txtTitulo" >Título:</label>
          <input type="text" class="col-9 textfield" id="txtTitulo" name="txtTitulo" 
            placeholder="Usuário">
      </div>
      <div class="row form-group items-center">
        <label class="col-3" for="selEstados">Gerador:</label>
        <select class="col-9 textfield" id="selGerador" name="selGerador">           
         <%
            Set cnEst = Server.CreateObject("ADODB.Connection")
            cnEst.Provider = "sqloledb"
            cnEst.Open("Data Source=localhost;Initial Catalog=treinamento;User Id=sa;Password=123456;")
            sqlEst = "SELECT usuid,nome FROM [treinamento].[dbo].[usuario]"
            Set rsEst=Server.CreateObject("ADODB.recordset")
            rsEst.Open sqlEst, cnEst, &H0001
            do until rsEst.EOF
              for each x in rsEst.Fields
                  value = rsEst("usuid")
                  text = rsEst("nome")
              Next
              Response.write("<option value="&value&">"&text&"</option>")
              rsEst.MoveNext
            loop
            rsEst.Close
            cnEst.close
          %>
          </select>          
      </div>
      <div class="row form-group items-center">
        <label for="txtDescricao" class="col-3">Descrição:</label>
        <input type="text" class="col-9 textfield" id="txtDescricao" placeholder="Descrição da tarefa">
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
        <button type="submit" class="button button-primary col-4">Cadastrar</button>
        <button type="submit" class="button button-warning col-4">Alterar</button>
        <button type="submit" class="button button-secondary col-4">Novo</button>
      </div>
    </form>
</main>
</body>


</html>
