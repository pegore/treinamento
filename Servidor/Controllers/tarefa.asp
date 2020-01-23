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
    dim RegistrosPorPagina 
    dim PaginaPesquisa
    dim idTarefa : idTarefa =  Request("idTarefa")
    dim fnTarget : fnTarget = Request("fnTarget")
    if(IsNumeric(Request("PaginaPesquisa"))) then
      PaginaPesquisa = Cint(Request("PaginaPesquisa"))
    end if
    if(IsNumeric(Request("RegistrosPorPagina"))) then
      RegistrosPorPagina = Cint(Request("RegistrosPorPagina"))
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
  stop 
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
    Response.Write """UsuId"":""" & retorno & """"
  end if
  Response.Write "}"
  ObjConexao.FecharConexao(cn)
End Function

' '
' ' Função para atualizar um usuário no banco de dados
' '
' Function EditarTarefa(id,status)
'   stop
  
' End Function

  Function BuscarTarefasPaginada()
    Dim numeroTotalRegistros
    Dim numeroTotalPaginas
    set ObjConexao = new Conexao
    set cn = ObjConexao.AbreConexao()
    set ObjTarefa = new cTarefa
    set rs = ObjTarefa.BuscarTarefas(cn, palavraParaPesquisa)  
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
        Response.Write """IdTarefa"": """ & rs("tarID") & ""","
        Response.Write """Titulo"": """ & rs("tarTitulo") & ""","
        Response.Write """Descricao"": """ & rs("tarDescricao") & ""","
        Response.Write """DataGeracao"": """ & rs("tarData") & ""","
        Response.Write """Status"": """ & rs("tarStatus") & """"
        Response.Write "}"
        if rs.AbsolutePosition < numeroTotalRegistros then
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
' Retorna um usuário do Banco de dados para o cliente response write
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
    d = split(soHora(0),"/")
    FormatarData = d(2) & "-" & d(0) & "-" & d(1) & "T" & soHora(1)
  End Function
 
  Function FormatarDataBanco(dataSemFormato)
  stop
    soHora = split(dataSemFormato,"T")
    d = split(soHora(0),"-")
    FormatarData = d(2) & "-" & d(0) & "-" & d(1) & " " & soHora(1)
  End Function
%>