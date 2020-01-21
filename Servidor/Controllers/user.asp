<!--#include file="../Models/Conexao.class.asp"-->
<!--#include file="../Models/Usuario.class.asp"-->
<%
  Response.CodePage = 65001
  Response.CharSet = "UTF-8"
  '
  'Seleção das funções a serem realizadas
  '
  If Request("fnTarget")<>"" Then
    dim palavraParaPesquisa
    dim id
    dim RegistrosPorPagina 
    dim PaginaPesquisa

    if(IsNumeric(Request("PaginaPesquisa"))) then
      PaginaPesquisa = Cint(Request("PaginaPesquisa"))
    end if
    
    if(IsNumeric(Request("RegistrosPorPagina"))) then
      RegistrosPorPagina = Cint(Request("RegistrosPorPagina"))
    end if
    
    palavraParaPesquisa = Request("palavraParaPesquisa")
    id =  Request("usuID")

    Execute(Request("fnTarget"))

  End if

  '
  ' Função para buscar os usuários em modo de paginação
  '
  Function BuscarUsuariosPaginados()
    Dim numeroTotalRegistros
    Dim numeroTotalPaginas
    set ObjConexao = new Conexao
    set cn = ObjConexao.AbreConexao()
    set ObjUsuario = new cUsuario
    set rs = objUsuario.BuscarUsuarios(cn, palavraParaPesquisa)  
    If Not rs.Eof Then
      numeroTotalPaginas = rs.PageCount
      rs.PageSize = RegistrosPorPagina
      numeroTotalRegistros=rs.RecordCount
      If PaginaPesquisa < 1 Or PaginaPesquisa > numeroTotalPaginas Then
        PaginaPesquisa = 1			
      End If    
      rs.AbsolutePage = PaginaPesquisa
      Response.ContentType = "application/json"
      Response.Write "{"
      Response.Write """TotalRegistros"":""" & numeroTotalRegistros & ""","
      Response.Write """RegistrosPorPagina"":""" & RegistrosPorPagina & ""","
      Response.Write """PaginaAtual"":""" & PaginaPesquisa & ""","
      Response.Write """TotalPaginas"":""" & numeroTotalPaginas & ""","
      Response.Write """Registros"": ["
      Do While Not (rs.Eof OR rs.AbsolutePage <> PaginaPesquisa)
        Response.Write "{"
        Response.Write """Nome"": """ & rs("nome") & ""","
        Response.Write """Endereco"": """ & rs("endereco") & ""","
        Response.Write """Cidade"": """ & rs("cidade") & ""","
        Response.Write """Cep"": """ & rs("cep") & ""","
        Response.Write """UsuId"": """ & rs("usuid") & """"
        Response.Write "}"
        if rs.AbsolutePosition < numeroTotalRegistros then
          Response.Write ","
        end if
        rs.MoveNext
        Loop
    End If
    Response.Write "]"
    Response.Write "}"
  End Function

  Function BuscarUsuariosPaginadosJson()
    Dim numeroTotalRegistros
    Dim numeroTotalPaginas
    set ObjConexao = new Conexao
    set cn = ObjConexao.AbreConexao()
    set ObjUsuario = new cUsuario
    set rs = objUsuario.BuscarUsuarios(cn, palavraParaPesquisa)  
    If Not rs.Eof Then
      numeroTotalPaginas = rs.PageCount
      rs.PageSize = RegistrosPorPagina
      numeroTotalRegistros=rs.RecordCount
      If PaginaPesquisa < 1 Or PaginaPesquisa > numeroTotalPaginas Then
        PaginaPesquisa = 1			
      End If    
      rs.AbsolutePage = PaginaPesquisa
      Set json = Server.CreateObject("Chilkat_9_5_0.JsonObject")
      success = json.AddIntAt(-1,"TotalRegistros",numeroTotalRegistros)
      success = json.AddIntAt(-1,"RegistrosPorPagina",RegistrosPorPagina)
      success = json.AddIntAt(-1,"PaginaAtual",PaginaPesquisa)
      success = json.AddIntAt(-1,"TotalPaginas",numeroTotalPaginas)    
      success = json.AddArrayAt(-1,"Registros")
      Set aRegistros = json.ArrayAt(json.Size - 1)  
      index = -1
      Do While Not (rs.Eof OR rs.AbsolutePage <> PaginaPesquisa)
        success = aRegistros.AddObjectAt(-1)
        Set usuario = aRegistros.ObjectAt(aRegistros.Size - 1)
        success = usuario.AddIntAt(-1,"UsuId",rs("usuid"))
        success = usuario.AddStringAt(-1,"Usuario",rs("nome"))
        success = usuario.AddStringAt(-1,"Endereco",rs("endereco"))
        success = usuario.AddStringAt(-1,"Cidade",rs("cidade"))
        success = usuario.AddStringAt(-1,"Cep",rs("cep"))     
        rs.MoveNext
      Loop
    End If
    rs.Close()
    ObjConexao.FecharConexao(cn)
    json.EmitCompact = 0
    Response.Write json.Emit()    
  End function
    
