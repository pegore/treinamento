<%
  Set cn = Server.CreateObject("ADODB.Connection")
  cn.Provider = "sqloledb"
  cn.Open("Data Source=localhost;Initial Catalog=treinamento;User Id=sa;Password=123456;")    
  sql = "SELECT * FROM [treinamento].[dbo].[usuario]"
  Set rs=Server.CreateObject("ADODB.recordset")
  rs.Open sql, cn, &H0001
%>
<!doctype html>
<html lang="pt-br">

<head>
  <title>Title</title>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

  <!-- Bootstrap CSS -->
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
    integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
  <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" type="text/css" rel="stylesheet">
  <link href="../css/style.css" rel="stylesheet">
</head>

<body class="text-center">
  <div class="container-fluid">
    <table class="table table-bordered table-striped">
      <thead>
        <tr>
        <% 
          For i=0 to rs.Fields.Count - 1
              Response.write("<th scope='col'>"&rs.Fields(i).Name&"</th>")
          Next
        %>
        <th scope='col'>Ações</th>
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
              Response.Write "<th scope='col'>"
              Response.Write "<a href='usuariocadastro.asp?usuID="&usuID&"&acao=Editar' class='fa fa-fw fa-edit'></a>"
              Response.Write "<a href='usuariocadastro.asp?usuID="&usuID&"&acao=Excluir' class='fa fa-fw fa-trash'></a>"
              Response.Write "</th></tr>"
              rs.MoveNext
            Loop
            rs.close
            cn.close
        %>
      </tbody>
    </table>
  </div>

  <!-- Optional JavaScript -->
  <!-- jQuery first, then Popper.js, then Bootstrap JS -->
  <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
    integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
    crossorigin="anonymous"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
    integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
    crossorigin="anonymous"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
    integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
    crossorigin="anonymous"></script>
</body>

</html>