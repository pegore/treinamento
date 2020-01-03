<%
  Set conexaoTarefa = Server.CreateObject("ADODB.Connection")
  conexaoTarefa.Provider = "sqloledb"
  conexaoTarefa.Open("Data Source=localhost;Initial Catalog=treinamento;User Id=sa;Password=123456;")
  ' sqlTarefas = "SELECT * FROM [treinamento].[dbo].[usuario] where usuid=" & Request.QueryString("usuid")
  ' Set recordSetTarefas=Server.CreateObject("ADODB.recordset")
  ' recordSetTarefas.Open sqlTarefas, conexaoTarefa, &H0001
%>