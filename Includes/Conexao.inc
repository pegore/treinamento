<%
  stop
  dim stringConexao : stringConexao = "Data Source=localhost;Initial Catalog=treinamento;User Id=sa;Password=123456;"                  
  Set cn = Server.CreateObject("ADODB.Connection")
  cn.Provider = "sqloledb"
  cn.Open(stringConexao)
%>