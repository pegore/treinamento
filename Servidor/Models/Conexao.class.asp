<%
Class Conexao
    '
    ' Propriedades da classe
    '
    Private DataSource
    Private DataBase
    Private Usuario
    Private Senha

    '
    ' Métodos Get e Set de cada propriedade
    '
    Public function getDataSource()
        getDataSource = DataSource
    End function

    Public sub setDataSource(byval p_dataSource)
        DataSource = p_dataSource
    End sub	
    
    Public function getDataBase()
        getDataBase = DataBase
    End function

    Public sub setDataBase(byval p_dataBase)
        DataBase = p_dataBase
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

    '
    ' Métodos complementares  
    '
  
    'Abre uma conexao
    public function AbreConexao()
        '
        ' TODO Lógica de abertura de uma conexão
        ' precisa ter uma forma de pegar os dados da conexão de um arquivo de configuração
        ' quer seja um arquivo de variáveis de ambiente, ou um web.config
        ' precisa ter os seguintes valores no arquivo ou variavel de ambiente:
        '   - Datasource
        '   - DataBase
        '   - Usuario
        '   - Senha 
        '
        dim DataSource : DataSource= "localhost"
        dim DataBase : DataBase = "treinamento"
        dim Usuario : Usuario = "sa"
        dim Senha : Senha = "123456"
        dim stringConexao : stringConexao = "Data Source=" & Datasource & ";Initial Catalog=" & DataBase & ";User Id=" & Usuario & ";Password=" & Senha
        Set cn = Server.CreateObject("ADODB.Connection")
        cn.Provider = "sqloledb"
        cn.Open(stringConexao)
		set AbreConexao = cn
	end function
    
    'Fecha uma conexão
    public function FecharConexao(cn)
        '
        ' TODO Lógica para fechamento de uma conexão
        '
        cn.Close()
	end function
End Class
%>