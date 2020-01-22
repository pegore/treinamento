<!DOCTYPE html>
<html lang="pt-br">

<head>
   <!--#include file ="Includes\HtmlSecaoHead.inc"--> 
</head>

<body>
    <div class="centralizar">
        <form name="formLogon" method="post" class="column spacing">
            <img src="Images\key.png" alt="key" class="center" />
            <div class="row space-between">
                <label for="txtUsuario">Usuário:</label>
                <input type="text" id="txtUsuario" name="txtUsuario" placeholder="Usuário" class="textfield" />
            </div>
            <div class="row space-between">
                <label for="pwdSenha">Senha:</label>
                <input type="password" id="pwdSenha" name="pwdSenha" placeholder="Senha" class="textfield" />
            </div>
            <div class="alerta alerta-info" id="divAlerta">
            </div>
            <div class="row space-between">
                <button type="button" id="btnLogin" name="btnLogin" class="button button-primary">Fazer Login</button>
            </div>
        </form>
    </div>
    <script src="JScripts/Externos/Jquery-3-4-1.js" type="text/javascript"></script>
    <script src="JScripts/Internos/Logon.js" type="text/javascript"></script>
</body>

</html>