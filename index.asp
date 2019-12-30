<%
dim fUsuario
dim fpassword
fUsuario=Request.Form("txtUsuario")
fpassword=Request.Form("pwdSenha")
If fUsuario="" and fpassword="" Then
    Response.Redirect("../Login.html")
End If
sql = "SELECT * FROM [treinamento].[dbo].[usuario] where usuario='" & fUsuario & "' and senha='" & fpassword & "'"
Set cn = Server.CreateObject("ADODB.Connection")
cn.Provider = "sqloledb"
cn.Open("Data Source=localhost;Initial Catalog=treinamento;User Id=sa;Password=123456;")    
Set rs=Server.CreateObject("ADODB.recordset")
rs.Open sql, cn, &H0001
if rs.EOF Then
    rs.close
    Response.Redirect("../Login.html")
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
    <a href="./usuarioCadastro.asp?acao=Novo">Cadastro Usuários</a>
    <a href="./usuarioTabela.asp?acao=Listar">Tabela de Usuários</a>
    <a href="./tarefaCadastro.asp?acao=Inserir">Cadastro de Tarefas</a>
    <a href="./tarefaTabela.asp?acao=Listar">Tabela de Tarefas</a>
  </nav>  
</body>

</html>