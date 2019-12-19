<%
if not isempty(request.Form) then
    'abrindo conexão
    Set cn = Server.CreateObject("ADODB.Connection")
    cn.Provider = "sqloledb"
    cn.Open("Data Source=localhost;Initial Catalog=treinamento;User Id=sa;Password=123456;")
    dim fUsuario
    dim fpassword
    fUsuario=Request.Form("txtUsuario")
    fpassword=Request.Form("pwdSenha")
    If fUsuario<>"" Then
        set rs=cn.Execute("SELECT usuario,senha FROM [treinamento].[dbo].[usuario] where usuario='" & fUsuario & "' and senha='" & fpassword & "'")
        set rs1=cn.Execute("SELECT * FROM [treinamento].[dbo].[estado]")
        Response.Write rs1.Fields.Count        
        do until rs1.EOF
            Response.Write(" ")
            For Each x in rs1.Fields
                ' body
                Response.Write(x.value)
            Next
            Response.Write("<br/>")
            rs1.MoveNext
        loop
    End If
    
End If
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
</head>

<body>
    <div class="container-fluid">       
    <table class="table-bordered">
    <thead>
        <tr>
        <th scope="col">Código</th>
        <th scope="col">Descrição</th>
        </tr>
    </thead>
        <%do until rs.EOF%>
            <tr>
                <%for each x in rs.Fields%>
                    <td><%Response.Write(x.value)%></td>
                <%next
                rs.MoveNext%>
            </tr>
        <%loop
        rs.close
        cn.close
        %>
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
