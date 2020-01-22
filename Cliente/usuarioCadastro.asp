<!DOCTYPE html>
<html lang="pt-br">

<head>
 <!--#include file="./Includes/HtmlSecaoHead.inc"--> 
</head>

<body>
<!--#include file="./Includes/TopMenu.inc"-->
    <form class="column spacing"  name="frmUser" id="frmUser">
      <div class="row form-group items-center">
        <label class="col-2" for="txtUsuario">Usuário:</label>
        <input class="col-4 textfield" type="text" id="txtUsuario" name="txtUsuario"placeholder="Usuário">      
        <label class="col-2 pl-sm" for="pwdSenha">Senha:</label>
        <input class="col-4 textfield" type="password" id="pwdSenha" name="pwdSenha" placeholder="Senha">
      </div>
      <div class="row form-group items-center">
        <label class="col-2" for="txtNome">Nome:</label>
        <input class="col-10 textfield" type="text" id="txtNome" name="txtNome" placeholder="Nome">
      </div>
      <div class="row form-group items-center">
        <label class="col-2" for="txtEndereco">Endereço:</label>
        <input class="col-4 textfield" type="text" id="txtEndereco" name="txtEndereco" placeholder="Endereço">      
        <label class="col-2 pl-sm" for="txtCidade">Cidade:</label>
        <input class="col-4 textfield" type="text" id="txtCidade" name="txtCidade" placeholder="Cidade">
      </div>
      <div class="row form-group items-center">
        <label class="col-2" for="txtCep">Cep:</label>
        <input class="col-4 textfield" type="text" id="txtCep" name="txtCep" placeholder="CEP">      
        <label class="col-2 pl-sm" for="selEstados">Estado:</label>
        <select class="col-4 textfield" id="selEstados" name="selEstados">
          <option value="0">Selecione um Estado</option>
        </select>
      </div>
      <div class="row">
        <button type="button" id="btnCadastrar"class="button button-primary col-4">Cadastrar</button>
        <button type="button" id="btnAlterar"class="button button-warning col-4">Alterar</button>
        <button type="button" id="btnNovo"class="button button-secondary col-4">Novo</button>
      </div>
    </form>
  </main>
  <script src="JScripts/Externos/Jquery-3-4-1.js" type="text/javascript"></script>
  <script src="JScripts/Internos/UsuarioCadastro.js" type="text/javascript"></script>
</body>


</html>