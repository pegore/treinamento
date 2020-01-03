
<!--#include file="./AspPages/tarefa.asp"-->
<!DOCTYPE html>
<html lang="pt-br">

<head>
  <!--#include file="./Includes/HtmlSecaoHead.inc"--> 
</head>

<body>
   <!--#include file="./Includes/TopMenu.inc"-->
<% 
    msg = Request.QueryString("msg")
    if(msg<>"") then
      Response.Write "<div class='alerta sucesso'>"&msg&"</div>"
    End If
    %>
<main class="centralizar col-12">
    <form name="frmTarefa" class="column spacing" action="tarefaCadastro.asp" method="post">     
      <input type="hidden" name="acao" value="Inserir">
      <input type="hidden" name="tarId" value="">      
      <div class="row form-group items-center">
          <label class="col-3" for="txtTitulo" >Título:</label>
          <input type="text" class="col-9 textfield" id="txtTitulo" name="txtTitulo" 
            placeholder="Título da tarefa">
      </div>
      <div class="row form-group items-center">
        <label class="col-3" for="selEstados">Gerador:</label>
        <select class="col-9 textfield" id="selGerador" name="selGerador">           
         <%
            Set conexaoUsuario = Server.CreateObject("ADODB.Connection")
            conexaoUsuario.Provider = "sqloledb"
            conexaoUsuario.Open("Data Source=localhost;Initial Catalog=treinamento;User Id=sa;Password=123456;")
            sqlUsuario = "SELECT usuid,nome FROM [treinamento].[dbo].[usuario]"
            Set recordSetUsuario=Server.CreateObject("ADODB.recordset")
            recordSetUsuario.Open sqlUsuario, conexaoUsuario, &H0001
            do until recordSetUsuario.EOF
              for each x in recordSetUsuario.Fields
                  value = recordSetUsuario("usuid")
                  text = recordSetUsuario("nome")
              Next
              Response.write("<option value="&value&">"&text&"</option>")
              recordSetUsuario.MoveNext
            loop
            recordSetUsuario.Close
            conexaoUsuario.close
          %>
          </select>          
      </div>
      <div class="row form-group items-center">
        <label for="txtDescricao" class="col-3">Descrição:</label>
        <input type="text" class="col-9 textfield" id="txtDescricao" name="txtDescricao" placeholder="Descrição da tarefa">
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
