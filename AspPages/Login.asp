<%
dim fUsuario
dim fpassword
fUsuario=Request.Form("usuario")
fpassword=Request.Form("senha")
sql = "SELECT * FROM [treinamento].[dbo].[usuario] where usuario='" & fUsuario & "' and senha='" & fpassword & "'"
Set cn = Server.CreateObject("ADODB.Connection")
cn.Provider = "sqloledb"
cn.Open("Data Source=localhost;Initial Catalog=treinamento;User Id=sa;Password=123456;")    
Set rs=Server.CreateObject("ADODB.recordset")
rs.Open sql, cn, &H0001
if rs.EOF Then
    Response.Write("Usuário ou senha inválida")
Else
    Session("usuario") = rs("usuario")
    Session("senha") = rs("senha")
    Session("codigo") = rs("usuid")
    Response.Write("Logado com Sucesso")
end if
rs.close
cn.close
set rs = Nothing
set cn = Nothing
%>