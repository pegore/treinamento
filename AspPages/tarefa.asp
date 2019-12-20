<%
Set cn = Server.CreateObject("ADODB.Connection")
cn.Provider = "sqloledb"
cn.Open("Data Source=localhost;Initial Catalog=treinamento;User Id=sa;Password=123456;")    
sql="INSERT INTO [dbo].[tarefa] ([tarTitulo],[geradorID],[tarData],[tarStatus],[tarDescricao]) VALUES ("
sql=sql & "'" & Request.Form("txtTitulo") & "',"
sql=sql & "'" & Request.Form("selGerador") & "',"
sql=sql & "'" & CDate(Request.Form("txtData")) & "',"
sql=sql & "'" & Request.Form("selStatus") & "',"
sql=sql & "'" & Request.Form("txtDescricao") &"')"
on error resume next
cn.Execute sql, recaffected
if err<>0 then
  Response.Redirect("../AspPages/tarefaCadastro.asp?err="& err.Description)
End If
cn.close
Response.Redirect("../AspPages/usuarioCadastro.asp")
%>