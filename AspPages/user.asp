<%
d=Request.QueryString("acao")
Select Case d
  Case "Editar"
    Call EditarUsuario(id)
  Case "Inserir"
    Call InserirNovoUsuario()
  Case "Excluir"
    Call ExcluirUsuario(id)
  Case "Listar"
    Call ListarUsuarios()
  Case else
    response.write("Ação Inválida!!!!")
End Select

Function InserirNovoUsuario()
  Set cn = Server.CreateObject("ADODB.Connection")
  cn.Provider = "sqloledb"
  cn.Open("Data Source=localhost;Initial Catalog=treinamento;User Id=sa;Password=123456;")    
  sql="INSERT INTO [dbo].[usuario] (usuario,senha,nome,endereco,cidade,cep,estadoid) VALUES ("
  sql=sql & "'" & Request.Form("txtUsuario") & "',"
  sql=sql & "'" & Request.Form("pwdSenha") & "',"
  sql=sql & "'" & Request.Form("txtNome") & "',"
  sql=sql & "'" & Request.Form("txtEndereco") & "',"
  sql=sql & "'" & Request.Form("txtCidade") & "',"
  sql=sql & "'" & Request.Form("txtCep") & "',"
  sql=sql & "'" & Request.Form("selEstados") & "')"
  on error resume next
  cn.Execute sql, recaffected
  if err<>0 then
    Response.Write("Sem permissão para inserir usuários!")
    Response.Redirect("../AspPages/usuarioCadastro.asp")
  end if
  cn.close
  Response.Redirect("../AspPages/usuarioCadastro.asp?recaffected="&recaffected)
End function

Function EditarUsuario(id)
  sql = "SELECT * FROM [treinamento].[dbo].[usuario] where usuario='" & fUsuario & "' and senha='" & fpassword & "'"
  Set cn = Server.CreateObject("ADODB.Connection")
  cn.Provider = "sqloledb"
  cn.Open("Data Source=localhost;Initial Catalog=treinamento;User Id=sa;Password=123456;")    
  Set rs=Server.CreateObject("ADODB.recordset")
  rs.Open sql, cn, &H0001
  
End Function
%>