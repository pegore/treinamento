<%
  Set cnUser = Server.CreateObject("ADODB.Connection")
  cnUser.Provider = "sqloledb"
  cnUser.Open("Data Source=localhost;Initial Catalog=treinamento;User Id=sa;Password=123456;")
  'sqlUser = "SELECT * FROM [treinamento].[dbo].[usuario] where usuid=" & Request.QueryString("usuid")
  'Set rsUser=Server.CreateObject("ADODB.recordset")
  'rsUser.Open sqlUser, cnUser, &H0001
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

<body>
  <div class="container-fluid">
    <form name="frmTarefa" class="form-group" action="../AspPages/tarefa.asp" method="post">
      <div class="form-group row">
        <label for="txtTitulo" class="col-sm-3 col-form-label">Título:</label>
        <div class="col-sm-5">
          <input type="text" class="form-control" id="txtTitulo" name="txtTitulo" 
            placeholder="Usuário">
        </div>
      </div>
      <div class="form-group row">
        <label for="selGerador" class="col-sm-3 col-form-label">Gerador:</label>
        <div class="col-sm-5">
          <select class="form-control" id="selGerador" value="" name="selGerador">
            <option value="-1">Selecione o Gerador</option>
            <option value="1">gerador 1</option>
            <option value="2">gerador 2</option>
            <option value="3">gerador 3</option>
            <option value="4">gerador 4</option>
            <option value="5">gerador 5</option>
            <option value="6">gerador 6</option>
          </select>
        </div>
      </div>
      <div class="form-group row">
        <label for="txtDescricao" class="col-sm-3 col-form-label">Descrição:</label>
        <div class="col-sm-5">
          <textarea class="form-control" id="txtDescricao" rows="5" placeholder="Descrição da tarefa"></textarea>
        </div>
      </div>
      <div class="form-group row">
        <label for="txtData" class="col-sm-3 col-form-label">Data:</label>
        <div class="col-sm-5">
          <input type="date" class="form-control" id="txtData" name="txtData" placeholder="Data">
        </div>
      </div>
      <div class="form-group row">
        <label for="selStatus" class="col-sm-3 col-form-label">Status:</label>
        <div class="col-sm-5">
          <select class="form-control" id="selStatus" name="selStatus">
            <option value="-1">Selecione o Status</option>
            <option value="0">Não Iniciado</option>
            <option value="1">Em andamento</option>
            <option value="7">Cancelada</option>
            <option value="9">Concluída</option>
          </select>
        </div>
      </div>
      <div class="row">
        <div class="col-sm-12">
          <button type="submit" class="btn btn-primary">Cadastrar</button>
        </div>
      </div>
    </form>
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
    <script src="../Scripts/tarefaCadastro.js"></script>

</body>

</html>