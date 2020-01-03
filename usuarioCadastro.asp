<!--#include file="./AspPages/user.asp"-->
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
    <form class="column spacing"  name="frmUser" action="usuarioCadastro.asp" method="post">
      <input type="hidden" name="acao" value="">
      <input type="hidden" name="usuid" value="">
      <div class="row form-group items-center">
        <label class="col-2" for="txtUsuario">Usuário:</label>
        <input class="col-4 textfield" type="text" id="txtUsuario" name="txtUsuario" value="" placeholder="Usuário">      
        <label class="col-2 pl-sm" for="pwdSenha">Senha:</label>
        <input class="col-4 textfield" type="password" id="pwdSenha" name="pwdSenha" value="" placeholder="Senha">
      </div>
      <div class="row form-group items-center">
        <label class="col-2" for="txtNome">Nome:</label>
        <input class="col-10 textfield" type="text" id="txtNome" name="txtNome" value="" placeholder="Nome">
      </div>
      <div class="row form-group items-center">
        <label class="col-2" for="txtEndereco">Endereço:</label>
        <input class="col-4 textfield" type="text" id="txtEndereco" name="txtEndereco" value="" placeholder="Endereço">      
        <label class="col-2 pl-sm" for="txtCidade">Cidade:</label>
        <input class="col-4 textfield" type="text" id="txtCidade" name="txtCidade" value="" placeholder="Cidade">
      </div>
      <div class="row form-group items-center">
        <label class="col-2" for="txtCep">Cep:</label>
        <input class="col-4 textfield" type="text" id="txtCep" name="txtCep" value="" placeholder="CEP">      
        <label class="col-2 pl-sm" for="selEstados">Estado:</label>
        <select class="col-4 textfield" id="selEstados" name="selEstados">
         <%
            Set cnEst = Server.CreateObject("ADODB.Connection")
            cnEst.Provider = "sqloledb"
            cnEst.Open("Data Source=localhost;Initial Catalog=treinamento;User Id=sa;Password=123456;")
            sqlEst = "SELECT * FROM [treinamento].[dbo].[estado]"
            Set rsEst=Server.CreateObject("ADODB.recordset")
            rsEst.Open sqlEst, cnEst, &H0001
            do until rsEst.EOF
              for each x in rsEst.Fields
                  value = rsEst("estadoid")
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
      <div class="row">
        <button type="submit" class="button button-primary col-4">Cadastrar</button>
        <button type="submit" class="button button-warning col-4">Alterar</button>
        <button type="submit" class="button button-secondary col-4">Novo</button>
      </div>
    </form>
  </main>
</body>


</html>