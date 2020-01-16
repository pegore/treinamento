<!--#include file="./Class/Conexao.class"-->
<!--#include file="./Class/Usuario.class"-->
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
            set ObjConexao = new Conexao
            set getConexao = ObjConexao.AbreConexao()
            set ObjUsuario = new Usuario
            set rs = objUsuario.BuscarUsuarios(getConexao)
            stop
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
            Response.Write "<td><a href='usuarioCadastro.asp?usuid="&rs.Fields.Item(5)&"'><img src='./Images/editar.png' alt='Editar'></a></td>"
            Response.Write "</tr>"
            rs.MoveNext
          Loop
          rs.close
          ObjConexao.FecharConexao(getConexao)
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