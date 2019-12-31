<%
'
'Seleção das funções a serem realizadas
'
stop
acao = Request.QueryString("acao")
id =  Request.QueryString("usuID")
Select Case acao
  Case "Inserir"
    Call InserirNovoUsuario()
  Case "Editar"
    Call EditarUsuario(id)
  Case "Excluir"
    Call ExcluirUsuario(id)
  Case "BuscaPorId"
    Call BuscaPorId(id)
  Case "Pesquisa"
    Call PesquisaUsuarios()  
  Case else
    Call LimparCampos()
End Select

'
' Cria a conexao com o banco de dados
'
Function CriaConexao()
  Set conexaoUsuario = Server.CreateObject("ADODB.Connection")
  conexaoUsuario.Provider = "sqloledb"
  conexaoUsuario.Open("Data Source=localhost;Initial Catalog=treinamento;User Id=sa;Password=123456;")
  CriaConexao = conexaoUsuario  
End Function
  
Function InserirNovoUsuario()
  'cn = CriaConexao()
  Set conexaoUsuario = Server.CreateObject("ADODB.Connection")
  conexaoUsuario.Provider = "sqloledb"
  conexaoUsuario.Open("Data Source=localhost;Initial Catalog=treinamento;User Id=sa;Password=123456;")
  sql="INSERT INTO [dbo].[usuario] (usuario,senha,nome,endereco,cidade,cep,estadoid) VALUES ("
  sql=sql & "'" & Request.Form("txtUsuario") & "',"
  sql=sql & "'" & Request.Form("pwdSenha") & "',"
  sql=sql & "'" & Request.Form("txtNome") & "',"
  sql=sql & "'" & Request.Form("txtEndereco") & "',"
  sql=sql & "'" & Request.Form("txtCidade") & "',"
  sql=sql & "'" & Request.Form("txtCep") & "',"
  sql=sql & "'" & Request.Form("selEstados") & "')"
  on error resume next
  conexaoUsuario.Execute sql, recaffected
  if err<>0 then
    msg = "Registro não gravado"
    Response.Write "Erro: "&sql
    Response.Redirect("usuarioCadastro.asp?recaffected="&recaffected&"&msg="&msg)
  end if
  conexaoUsuario.close
  msg = "Registro gravado com sucesso"
  acao="Novo"
  Response.Redirect("usuarioCadastro.asp?acao="&acao&"&recaffected="&recaffected&"&msg="&msg)
End function

Function LimparCampos()
  usuario=""
  senha=""
  nome=""
  endereco=""
  cidade=""
  cep=""
  estado=""
  
End Function

'
' Função para buscar e retornar um usuario
'
Function BuscaPorId(id)
  Set conexaoUsuario = Server.CreateObject("ADODB.Connection")
  conexaoUsuario.Provider = "sqloledb"
  conexaoUsuario.Open("Data Source=localhost;Initial Catalog=treinamento;User Id=sa;Password=123456;")
  queryUsuario = "SELECT * FROM [treinamento].[dbo].[usuario] as us left join [treinamento].[dbo].[estado] as es on us.estadoid=es.estadoid where usuid="&id
  Set recordSetUsuario=Server.CreateObject("ADODB.recordset")
  recordSetUsuario.Open queryUsuario, conexaoUsuario, &H0001
  usuario=recordSetUsuario.Fields.Item(1)
  senha=recordSetUsuario.Fields.Item(2)
  nome=recordSetUsuario.Fields.Item(3)
  endereco=recordSetUsuario.Fields.Item(4)
  cidade=recordSetUsuario.Fields.Item(5)
  cep=recordSetUsuario.Fields.Item(6)
  'estado=recordSetUsuario.Fields.Item(9)    
  recordSetUsuario.Close
  conexaoUsuario.close 
  
End Function

'
' Função para atualizar um usuário no banco de dados
'
Function EditarUsuario(id)
  cn = CriaConexao()
  sql="UPDATE [dbo].[usuario] SET "
  sql=sql & "[usuario] = '" & Request.Form("txtUsuario") & "',"
  sql=sql & "[senha] = '" & Request.Form("pwdSenha") & "',"
  sql=sql & "[nome] = '" & Request.Form("txtNome") & "',"
  sql=sql & "[endereco] = '" & Request.Form("txtEndereco") & "',"
  sql=sql & "[cidade] = '" & Request.Form("txtCidade") & "',"
  sql=sql & "[cep] = '" & Request.Form("txtCep") & "',"
  sql=sql & "[estadoid] = '" & Request.Form("selEstados") & "'"
  sql=sql & "WHERE usuid="& id
  on error resume next
  cn.Execute sql, recaffected
  if err<>0 then
    msg = "Registro não Atualizado"
    Response.Redirect("usuarioCadastro.asp?recaffected="&recaffected&"&msg="&msg)
  end if
  cn.close
  msg = "Registro atualizado com sucesso"
  Response.Redirect("usuarioCadastro.asp?recaffected="&recaffected&"&msg="&msg)
End Function

'
'Função para exclusão de usuário
'
Function ExcluirUsuario(id)
  '
  ' TODO - Validar se o usuário não possui tarefas antes da exclusão
  '
  cn = CriaConexao() 
  sql="DELETE FROM [dbo].[usuario] WHERE customerID='" & id & "'"
  on error resume next
  cn.Execute sql, recaffected
  if err<>0 then
    msg = "Registro não Excluido"
    Response.Redirect("usuarioCadastro.asp?recaffected="&recaffected&"&msg="&msg)
  end if
  cn.close
  msg = "Registro excluido com sucesso"
  Response.Redirect("usuarioCadastro.asp?recaffected="&recaffected&"&msg="&msg)
End Function
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
    <% 
    msg = Request.QueryString("msg")
    if(msg<>"") then
      Response.Write "<div class='alerta sucesso'>"&msg&"</div>"
    End If
    %>
  <div class="centralizar">
    <form name="frmUser" action="usuarioCadastro.asp?acao=<%=acao%>" method="post">
      <div class="central">
        <label for="txtUsuario">Usuário:</label>
        <div>

          <input type="text" id="txtUsuario" name="txtUsuario" value="<%=usuario%>" placeholder="Usuário">
        </div>
        <label for="pwdSenha">Senha:</label>
        <div>
          <input type="password" id="pwdSenha" name="pwdSenha" value="<%=senha%>" placeholder="Senha">
        </div>
      </div>
      <div class="central">      
        <label for="txtNome">Nome:</label>
        <div>
          <input type="text" id="txtNome" name="txtNome" value="<%=nome%>" placeholder="Nome">
        </div>
      </div>
      <div class="central">
        <label for="txtEndereco">Endereço:</label>
        <div>
          <input type="text" id="txtEndereco" name="txtEndereco" value="<%=endereco%>" placeholder="Endereço">
        </div>
        <label for="txtCidade">Cidade:</label>
        <div>
          <input type="text" id="txtCidade" name="txtCidade" value="<%=cidade%>" placeholder="Cidade">
        </div>
      </div>
      <div class="central">
        <label for="txtCep">Cep:</label>
        <div>
          <input type="text" id="txtCep" name="txtCep" value="<%=cep%>" placeholder="CEP">
        </div>
        <label for="selEstados">Estado:</label>
        <div>
          <select id="selEstados" name="selEstados">
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
      </div>           
      <div class="central">
        <button type="submit">Cadastrar</button>
        <button type="submit">Atualizar</button>
      </div>
    </form>
  </div>
</body>

</html>