<!--#include file="jscripts\scripts.vb"-->
b4


<!DOCTYPE html>
<html>
<body>
    <form action="logon.asp" method="post">
        <label>Usuário: </label>
        <input type="text" name="user" id="txtUser" />
        <br>
        <label>Senha: </label>
        <input type="password" name="pwd" id="txtPassword" />
        <br>
        <input type="submit" value="Enviar">
    </form>
    <hr>

    <table border="1" width="100%">
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
</body>
</html>
