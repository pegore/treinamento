<!--#include file="../Models/Conexao.class.asp"-->
<!--#include file="../Models/Usuario.class.asp"-->
<%
stop
dim msg : msg="Usuário ou senha inválida"
dim usuario : usuario=Request.Form("usuario")
dim senha : senha=Request.Form("senha")

set ObjConexao = new Conexao
set getConexao = ObjConexao.AbreConexao()
set ObjUsuario = new cUsuario
ObjUsuario.setUsuario = usuario
ObjUsuario.setSenha = senha

set usuario = objUsuario.BuscarUsuarioPorNomeSenha(getConexao, usuario, senha)





if usuario<>"" Then
    Session("usuario") = usuario.setUsuario
    Session("senha") = usuario.setSenha
    Session("codigo") = usuario.setId
    msg = "Logado com Sucesso"
end if
ObjConexao.FecharConexao()
ObjConexao=nothing
Response.Write(msg) 
%>