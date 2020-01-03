<%
  Set cn = Server.CreateObject("ADODB.Connection")
  cn.Provider = "sqloledb"
  cn.Open("Data Source=localhost;Initial Catalog=treinamento;User Id=sa;Password=123456;")    
  sql = "SELECT tar.tarID,tar.tarTitulo,us.nome,tar.tarData,tar.tarStatus FROM [treinamento].[dbo].[tarefa] as tar left join [treinamento].[dbo].[usuario] as us on tar.geradorID=us.usuid"
  Set rs=Server.CreateObject("ADODB.recordset")
  rs.Open sql, cn, &H0001
%>
<!doctype html>
<html lang="pt-br">

<head>
 <!--#include file="./Includes/HtmlSecaoHead.inc"--> 
</head>
 <!--#include file="./Includes/TopMenu.inc"-->
<main class="col-12">
    <div class="centralizar">
      <table class="table">
        <caption >
          <a href="tarefaCadastro.asp">Nova Tarefa</a>
        </caption>
        <thead>
          <tr>
            <th>N°</th>
            <th>Título</th>
            <th>Usuário Gerador</th>
            <th>Data de Abertura</th>
            <th>Status</th>
          </tr>
        </thead>
        <tbody>
        <%
          Do Until rs.EOF
            Response.Write "<tr>"
            Response.Write "<td>" & rs("tarID") & "</td>"
            Response.Write "<td>" & rs("tarTitulo") & "</td>"
            Response.Write "<td>" & rs("nome") & "</td>"
            Response.Write "<td>" & rs("tarData") & "</td>"
            Response.Write "<td><a href='tarefaCadastro.asp?tarId="&rs("tarID")&"'><img src='./Images/"& rs("tarStatus")&".gif' alt='Editar'></a></td>"
            Response.Write "</tr>"
            rs.MoveNext
          Loop
          rs.close
          cn.close
        %>          
        </tbody>
        <tfoot>
          <tr>
            <th colspan=100%>
              <div class="pagination">
                <ul>
                  <a href="#">
                    <li>
                      <<</li> </a> <a href="#">
                    <li>
                      <</li> </a> <input type="text" name="" id="">
                        <a href="#">
                    <li>></li>
                  </a>
                  <a href="#">
                    <li>>></li>
                  </a>
                  <li>Mostrando 2 de 2 registros</li>
                </ul>
              </div>
            </th>
          </tr>
        </tfoot>
      </table>
    </div>
  </main>
</body>

</html>