<%
dim fUsuario
dim fpassword
fUsuario=Request.Form("txtUsuario")
fpassword=Request.Form("pwdSenha")
If fUsuario="" and fpassword="" Then
    Response.Redirect("../index.html")
End If

sql = "SELECT * FROM [treinamento].[dbo].[usuario] where usuario='" & fUsuario & "' and senha='" & fpassword & "'"
Set cn = Server.CreateObject("ADODB.Connection")
cn.Provider = "sqloledb"
cn.Open("Data Source=localhost;Initial Catalog=treinamento;User Id=sa;Password=123456;")    
Set rs=Server.CreateObject("ADODB.recordset")
rs.Open sql, cn, &H0001
if rs.EOF Then
    rs.close
    Response.Redirect("../index.html")
end if
if fUsuario=rs("usuario") and fpassword = rs("senha") then    
    Session("usuario") = rs("usuario")
    Session("senha") = rs("senha")
    Session("codigo") = rs("usuid")
    rs.close
    Response.Redirect("../AspPages/usuarioCadastro.asp")						
End If
rs.close
cn.close
set rs = Nothing
set cn = Nothing
%>