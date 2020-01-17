<!--#include file="../Models/Conexao.class.asp"-->
<!--#include file="../Models/Usuario.class.asp"-->
<%
dim logado : logado = "false"
dim usuario : usuario=Request.Form("usuario")
dim senha : senha=Request.Form("senha")

set ObjConexao = new Conexao
set cn = ObjConexao.AbreConexao()
set ObjUsuario = new cUsuario
set rs = objUsuario.BuscarUsuarioPorNomeSenha(cn, usuario, senha)

if rs.EOF<>"" Then
    Session("usuario") = rs("usuario")
    Session("senha") = rs("senha")
    Session("codigo") = rs("usuid")
    logado = "true"
end if
'
' Pode ser gerado um JWT e colocado na sessão
' Verificar o funcionamento do objeto Session
'
' Pode ser criado um hash da senha também para retornar na sessão
'
ObjConexao.FecharConexao(cn)
Response.Write "{"
Response.Write """logado"":"&logado
Response.Write "}"
'Set json = Server.CreateObject("Chilkat_9_5_0.JsonObject")
'index = -1   
'success = json.AddBoolAt(-1,"logado",logado)
'json.EmitCompact = 0
'Response.Write json.Emit()
%>