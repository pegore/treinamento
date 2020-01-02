<%
dim fUsuario
dim fpassword
fUsuario=Request.Form("txtUsuario")
fpassword=Request.Form("pwdSenha")
If fUsuario="" or fpassword="" Then
    Response.Redirect("Index.html?login=vazio")
End If
sql = "SELECT * FROM [treinamento].[dbo].[usuario] where usuario='" & fUsuario & "' and senha='" & fpassword & "'"
Set cn = Server.CreateObject("ADODB.Connection")
cn.Provider = "sqloledb"
cn.Open("Data Source=LINO-PC;Initial Catalog=treinamento;User Id=sa;Password=123456;")    
Set rs=Server.CreateObject("ADODB.recordset")
rs.Open sql, cn, &H0001
if rs.EOF Then
    rs.close
    Response.Redirect("Index.html?login=Invalido")
end if
Session("usuario") = rs("usuario")
Session("senha") = rs("senha")
Session("codigo") = rs("usuid")
rs.close
cn.close
set rs = Nothing
set cn = Nothing
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
  <nav>    
    <a href="./usuarioCadastro.asp">Cadastro Usuários</a>
    <a href="./usuarioTabela.asp">Tabela de Usuários</a>
    <a href="./tarefaCadastro.asp?acao=Inserir">Cadastro de Tarefas</a>
    <a href="./tarefaTabela.asp?acao=Listar">Tabela de Tarefas</a>
  </nav>  
  <nav>    
    <a href="./usuarioCadastro.html">Cadastro Usuários - HTML</a>
    <a href="./usuarioTabela.html">Tabela de Usuários - HTML</a>
    <a href="./tarefaCadastro.html">Cadastro de Tarefas - HTML</a>
    <a href="./tarefaTabela.html">Tabela de Tarefas - HTML</a>
  </nav>  
</body>

</html>