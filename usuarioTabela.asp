<%
  Set cn = Server.CreateObject("ADODB.Connection")
  cn.Provider = "sqloledb"
  cn.Open("Data Source=localhost;Initial Catalog=treinamento;User Id=sa;Password=123456;")    
  sql = "SELECT [nome],[usuario],[endereco],[cidade],[cep],[usuid] FROM [treinamento].[dbo].[usuario]"
  Set rs=Server.CreateObject("ADODB.recordset")
  rs.Open sql, cn, &H0001
%>
<!DOCTYPE html>
<html lang="pt-br">

<head>  
  <!--#include file="./Includes/HtmlSecaoHead.inc"--> 
</head>

<body>
   <!--#include file="./Includes/TopMenu.inc"-->
  <main class="col-12">
    <div class="centralizar">
      <table class="table">
        <caption >
          <a href="usuarioCadastro.asp">Novo Usuário</a>
        </caption>
        <thead>
          <tr>
            <%
              for each x in rs.Fields
               if x.name<>"usuid" then
                Response.write("<th>" & ucase(x.name) & "</th>")
                end if
              next
            %>
            <th>AÇÕES</th>
          </tr>
        </thead>
        <tbody>
        <%
          Do Until rs.EOF
            Response.Write "<tr>" 
            for each x in rs.Fields
              if x.name<>"usuid" then
                Response.Write "<td>" & x.value & "</td>"
              end if
            next
            Response.Write "<td><a href='usuarioCadastro.html?usuid="&rs.Fields.Item(5)&"'><img src='./Images/editar.png' alt='Editar'></a></td>"
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