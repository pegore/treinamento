<%
  Set cnUser = Server.CreateObject("ADODB.Connection")
  cnUser.Provider = "sqloledb"
  cnUser.Open("Data Source=localhost;Initial Catalog=treinamento;User Id=sa;Password=123456;")
  sqlUser = "SELECT * FROM [treinamento].[dbo].[usuario] where usuid=" & Request.QueryString("usuid")
  Set rsUser=Server.CreateObject("ADODB.recordset")
  rsUser.Open sqlUser, cnUser, &H0001
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
  <link href="../css/style.css" rel="stylesheet">
</head>
<body class="text-center">
    <form name="frmUser" class="text-center" action="../AspPages/user.asp" method="post">
      <div class="form-group row">
        <label for="txtUsuario" class="col-sm-3 col-form-label">Usuário:</label>
        <div class="col-sm-3">
          <input type="text" class="form-control" id="txtUsuario" name="txtUsuario" value="<%=rsUser.Fields.Item(1)%>" placeholder="Usuário">
        </div>
        <label for="pwdSenha" class="col-sm-3 col-form-label">Senha:</label>
        <div class="col-sm-3">
          <input type="password" class="form-control" id="pwdSenha" name="pwdSenha" value="<%=rsUser.Fields.Item(2)%>" placeholder="Senha">
        </div>
      </div>
      <div class="form-group row">
        <label for="txtNome" class="col-sm-3 col-form-label">Nome:</label>
        <div class="col-sm-9">
          <input type="text" class="form-control" id="txtNome" name="txtNome" value="<%=rsUser.Fields.Item(3)%>" placeholder="Nome">
        </div>
      </div>
      <div class="form-group row">
        <label for="txtEndereco" class="col-sm-3 col-form-label">Endereço:</label>
        <div class="col-sm-3">
          <input type="text" class="form-control" id="txtEndereco" name="txtEndereco" value="<%=rsUser.Fields.Item(4)%>" placeholder="Endereço">
        </div>
        <label for="txtCidade" class="col-sm-3 col-form-label">Cidade:</label>
        <div class="col-sm-3">
          <input type="text" class="form-control" id="txtCidade" name="txtCidade" value="<%=rsUser.Fields.Item(5)%>" placeholder="Cidade">
        </div>
      </div>
      <div class="form-group row">
        <label for="txtCep" class="col-sm-3 col-form-label">Cep:</label>
        <div class="col-sm-3">
          <input type="text" class="form-control" id="txtCep" name="txtCep" value="<%=rsUser.Fields.Item(6)%>" placeholder="CEP">
        </div>
        <label for="txtCidade" class="col-sm-3 col-form-label">Estado:</label>
        <div class="col-sm-3">          
          <select class="form-control" id="selEstados" value="<%=rsUser.Fields.Item(7)%>"name="selEstados">
            <%
              Set cnEst = Server.CreateObject("ADODB.Connection")
              cnEst.Provider = "sqloledb"
              cnEst.Open("Data Source=localhost;Initial Catalog=treinamento;User Id=sa;Password=123456;")
              sqlEst = "SELECT * FROM [treinamento].[dbo].[estado]"
              Set rsEst=Server.CreateObject("ADODB.recordset")
              rsEst.Open sqlEst, cnEst, &H0001
              do until rsEst.EOF
                for each x in rsEst.Fields
                    value = rsEst("estadoid")
                    text = rsEst("nome")
                Next
                Response.write("<option value="&value&">"&text&"</option>")
                rsEst.MoveNext
              loop
              rsEst.Close
              cnEst.close
            %>
          </select>
        </div>
      </div>
      <div class="row">
        <div class="col-sm-12">
          <button type="submit" class="btn btn-primary">Cadastrar</button>
        </div>
      </div>
      <%
        cnUser.close
      %>
    </form>

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