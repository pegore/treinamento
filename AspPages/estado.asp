<%
    Set cnEst = Server.CreateObject("ADODB.Connection")
    cnEst.Provider = "sqloledb"
    cnEst.Open("Data Source=localhost;Initial Catalog=treinamento;User Id=sa;Password=123456;")
    sqlEst = "SELECT * FROM [treinamento].[dbo].[estado]"
    Set rsEst=Server.CreateObject("ADODB.recordset")
    rsEst.Open sqlEst, cnEst, &H0001
    Set json = Server.CreateObject("Chilkat_9_5_0.JsonObject")
    success = json.AddArrayAt(-1,"Estados")  
    Set aEstados = json.ArrayAt(json.Size - 1)  
    index = -1
    do until rsEst.EOF
        for each x in rsEst.Fields
              id = rsEst("estadoid")        
              nome = rsEst("nome")        
        Next
        success = aEstados.AddObjectAt(-1)
        Set estado = aEstados.ObjectAt(aEstados.Size - 1)
        success = estado.AddIntAt(-1,"Id",id)
        success = estado.AddStringAt(-1,"Nome",nome)
        rsEst.MoveNext
    loop
    rsEst.Close
    cnEst.close
    json.EmitCompact = 0
    Response.Write json.Emit()
%>