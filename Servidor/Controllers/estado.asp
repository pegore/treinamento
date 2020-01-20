<!--#include file="../Models/Conexao.class.asp"-->
<!--#include file="../Models/Estado.class.asp"-->
<%
 Response.CodePage = 65001
  Response.CharSet = "UTF-8"
  '
  'Seleção das funções a serem realizadas
  '
  If Request("fnTarget")<>"" Then
    Execute(Request("fnTarget"))
  End if

  '
  ' Função para buscar os estados cadastrados no banco e retornar em formato Json Response Write
  '
  Function BuscarEstados()
    set ObjConexao = new Conexao
    set cn = ObjConexao.AbreConexao()
    set ObjEstado = new Estado
    set rs = ObjEstado.BuscarEstados(cn)
    If Not rs.Eof Then      
      Response.ContentType = "application/json"
      Response.Write "{"
      Response.Write """Registros"": ["
      Do While Not (rs.Eof)
        Response.Write "{"
        Response.Write """Id"": """ & rs("estadoid") & ""","
        Response.Write """Nome"": """ & rs("nome") & """"
        Response.Write "}"
        if rs.AbsolutePosition < rs.RecordCount then
          Response.Write ","
        end if
        rs.MoveNext
        Loop
    End If
    Response.Write "]"
    Response.Write "}"
    ObjConexao.FecharConexao(cn)
  End Function
  '
  ' Função para buscar os estados cadastrados no banco e retornar em formato Json Chilkat
  '
  Function BuscarEstadosJson()
    set ObjConexao = new Conexao
    set cn = ObjConexao.AbreConexao()
    set ObjEstado = new Estado
    set rs = ObjEstado.BuscarEstados(cn)
    If Not rs.Eof Then
      Set json = Server.CreateObject("Chilkat_9_5_0.JsonObject")
      success = json.AddArrayAt(-1,"Registros")
      Set aRegistros = json.ArrayAt(json.Size - 1)  
      index = -1
      Do While Not (rs.Eof OR rs.AbsolutePage <> PaginaPesquisa)
        success = aRegistros.AddObjectAt(-1)
        Set estado = aRegistros.ObjectAt(aRegistros.Size - 1)
        success = estado.AddIntAt(-1,"Id",rs("estadoid"))
        success = estado.AddStringAt(-1,"Nome",rs("nome"))
        rs.MoveNext
      Loop
    End If
    rs.Close()
    ObjConexao.FecharConexao(cn)
    json.EmitCompact = 0
    Response.Write json.Emit()    
  End Function

  %>