<%
Set cn = Server.CreateObject("ADODB.Connection")
cn.Provider = "sqloledb"
cn.Open("Data Source=localhost;Initial Catalog=treinamento;User Id=sa;Password=123456;")    
sql="INSERT INTO [dbo].[usuario] (usuario,senha,nome,endereco,cidade,cep,estadoid) VALUES "
sql=sql & "('" & Request.Form("txtUsuario") & "',"
sql=sql & "'" & Request.Form("pwdSenha") & "',"
sql=sql & "'" & Request.Form("txtNome") & "',"
sql=sql & "'" & Request.Form("txtEndereco") & "',"
sql=sql & "'" & Request.Form("txtCidade") & "',"
sql=sql & "'" & Request.Form("txtCep") & "',"
sql=sql & "'" & 1 & "')"
on error resume next
cn.Execute sql,recaffected
if err<>0 then
  Response.Write("No update permissions!")
else
  Response.Write("<h3>" & recaffected & " record added</h3>")
end if
cn.close
%>