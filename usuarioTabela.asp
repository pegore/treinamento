<%
stop
  Set cn = Server.CreateObject("ADODB.Connection")
  cn.Provider = "sqloledb"
  cn.Open("Data Source=LINO-PC;Initial Catalog=treinamento;User Id=sa;Password=123456;")    
  sql = "SELECT * FROM [treinamento].[dbo].[usuario]"
  Set rs=Server.CreateObject("ADODB.recordset")
  rs.Open sql, cn, &H0001
%>
<!DOCTYPE html>
<html lang="pt-br">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Sistema de Tarefas</title>
    <link rel="stylesheet" href="css/style.css">
</head>

<body>
  <div class="centralizar">
    <table >
      <thead>
        <tr>
        <% 
          For i=0 to rs.Fields.Count - 1
              Response.write("<th>"&rs.Fields(i).Name&"</th>")
          Next
        %>
        <th>Ações</th>
        </tr>
      </thead>
      <tbody>
        <%
            Do While Not rs.EOF
              Response.Write "<tr>" 
              for i = 0 to rs.Fields.Count - 1
                  Response.Write "<td>" & rs.Fields(i) & "</td>"
                  usuID=rs.Fields.Item(0) 
              next
              Response.Write "<th>"
              Response.Write "<a href='usuariocadastro.asp?acao=BuscaPorId&usuID="&usuID&"' >Editar</a>"
              Response.Write "<a href='usuariocadastro.asp?usuID="&usuID&"'>Excluir</a>"
              Response.Write "</th></tr>"
              rs.MoveNext
            Loop
            rs.close
            cn.close
        %>
      </tbody>
    </table>
  </div>
</body>

</html>