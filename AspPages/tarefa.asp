<%
'
'Seleção das funções a serem realizadas
'
stop
acao = Request("acao")
acao = "BuscaPorId"
id = 1' Request("usuID")
Select Case acao
  Case "Inserir"
    Call InserirNovaTarefa()
  Case "Editar"
    Call EditarUsuario(id)
  Case "Excluir"
    Call ExcluirUsuario(id)
  Case "BuscaPorId"
    Call BuscaPorId(id)
  Case "Pesquisa"
    Call PesquisaUsuarios()  
  Case else
    Call LimparCampos()
End Select

'
' Função para inserir nova Tarefa
'  
Function InserirNovaTarefa()
  Set conexaoTarefa = Server.CreateObject("ADODB.Connection")
  conexaoTarefa.Provider = "sqloledb"
  conexaoTarefa.Open("Data Source=localhost;Initial Catalog=treinamento;User Id=sa;Password=123456;")
  sql="INSERT INTO [dbo].[tarefa]([tarTitulo],[geradorID],[tarData],[tarStatus],[tarDescricao]) VALUES ("  
  sql=sql & "'" & Request.Form("txtTitulo") & "',"
  sql=sql & "'" & Request.Form("selGerador") & "',"
  sql=sql & "'" & Request.Form("txtData") & "',"
  sql=sql & "'" & Request.Form("selStatus") & "',"
  sql=sql & "'" & Request.Form("txtDescricao") & "')"
  on error resume next
  conexaoTarefa.Execute sql, recaffected
  if err<>0 then
    msg = "Registro não gravado"
    Response.Redirect("./tabelaCadastro.asp?msg="&msg)
  end if
  conexaoTarefa.close
  msg = "Registro gravado com sucesso"    
  Response.Redirect("./tarefaCadastro.asp?&recaffected="&recaffected&"&msg="&msg)
End function

Function LimparCampos()
  usuario=""
  senha=""
  nome=""
  endereco=""
  cidade=""
  cep=""
  estado=""
  
End Function

Function BuscaPorId(id)
stop
  Set conexaoTarefa = Server.CreateObject("ADODB.Connection")
  conexaoTarefa.Provider = "sqloledb"
  conexaoTarefa.Open("Data Source=localhost;Initial Catalog=treinamento;User Id=sa;Password=123456;")
  queryTarefa = "SELECT tar.tarID,tar.tarTitulo,us.nome,tar.tarData,tar.tarStatus FROM [treinamento].[dbo].[tarefa] as tar left join [treinamento].[dbo].[usuario] as us on tar.geradorID=us.usuid where usuid="&id
  Set recordSetTarefas=Server.CreateObject("ADODB.recordset")
  recordSetTarefas.Open queryTarefa, conexaoTarefa, &H0001
  id=recordSetTarefas("tarId")
  titulo=recordSetTarefas("tarTitulo")
  nomeUsuario=recordSetTarefas("nome")
  dataAbertura=recordSetTarefas("tarData")
  status=recordSetTarefas("tarStatus")
  recordSetTarefas.Close
  conexaoTarefa.close   
End Function

%>