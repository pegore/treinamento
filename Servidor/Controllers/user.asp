<!--#include file="../Models/Conexao.class.asp"-->
<!--#include file="../Models/Usuario.class.asp"-->
<%
' // TODO - Criar uma função de retorno de mensagens
'         - Criar uma função de retorno de erros
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
  ' Função para buscar os usuários em modo de paginação respnse write
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

  

'
' Cadastra um usuário no banco
'    
Function CadastrarUsuario() 
  ' // TODO - Criar Função de validação dos dados;
  '         - Função deve receber o objeto usuário;
  '         - Função deve receber o objeto conexão;
  '         - Melhorar o tratamento de erros;
  '         - Melhorar mensagens de retorno;
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
  stop
  Response.ContentType = "application/json"
  Response.Write "{"
  If VarType(retorno)=8 then 
      Response.Write """Erro"":""" & Replace(retorno,chr(34),chr(39)) & """"
  Else
    Response.Write """UsuId"":""" & retorno & """"
  end if
  ObjConexao.FecharConexao(cn)
  Response.Write "}"
End function

'
' Retorna um usuário do Banco de dados para o cliente response write
'
Function BuscarUsuarioPorId() 
  ' // TODO - Função deve receber o objeto conexão
  '         - Função deve receber um objeto usuário preenchido com o id
  '         - Fazer tratamento de erros;
  '         - Melhorar mensagens de retorno;
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
  rs.Close()
  ObjConexao.FecharConexao(cn)
End function



'
' Função para atualizar um usuário no banco de dados
'
Function EditarUsuario()
  stop  
  set ObjUsuario = new cUsuario
  ObjUsuario.setId((Request("usuId"))
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
  stop
  Response.ContentType = "application/json"
  Response.Write "{"
  If VarType(retorno)=8 then 
      Response.Write """Erro"":""" & Replace(retorno,chr(34),chr(39)) & """"
  Else
    Response.Write """UsuId"":""" & retorno & """"
  end if
  ObjConexao.FecharConexao(cn)
  Response.Write "}" 
End Function

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


  '
  ' Função para buscar os usuários em modo de paginação Chilkat
  '
  Function CKBuscarUsuariosPaginados()
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
    '
' Retorna um usuário do Banco de dados para o cliente chilkat
'
Function CKBuscarUsuarioPorId() 
  ' // TODO - Função deve receber o objeto conexão
  '         - Função deve receber um objeto usuário preenchido com o id
  '         - Fazer tratamento de erros;
  '         - Melhorar mensagens de retorno;
  set ObjConexao = new Conexao
  set cn = ObjConexao.AbreConexao()
  set ObjUsuario = new cUsuario
  set rs = objUsuario.BuscarUsuarioPorId(cn, id)
  If Not rs.Eof Then     
    Set usuario = Server.CreateObject("Chilkat_9_5_0.JsonObject")
    success = usuario.AddIntAt(-1,"UsuId",rs("usuid"))
    success = usuario.AddStringAt(-1,"Usuario",rs("usuario"))
    success = usuario.AddStringAt(-1,"Senha",rs("senha"))
    success = usuario.AddStringAt(-1,"Nome",rs("nome"))
    success = usuario.AddStringAt(-1,"Endereco",rs("endereco"))
    success = usuario.AddStringAt(-1,"Cidade",rs("cidade"))
    success = usuario.AddStringAt(-1,"Cep",rs("cep"))   
    success = usuario.AddIntAt(-1,"Estado",rs("estadoId"))  
  End If
  rs.Close()
  ObjConexao.FecharConexao(cn)
  json.EmitCompact = 0
  Response.Write json.Emit()    
End function
%>