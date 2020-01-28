<!--#include file="../Models/Conexao.class.asp"-->
<!--#include file="../Models/Usuario.class.asp"-->
<!--#include file="../Models/Tarefa.class.asp"-->
<%
' // TODO - Criar uma função de retorno de mensagens
'         - Criar uma função de retorno de erros
  Response.CodePage = 65001
  Response.CharSet = "UTF-8"
  '
  'Seleção das funções a serem realizadas
  '
  If Request("fnTarget")<>"" Then
    ' // TODO - Melhorar a recepção do front-end:
    '         - Selecionar melhor a função
    '         - Criar um objeto Tarefa e um objeto conexão
    '         - Receber parametros em cada função
    dim palavraParaPesquisa
    dim registrosPorPagina 
    dim paginaPesquisa
    dim idTarefa : idTarefa =  Request("idTarefa")
    dim fnTarget : fnTarget = Request("fnTarget")
    if(IsNumeric(Request("paginaPesquisa"))) then
      paginaPesquisa = Cint(Request("paginaPesquisa"))
    end if
    if(IsNumeric(Request("registrosPorPagina"))) then
      registrosPorPagina = Cint(Request("registrosPorPagina"))
    end if
    Execute(fnTarget)
  End if


'
' Função para inserir nova Tarefa
'  
Function CadastrarTarefa() 
  ' // TODO - Criar Função de validação dos dados;
  '         - Função deve receber o objeto tarefa;
  '         - Função deve receber o objeto conexão;
  '         - Melhorar o tratamento de erros;
  '         - Melhorar mensagens de retorno;
  set ObjTarefa = new cTarefa
  ObjTarefa.setId(Request("IdTarefa"))
  ObjTarefa.setTitulo(Request("Titulo"))
  ObjTarefa.setGeradorId(Request("Gerador"))
  ObjTarefa.setDataGeracao(FormatarDataBanco(Request("DataGeracao")))
  ObjTarefa.setStatus(Request("Status"))
  ObjTarefa.setDescricao(Request("Descricao"))
  set ObjConexao = new Conexao
  set cn = ObjConexao.AbreConexao()
  retorno = objTarefa.InsercaoTarefa(cn, ObjTarefa)
  Response.ContentType = "application/json"
  Response.Write "{"
  If VarType(retorno)=8 then 
      Response.Write """Erro"":""" & Replace(retorno,chr(34),chr(39)) & """"
  Else
    Response.Write """IdTarefa"":""" & retorno & """"
  end if
  Response.Write "}"
  ObjConexao.FecharConexao(cn)
End Function

'
' Função para atualizar um usuário no banco de dados
'
Function AlterarStatus()
  set ObjTarefa = new cTarefa
  ObjTarefa.setId(idTarefa)
  ObjTarefa.setStatus(Request("Status"))
  set ObjConexao = new Conexao
  set cn = ObjConexao.AbreConexao()
  retorno = ObjTarefa.AlterarStatus(cn, ObjTarefa)
  Response.ContentType = "application/json"
  Response.Write "{"
  If VarType(retorno)=8 then ' Se for String - Não é a melhor forma mas foi o que consegui fazer
      Response.Write """Erro"":""" & Replace(retorno,chr(34),chr(39)) & """"
  Else
    Response.Write """IdTarefa"":""" & retorno & """"
  end if
  Response.Write "}" 
  ObjConexao.FecharConexao(cn)
End Function

Function EditarTitulo()
  set ObjTarefa = new cTarefa
  ObjTarefa.setId(idTarefa)
  ObjTarefa.setTitulo(Request("Titulo"))
  set ObjConexao = new Conexao
  set cn = ObjConexao.AbreConexao()
  retorno = ObjTarefa.UpdateTitulo(cn, ObjTarefa)
  Response.ContentType = "application/json"
  Response.Write "{"
  If VarType(retorno)=8 then ' Se for String - Não é a melhor forma mas foi o que consegui fazer
      Response.Write """Erro"":""" & Replace(retorno,chr(34),chr(39)) & """"
  Else
    Response.Write """IdTarefa"":""" & retorno & """"
  end if
  Response.Write "}" 
  ObjConexao.FecharConexao(cn)
End Function
'
' Função para atualizar um usuário no banco de dados
'
Function EditarTarefa()
  set ObjTarefa = new cTarefa
  ObjTarefa.setId(idTarefa)
  ObjTarefa.setTitulo(Request("Titulo"))
  ObjTarefa.setGeradorId(Request("Gerador"))
  ObjTarefa.setDataGeracao(FormatarDataBanco(Request("DataGeracao")))
  ObjTarefa.setStatus(Request("Status"))
  ObjTarefa.setDescricao(Request("Descricao"))
  set ObjConexao = new Conexao
  set cn = ObjConexao.AbreConexao()
  retorno = ObjTarefa.UpdateTarefa(cn, ObjTarefa)
  Response.ContentType = "application/json"
  Response.Write "{"
  If VarType(retorno)=8 then ' Se for String - Não é a melhor forma mas foi o que consegui fazer
      Response.Write """Erro"":""" & Replace(retorno,chr(34),chr(39)) & """"
  Else
    Response.Write """IdTarefa"":""" & retorno & """"
  end if
  Response.Write "}" 
  ObjConexao.FecharConexao(cn)
