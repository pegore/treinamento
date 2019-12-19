<%
Response.Charset="UTF-8"
Set cn = Server.CreateObject("ADODB.Connection")
cn.Provider = "sqloledb"
cn.Open("Data Source=localhost;Initial Catalog=treinamento;User Id=sa;Password=123456;")
set rs = cn.Execute("SELECT * FROM [treinamento].[dbo].[estado]")
if not isempty(request.Form) then
     dim fname
     dim fpwd
     fname=Request.Form("user")
     fpwd=Request.Form("pwd")
     If fname<>"" Then
          Response.Write("Hello " & fname & "!<br>")
          Response.Write(" "& fpwd & "!<br>")
          Response.Write("How are you today?")
     End If
End If
%>