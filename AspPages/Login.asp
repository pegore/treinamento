<!--#include file="../Includes/Conexao.inc"--> 
<%
stop
dim msg : msg="Usuário ou senha inválida"
dim usuario : usuario=Request.Form("usuario")
dim password : password=Request.Form("senha")
sql = "SELECT * FROM [treinamento].[dbo].[usuario] where usuario='" & fUsuario & "' and senha='" & fpassword & "'" 
Set rs=Server.CreateObject("ADODB.recordset")
rs.Open sql, cn, &H0001
if not rs.EOF Then
    Session("usuario") = rs("usuario")
    Session("senha") = rs("senha")
    Session("codigo") = rs("usuid")
    msg = "Logado com Sucesso"
end if
rs.close
cn.close
set rs = Nothing
set cn = Nothing
Response.Write(msg) 
%>