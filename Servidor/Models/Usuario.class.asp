<%
Class cUsuario
    '
    ' Propriedades da classe
    '
    Private Id
    Private Usuario
    Private Senha
    Private Nome
    Private Endereco
    Private Cidade
    Private Cep
    Private IdEstado

    '
    ' Métodos Get e Set de cada propriedade
    '
    Public function getId()
        getId = Id
    End function

    Public sub setId(byval p_id)
        Id = p_id
    End sub	

    Public function getUsuario()
        getUsuario = Usuario
    End function

    Public sub setUsuario(byval p_usuario)
        Usuario = p_usuario
    End sub
	
    Public function getSenha()
        getSenha = Senha
    End function

    Public sub setSenha(byval p_senha)
        Senha = p_senha
    End sub

    Public function getNome()
        getNome = Nome
    End function

    Public sub setNome(byval p_nome)
        Nome = p_nome
    End sub
 
    Public function getEndereco()
        getEndereco = Endereco
    End function

    Public sub setEndereco(byval p_endereco)
        Endereco = p_endereco
    End sub

    Public function getCidade()
        getCidade = Cidade
    End function

    Public sub setCidade(byval p_cidade)
        Cidade = p_cidade
    End sub

    Public function getCep()
        getCep = Cidade
    End function

    Public sub setCep(byval p_cep)
        Cep = p_cep
    End sub
    
    Public function getIdEstado()
        getIdEstado = IdEstado
    End function

    Public sub setIdEstado(byval p_IdEstado)
        IdEstado = p_IdEstado
    End sub


    '
    ' Métodos complementares
    '
	
    'Inserção de usuários
    public function InsercaoUsuario()
        '
        ' TODO Lógica de inserção de usuários novos
        '
		set InsercaoUsuario = rs
	end function

    'Update de usuários
    public function UpadateUsuario(Id)
        '
        ' TODO Lógica de update de usuários
        '
		set UpadateUsuario = rs
	end function

    'Buscar usuários do banco de dados
    public function BuscarUsuarios(cn)
        '
        ' TODO Lógica para busca de usuários
        '
        stop
        sql = "SELECT [nome],[usuario],[endereco],[cidade],[cep],[usuid] FROM [treinamento].[dbo].[usuario]"
        Set rs=Server.CreateObject("ADODB.recordset")
        rs.Open sql, cn, &H0001
		set BuscarUsuarios = rs
	end function

    'Buscar um usuário para efetuar o login
    public function BuscarUsuarioPorNomeSenha(cn,usuario,senha)
        '
        ' TODO Lógica para busca de usuários
        '
		stop
        sql = "SELECT * FROM [treinamento].[dbo].[usuario] where usuario='" & usuario & "' and senha='" & senha & "'" 
        Set rs=Server.CreateObject("ADODB.recordset")
        rs.Open sql, cn, &H0001
        set BuscarUsuarioPorNomeSenha = rs
    end function
End Class


%>