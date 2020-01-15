<%
'
'Seleção das funções a serem realizadas
'
stop
acao = Request("acao")
id =  Request("tarID")
status=Request("Status")
Select Case acao
  Case "Inserir"
    Call InserirNovaTarefa()
  Case "Editar"
    Call EditarTarefa(id,status)
  Case "Excluir"
    Call ExcluirUsuario(id)
  Case else
    Call LimparCampos()
End Select

'
' Função para limpar campos da tela
' 
Function LimparCampos()
  usuario=""
  senha=""
  nome=""
  endereco=""
  cidade=""
  cep=""
  estado=""
  acao="Inserir"
End Function

'
' Função para inserir nova Tarefa
'  
Function InserirNovaTarefa()
  stop
  sql="INSERT INTO [dbo].[tarefa] ([tarTitulo],[geradorID],[tarData],[tarStatus],[tarDescricao]) VALUES ("  
  sql=sql & "'" & Request.Form("txtTitulo") & "',"
  sql=sql & "'" & Request.Form("selGerador") & "',"
  sql=sql & "'" & CDATE(Request.Form("txtData")) & "',"
  sql=sql & "'" & Request.Form("selStatus") & "',"
  sql=sql & "'" & Request.Form("txtDescricao") & "')"
  on error resume next
  cn.Execute sql, recaffected
  if err<>0 then
    msg = "Registro não gravado"
    Response.Redirect("./tarefaCadastro.asp?msg="&msg)
  end if
  cn.close
  msg = "Registro gravado com sucesso"    
  Response.Redirect("./tarefaCadastro.asp?&recaffected="&recaffected&"&msg="&msg)
End function

'
' Função para atualizar um usuário no banco de dados
'
Function EditarTarefa(id,status)
  stop
  sql="UPDATE [dbo].[tarefa] SET "
  sql=sql & "[tarStatus] = "&status
  sql=sql & " WHERE tarID="& id
  on error resume next
  cn.Execute sql, recaffected
  if err<>0 then
    msg = "Registro não Atualizado"
    Response.Redirect("tarefaCadastro.asp?recaffected="&recaffected&"&msg="&msg)
  end if
  cn.close
  msg = "Registro atualizado com sucesso"
  Response.Redirect("tarefaCadastro.asp?recaffected="&recaffected&"&msg="&msg)
End Function
%>