<%
'
'Seleção das funções a serem realizadas
'
stop
acao = Request("acao")
id =  Request("usuID")
Select Case acao
  Case "Inserir"
    Call InserirNovoUsuario()
  Case "Editar"
    Call EditarUsuario(id)
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

Function InserirNovoUsuario()
stop
  sql="INSERT INTO [dbo].[usuario] (usuario,senha,nome,endereco,cidade,cep,estadoid) VALUES ("
  sql=sql & "'" & Request.Form("txtUsuario") & "',"
  sql=sql & "'" & Request.Form("pwdSenha") & "',"
  sql=sql & "'" & Request.Form("txtNome") & "',"
  sql=sql & "'" & Request.Form("txtEndereco") & "',"
  sql=sql & "'" & Request.Form("txtCidade") & "',"
  sql=sql & "'" & Request.Form("txtCep") & "',"
  sql=sql & "'" & Request.Form("selEstados") & "')"
  on error resume next
  cn.Execute sql, recaffected
  if err<>0 then
    msg = "Registro não gravado"
    Response.Write "Erro: "&sql
    Response.Redirect("usuarioCadastro.asp?recaffected="&recaffected&"&msg="&msg)
  end if
  cn.close
  msg = "Registro gravado com sucesso"
  acao="Novo"
  Response.Redirect("usuarioCadastro.asp?acao="&acao&"&recaffected="&recaffected&"&msg="&msg)
End function

'
' Função para atualizar um usuário no banco de dados
'
Function EditarUsuario(id)
stop
  sql="UPDATE [dbo].[usuario] SET "
  sql=sql & "[usuario] = '" & Request.Form("txtUsuario") & "',"
  sql=sql & "[senha] = '" & Request.Form("pwdSenha") & "',"
  sql=sql & "[nome] = '" & Request.Form("txtNome") & "',"
  sql=sql & "[endereco] = '" & Request.Form("txtEndereco") & "',"
  sql=sql & "[cidade] = '" & Request.Form("txtCidade") & "',"
  sql=sql & "[cep] = '" & Request.Form("txtCep") & "',"
  sql=sql & "[estadoid] = '" & Request.Form("selEstados") & "'"
  sql=sql & "WHERE usuid="& id
  on error resume next
  cn.Execute sql, recaffected
  if err<>0 then
    msg = "Registro não Atualizado"
    Response.Redirect("usuarioCadastro.asp?recaffected="&recaffected&"&msg="&msg)
  end if
  cn.close
  msg = "Registro atualizado com sucesso"
  Response.Redirect("usuarioCadastro.asp?recaffected="&recaffected&"&msg="&msg)
End Function

'
'Função para exclusão de usuário
'
Function ExcluirUsuario(id)
  '
  ' TODO - Validar se o usuário não possui tarefas antes da exclusão
  '
 stop
  sql="DELETE FROM [dbo].[usuario] WHERE customerID='" & id & "'"
  on error resume next
  cn.Execute sql, recaffected
  if err<>0 then
    msg = "Registro não Excluido"
    Response.Redirect("usuarioCadastro.asp?recaffected="&recaffected&"&msg="&msg)
  end if
  cn.close
  msg = "Registro excluido com sucesso"
  Response.Redirect("usuarioCadastro.asp?recaffected="&recaffected&"&msg="&msg)
End Function
%>