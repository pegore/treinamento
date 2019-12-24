<%
'
'Seleção das funções a serem realizadas
'
acao = Request.QueryString("acao")
id = Request.QueryString("usuid")
Select Case acao
  Case "BuscaPorId"
    Call BuscaPorId(id)
  Case "Inserir"
    Call InserirNovoUsuario()
  Case "Editar"
    Call EditarUsuario(id)
  Case "Excluir"
    Call ExcluirUsuario(id)
  Case "Listar"
    Call ListarUsuarios()
  Case else
    Call MsgRetorno("Ação Inválida!!!")
End Select

'
'
'
Function MsgRetorno(msg)
  Set jsonRetorno = Server.CreateObject("Chilkat_9_5_0.JsonObject")
  index = -1   
  success = jsonRetorno.AddStringAt(-1,"Mensagem",msg)
  success = jsonRetorno.AddStringAt(-1,"acao",acao)  
  success = jsonRetorno.AddStringAt(-1,"id",id)
  jsonRetorno.EmitCompact = 0
  Response.Write jsonRetorno.Emit()  
End Function

'
' Função para cadastro de novo usuário
' 
Function InserirNovoUsuario()
  Set cn = Server.CreateObject("ADODB.Connection")
  cn.Provider = "sqloledb"
  cn.Open("Data Source=localhost;Initial Catalog=treinamento;User Id=sa;Password=123456;")    
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
    Response.Write("Sem permissão para inserir usuários!")
    Response.Redirect("../AspPages/usuarioCadastro.asp")
  end if
  cn.close
  Response.Redirect("../AspPages/usuarioCadastro.asp?recaffected="&recaffected)
End function

'
' Função para buscar e retornar um usuario
'
Function BuscaPorId(id)
  Set conexaoUsuario = Server.CreateObject("ADODB.Connection")
  conexaoUsuario.Provider = "sqloledb"
  conexaoUsuario.Open("Data Source=localhost;Initial Catalog=treinamento;User Id=sa;Password=123456;")
  queryUsuarioById = "SELECT * FROM [treinamento].[dbo].[usuario] as us left join [treinamento].[dbo].[estado] as es on us.estadoid=es.estadoid where usuid="&id
  Set recorSetUsuario=Server.CreateObject("ADODB.recordset")
  recorSetUsuario.Open queryUsuarioById, conexaoUsuario, &H0001
  Set json = Server.CreateObject("Chilkat_9_5_0.JsonObject")
  index = -1   
  success = json.AddStringAt(-1,"txtUsuario",recorSetUsuario.Fields(1))
  success = json.AddStringAt(-1,"pwdSenha",recorSetUsuario.Fields(2))
  success = json.AddStringAt(-1,"txtNome",recorSetUsuario.Fields(3))
  success = json.AddStringAt(-1,"txtEndereco",recorSetUsuario.Fields(4))
  success = json.AddStringAt(-1,"txtCidade",recorSetUsuario.Fields(5))
  success = json.AddStringAt(-1,"txtCep",recorSetUsuario.Fields(6))
  success = json.AddIntAt(-1,"selEstados",recorSetUsuario.Fields(7))  
  recorSetUsuario.Close
  conexaoUsuario.close
  json.EmitCompact = 0
  Response.Write json.Emit()
End Function

'
' Função para atualizar um usuário no banco de dados
'
Function EditarUsuario(id)
  Set cn = Server.CreateObject("ADODB.Connection")
  cn.Provider = "sqloledb"
  cn.Open("Data Source=localhost;Initial Catalog=treinamento;User Id=sa;Password=123456;")    
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
  cn.Execute sql
  if err<>0 then
    Response.Write("Sem permissão para editar usuários!")
    Response.Redirect("../Usuario.html")
  end if
  cn.close
  Response.Redirect("../UsuarioTabela.html")
End Function

'
'Função para exclusão de usuário
'
Function ExcluirUsuario(id)
  '
  ' TODO - Validar se o usuário não possui tarefas antes da exclusão
  '
  Set cn = Server.CreateObject("ADODB.Connection")
  cn.Provider = "sqloledb"
  cn.Open("Data Source=localhost;Initial Catalog=treinamento;User Id=sa;Password=123456;")  
  sql="DELETE FROM [dbo].[usuario] WHERE customerID='" & id & "'"
  on error resume next
  cn.Execute sql
  if err<>0 then
    Response.Write("Sem permissão para excluir usuário!")
    Response.Redirect("../Usuario.html")
  end if
  cn.close
  Response.Redirect("../UsuarioTabela.html")
End Function
'
' Lista usuários para a tabela
'
Function ListarUsuarios()
  Set cn = Server.CreateObject("ADODB.Connection")
  cn.Provider = "sqloledb"
  cn.Open("Data Source=localhost;Initial Catalog=treinamento;User Id=sa;Password=123456;")    
  sql = "SELECT * FROM [treinamento].[dbo].[usuario]"
  Set rs=Server.CreateObject("ADODB.recordset")
  rs.Open sql, cn, &H0001
'criar objeto json
' preencher o json
' retornar ojson
  Do While Not rs.EOF
    for i = 0 to rs.Fields.Count - 1
        rs.Fields(i)
        usuID=rs.Fields.Item(0) 
    next
    rs.MoveNext
  Loop
  rs.close
  cn.close
%>