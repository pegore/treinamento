<!--#include file="../Models/Conexao.class.asp"-->
<!--#include file="../Models/Usuario.class.asp"-->
<%
  Response.CodePage = 65001
  Response.CharSet = "UTF-8"
  Response.ContentType = "application/json"
  dim IdUsuario: IdUsuario = Request("usuid")
  set ObjUsuario = new cUsuario
  set ObjConexao = new Conexao
  set cn = ObjConexao.AbreConexao()
  If IdUsuario<>"" Then
    ObjUsuario.setId(IdUsuario)
  End if

  '
  'Seleção das funções a serem realizadas
  '
  If Request("fnTarget")<>"" Then
    Execute(Request("fnTarget"))
    if cn.state = 1 then
      ObjConexao.FecharConexao(cn)
    end if
  End if

  Function SalvarUsuario()
    ObjUsuario.setUsuario(Request("usuario"))
    ObjUsuario.setSenha(Request("senha"))
    ObjUsuario.setNome(Request("nome"))
    ObjUsuario.setEndereco(Request("endereco"))
    ObjUsuario.setCidade(Request("cidade"))
    ObjUsuario.setCep(Request("cep"))
    ObjUsuario.setIdEstado(Request("estado"))
    Set json = Server.CreateObject("Chilkat_9_5_0.JsonObject")
    if not UsuarioValido(ObjUsuario) then     
      success = json.AddStringAt(-1,"Erro","Usuário não pode ter campos vazios")
      Response.Redirect("usuarioCadastro.asp?UsuId=" + IdUsuario)
    end if
    if (objUsuario.getId()=0) then
      retorno = objUsuario.InsercaoUsuario(cn, ObjUsuario)  
    else
      retorno = objUsuario.UpdateUsuario(cn, ObjUsuario)
    end if
    If VarType(retorno)=8 then ' Se for String - Não é a melhor forma mas foi o que consegui fazer
      success = json.AddStringAt(-1,"Erro",Replace(retorno,chr(34),chr(39)))
    Else
      success = json.AddStringAt(-1,"UsuId",retorno)
    end if
    json.EmitCompact = 0
    Response.Write json.Emit()    
  End Function  

  '
  'Função para exclusão de usuário
  '
  Function ExcluirUsuario() 
    '
    ' TODO - Validar se o usuário não possui tarefas antes da exclusão
    '
    retorno = objUsuario.ExcluirUsuario(cn, IdUsuario)
    Response.Write "{"
    If VarType(retorno)=8 then ' Se for String - Não é a melhor forma mas foi o que consegui fazer
        Response.Write """Erro"":""" & Replace(retorno,chr(34),chr(39)) & """"
    Else
      Response.Write """RegistrosAfetados"":""" & retorno & """"
    end if
    Response.Write "}"
  End Function

  '
  ' Função para buscar os usuários em modo de paginação
  '
  Function BuscarUsuariosPaginados()  
    dim paginaPesquisa : paginaPesquisa = 0
    dim registrosPorPagina : registrosPorPagina = 0
    dim colunaOrdenacao : colunaOrdenacao = "tarID"
    dim palavraParaPesquisa:palavraParaPesquisa = Request("palavraParaPesquisa")
    if(IsNumeric(Request("paginaPesquisa"))) then
      paginaPesquisa = Cint(Request("paginaPesquisa"))
    end if
    if(IsNumeric(Request("registrosPorPagina"))) then
      registrosPorPagina = Cint(Request("registrosPorPagina"))
    end if
    if (Request("colunaOrdenacao")<>"")then
      colunaOrdenacao = Request("colunaOrdenacao")
    end if   
    set rs = ObjUsuario.BuscarUsuarios(cn,palavraParaPesquisa)  
    If Not rs.Eof Then
      rs.PageSize = registrosPorPagina
      Dim numeroTotalPaginas : numeroTotalPaginas = rs.PageCount
      Dim numeroTotalRegistros : numeroTotalRegistros = rs.RecordCount
      If paginaPesquisa < 1 Then
        paginaPesquisa = 1			
      End If
      if paginaPesquisa > numeroTotalPaginas then
        paginaPesquisa = numeroTotalPaginas
      end if
      rs.AbsolutePage = paginaPesquisa
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
        success = usuario.AddStringAt(-1,"Nome",rs("nome"))
        success = usuario.AddStringAt(-1,"Endereco",rs("endereco"))
        success = usuario.AddStringAt(-1,"Cidade",rs("cidade"))
        success = usuario.AddStringAt(-1,"Cep",rs("cep"))     
        success = usuario.AddIntAt(-1,"UsuId",rs("usuid"))
        rs.MoveNext
      Loop
    End If
    rs.close()
    json.EmitCompact = 0
    Response.Write json.Emit()    
  End function

  '
  ' Função para buscar os usuários geradores para a tarefa
  '
  Function BuscarGeradores()
    set rs = ObjUsuario.BuscarUsuarios(cn, palavraParaPesquisa)  
    If Not rs.Eof Then
      Set json = Server.CreateObject("Chilkat_9_5_0.JsonObject")
      success = json.AddArrayAt(-1,"Registros")
      Set aRegistros = json.ArrayAt(json.Size - 1)
      Do While Not (rs.Eof)
        success = aRegistros.AddObjectAt(-1)
        Set usuario = aRegistros.ObjectAt(aRegistros.Size - 1)
        success = usuario.AddIntAt(-1,"UsuId",rs("usuid"))
        success = usuario.AddStringAt(-1,"Nome",rs("nome"))      
        rs.MoveNext
        Loop
    End If
    rs.close()
    json.EmitCompact = 0
    Response.Write json.Emit()    
  End Function

  '
  ' Retorna um usuário do Banco de dados para o cliente
  '
  Function BuscarUsuarioPorId() 
    set rs = objUsuario.BuscarUsuarioPorId(cn, IdUsuario)
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
    rs.close()
    usuario.EmitCompact = 0
    Response.Write usuario.Emit()    
  End function

'
' Função para validar objeto usuário para as funções de cadastrar e alterar usuários
'
  Function UsuarioValido(ObjetoUsuario)
    UsuarioValido = true
    If (ObjetoUsuario.getUsuario()="") Then
      UsuarioValido = false
    End If
    If (ObjetoUsuario.getSenha()="") Then
      UsuarioValido = false
    End If
    If (ObjetoUsuario.getNome()="") Then
      UsuarioValido = false
    End If
    If (ObjetoUsuario.getEndereco()="") Then
      UsuarioValido = false
    End If
    If (ObjetoUsuario.getCidade()="") Then
      UsuarioValido = false
    End If
    If (ObjetoUsuario.getCep()="") Then
      UsuarioValido = false
    End If
    If ( ObjetoUsuario.getIdEstado()="") Then
      UsuarioValido = false
    End If   
  End Function  
%>