<%
'
'Seleção das funções a serem realizadas
'
acao = Request("acao")
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
' Cria a conexao com o banco de dados
'
Function CriaConexao()
  Set conexaoUsuario = Server.CreateObject("ADODB.Connection")
  conexaoUsuario.Provider = "sqloledb"
  conexaoUsuario.Open("Data Source=localhost;Initial Catalog=treinamento;User Id=sa;Password=123456;")
  CriaConexao = conexaoUsuario  
End Function
  
Function InserirNovaTarefa()
  Set cn = Server.CreateObject("ADODB.Connection")
  cn.Provider = "sqloledb"
  cn.Open("Data Source=localhost;Initial Catalog=treinamento;User Id=sa;Password=123456;")
  sql="INSERT INTO [dbo].[tarefa]([tarTitulo],[geradorID],[tarData],[tarStatus],[tarDescricao]) VALUES ("  
  sql=sql & "'" & Request.Form("txtTitulo") & "',"
  sql=sql & "'" & Request.Form("selGerador") & "',"
  sql=sql & "'" & Request.Form("txtData") & "',"
  sql=sql & "'" & Request.Form("selStatus") & "',"
  sql=sql & "'" & Request.Form("txtDescricao") & "')"
  on error resume next
  cn.Execute sql, recaffected
  if err<>0 then
    msg = "Registro não gravado"
    Response.Redirect("./tabelaCadastro.asp?msg="&msg)
  end if
  cn.close
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

%>