End Function
'
' Função para atualizar um usuário no banco de dados
'
Function ExcluirTarefa()
  set ObjTarefa = new cTarefa
  set ObjConexao = new Conexao
  set cn = ObjConexao.AbreConexao()
  retorno = ObjTarefa.ExcluirTarefa(cn, idTarefa)
  Response.ContentType = "application/json"
  Response.Write "{"
  If VarType(retorno)=8 then ' Se for String - Não é a melhor forma mas foi o que consegui fazer
      Response.Write """Erro"":""" & Replace(retorno,chr(34),chr(39)) & """"
  Else
    Response.Write """IdTarefa"":""" & retorno & """"
  end if
  Response.Write "}" 
  ObjConexao.FecharConexao(cn)
End Function

  Function BuscarTarefasPaginada()
    Dim numeroTotalRegistros
    Dim numeroTotalPaginas
    Dim colunaOrdenacao: colunaOrdenacao = "tarID"
    set ObjConexao = new Conexao
    set cn = ObjConexao.AbreConexao()
    set ObjTarefa = new cTarefa
    set rs = ObjTarefa.BuscarTarefas(cn, palavraParaPesquisa, colunaOrdenacao, paginaPesquisa, registrosPorPagina)  
    If Not rs.Eof Then
      numeroTotalPaginas = rs.PageCount
      rs.PageSize = registrosPorPagina
      numeroTotalRegistros=rs.RecordCount
      If paginaPesquisa < 1 Or paginaPesquisa > numeroTotalPaginas Then
        paginaPesquisa = 1			
      End If    
      rs.AbsolutePage = paginaPesquisa
      Response.ContentType = "application/json"
      Response.Write "{"
      Response.Write """TotalRegistros"":""" & numeroTotalRegistros & ""","
      Response.Write """RegistrosPorPagina"":""" & registrosPorPagina & ""","
      Response.Write """PaginaAtual"":""" & paginaPesquisa & ""","
      Response.Write """TotalPaginas"":""" & numeroTotalPaginas & ""","
      Response.Write """Registros"": ["
      Do While Not (rs.Eof OR rs.AbsolutePage <> paginaPesquisa)
        Response.Write "{"
        Response.Write """IdTarefa"": """ & rs("tarID") & ""","
        Response.Write """Titulo"": """ & rs("tarTitulo") & ""","
        Response.Write """Descricao"": """ & rs("tarDescricao") & ""","
        Response.Write """DataGeracao"": """ & rs("tarData") & ""","
        Response.Write """Status"": """ & rs("tarStatus") & """"
        Response.Write "}"
        if rs.AbsolutePosition < registrosPorPagina and rs.AbsolutePosition < numeroTotalRegistros then
          Response.Write ","
        end if
        rs.MoveNext
        Loop
    End If
    Response.Write "]"
    Response.Write "}"
    rs.close()
    ObjConexao.FecharConexao(cn)
End Function

'
' Retorna uma tarefa do Banco de dados para o cliente response write
'
  Function BuscarTarefaPorId()
    ' // TODO - Função deve receber o objeto conexão
    '         - Função deve receber um objeto usuário preenchido com o id
    '         - Fazer tratamento de erros;
    '         - Melhorar mensagens de retorno;
    set ObjConexao = new Conexao
    set cn = ObjConexao.AbreConexao()
    set ObjTarefa = new cTarefa
    set rs = ObjTarefa.BuscarTarefaPorId(cn, idTarefa)
    If Not rs.Eof Then
      Response.ContentType = "application/json"
      Response.Write "{"
      Response.Write """IdTarefa"": """ & rs("tarID") & ""","
      Response.Write """Titulo"": """ & rs("tarTitulo") & ""","
      Response.Write """Descricao"": """ & rs("tarDescricao") & ""","
      Response.Write """DataGeracao"": """ & FormatarDataTela(rs("tarData")) & ""","
      Response.Write """Status"": """ & rs("tarStatus") & ""","
      Response.Write """Gerador"": """ & rs("geradorID") & """"
      Response.Write "}"        
    End If
    rs.Close()
    ObjConexao.FecharConexao(cn)
  End function
  
  Function FormatarDataTela(dataSemFormato)
    soHora = split(dataSemFormato," ")
    hora = "00:00"
    if (UBound(soHora)>0) then
      hora = soHora(1)
    end if
    d = split(soHora(0),"/")
    FormatarDataTela = d(2) & "-" & d(1) & "-" & d(0) & "T" & hora
  End Function
 
  Function FormatarDataBanco(dataSemFormato)
    soHora = split(dataSemFormato,"T")
    d = split(soHora(0),"-")
    FormatarDataBanco = d(0) & "-" & d(2) & "-" & d(1) & " " & soHora(1)
  End Function
%>