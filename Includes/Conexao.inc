<%
  Set cn = Server.CreateObject("ADODB.Connection")
  cn.Provider = "sqloledb"
  cn.Open("Data Source=LINO-PC;Initial Catalog=treinamento;User Id=sa;Password=123456;")
%>