Function CadastrarUsuario() 
  set ObjUsuario = new cUsuario
  ObjUsuario.setUsuario(Request("usuario"))
  ObjUsuario.setSenha(Request("senha"))
  ObjUsuario.setNome(Request("nome"))
  ObjUsuario.setEndereco(Request("endereco"))
  ObjUsuario.setCidade(Request("cidade"))
  ObjUsuario.setCep(Request("cep"))
  ObjUsuario.setIdEstado(Request("estado")) 
  set ObjConexao = new Conexao
  set cn = ObjConexao.AbreConexao()
  retorno = objUsuario.InsercaoUsuario(cn, ObjUsuario)  
  if retorno<>"" then
    msg = "Registro não gravado"
    Response.Write "Erro: "&sql
  end if
  cn.close
  msg = "Registro gravado com sucesso"
  Response.ContentType = "application/json"
  Response.Write "{"
  Response.Write """Mensagem"":""" & msg & """"
  Response.Write "}"
End function


Function BuscarUsuarioPorId() 
  set ObjConexao = new Conexao
  set cn = ObjConexao.AbreConexao()
  set ObjUsuario = new cUsuario
  set rs = objUsuario.BuscarUsuarioPorId(cn, id)
  If Not rs.Eof Then     
    Response.ContentType = "application/json"
    Response.Write "{"
    Response.Write """Usuario"": """ & rs("usuario") & ""","
    Response.Write """Senha"": """ & rs("senha") & ""","
    Response.Write """Nome"": """ & rs("nome") & ""","
    Response.Write """Endereco"": """ & rs("endereco") & ""","
    Response.Write """Cidade"": """ & rs("cidade") & ""","
    Response.Write """Cep"": """ & rs("cep") & ""","
    Response.Write """Estado"": """ & rs("estadoId") & """"
    Response.Write "}"        
  End If
End function

' '
' ' Função para atualizar um usuário no banco de dados
' '
' Function EditarUsuario(id)
' stop
'   sql="UPDATE [dbo].[usuario] SET "
'   sql=sql & "[usuario] = '" & Request.Form("txtUsuario") & "',"
'   sql=sql & "[senha] = '" & Request.Form("pwdSenha") & "',"
'   sql=sql & "[nome] = '" & Request.Form("txtNome") & "',"
'   sql=sql & "[endereco] = '" & Request.Form("txtEndereco") & "',"
'   sql=sql & "[cidade] = '" & Request.Form("txtCidade") & "',"
'   sql=sql & "[cep] = '" & Request.Form("txtCep") & "',"
'   sql=sql & "[estadoid] = '" & Request.Form("selEstados") & "'"
'   sql=sql & "WHERE usuid="& id
'   on error resume next
'   cn.Execute sql, recaffected
'   if err<>0 then
'     msg = "Registro não Atualizado"
'     Response.Redirect("usuarioCadastro.asp?recaffected="&recaffected&"&msg="&msg)
'   end if
'   cn.close
'   msg = "Registro atualizado com sucesso"
'   Response.Redirect("usuarioCadastro.asp?recaffected="&recaffected&"&msg="&msg)
' End Function

' '
' 'Função para exclusão de usuário
' '
' Function ExcluirUsuario(id)
'   '
'   ' TODO - Validar se o usuário não possui tarefas antes da exclusão
'   '
'  stop
'   sql="DELETE FROM [dbo].[usuario] WHERE customerID='" & id & "'"
'   on error resume next
'   cn.Execute sql, recaffected
'   if err<>0 then
'     msg = "Registro não Excluido"
'     Response.Redirect("usuarioCadastro.asp?recaffected="&recaffected&"&msg="&msg)
'   end if
'   cn.close
'   msg = "Registro excluido com sucesso"
'   Response.Redirect("usuarioCadastro.asp?recaffected="&recaffected&"&msg="&msg)
' End Function


%>