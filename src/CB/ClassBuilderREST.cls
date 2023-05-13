Class CB.ClassBuilderREST Extends %CSP.REST
{

Parameter HandleCorsRequest = 1;

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
    <!-- Return an array of VistaSite objects.-->
    <Route Url="/vistasites" Method="GET" Call="GetVistaSites" />
    <!-- Return an array of VistaSite objects.-->
    <Route Url="/vistafiles/:Sta3n/:FileNum" Method="GET" Call="GetVistaFiles" />
    <!-- Return an array of VistaField objects.-->
    <Route Url="/vistafields/:Sta3n/:FileNum" Method="GET" Call="GetVistaFields" />
    <!-- Return an array of IRISClassNames in CB.AttributeMap as objects.-->
    <Route Url="/mappedclasses" Method="GET" Call="GetAMapClasses" />
    <!-- Return an array of VistaField objects.-->
    <Route Url="/vistafields/:Sta3n/:FileNum/:FieldNum" Method="GET" Call="GetVistaField" />
    <!-- accept json content and use it to populate attributeMap-->
    <Route Url="/addattributes" Method="POST" Call="AddAttributeMap" />
    <!-- return the status of building a class-->
    <Route Url="/buildclass/:irisclass" Method="GET" Call="BuildClass" />
</Routes>
}

/// Return an array of VistaSite objects
ClassMethod GetVistaSites() As %Status
{
    Set tSC = $$$OK
    Try {
        set tArray=[]
        set tRSet=##class(%SQL.Statement).%ExecDirect(.tStatement,"SELECT %NOLOCK ID,Sta3n,Sta3a,SiteName FROM VX130.VistaSite")
        while tRSet.%Next() {
            set tObj={}
            do tObj.%Set("id",tRSet.%Get("ID"))
            do tObj.%Set("Sta3n",tRSet.%Get("Sta3n"))
            do tObj.%Set("Sta3a",tRSet.%Get("Sta3a"))
            do tObj.%Set("SiteName",tRSet.%Get("SiteName"))
            do tArray.%Push(tObj)
        }
        Write tArray.%ToJSON()
    }
    Catch ex {
        Set tSC=ex.AsStatus()
    }
    kill tArray,tRSet,tStatement,tObj
    Return tSC
}

/// Return an array of VistaFile objects for a given Sta3n and VistaFileNumber
ClassMethod GetVistaFiles(pSta3n As %Integer, pVistaFileNumber As %String) As %Status
{
    Set tSC = $$$OK
    Try {
        set tSQL = "SELECT %NOLOCK ID,VistaFileName,VistaFileNumber FROM Dim.VistaFilev001 WHERE Sta3n = ?  AND VistaFileNumber = ?"
        set tRSet = ##class(%SQL.Statement).%ExecDirect(.tStatement,tSQL,pSta3n,pVistaFileNumber)
        set tArray = []
        while tRSet.%Next() { 
            set tObj = {}
            do tObj.%Set("id",tRSet.%Get("ID"))
            do tObj.%Set("VistaFileNumber",tRSet.%Get("VistaFileNumber"))
            do tObj.%Set("VistaFileName",tRSet.%Get("VistaFileName"))
            Do tArray.%Push(tObj)
        }
        Write tArray.%ToJSON()
    }
    Catch ex {
        set tSC = ex.AsStatus()
    }
    kill tArray,tRSet,tStatement,tObj
	Return tSC
}

/// Return an array of Vista Field objects
ClassMethod GetVistaFields(pSta3n As %String, pVistaFileNumber As %String) As %Status
{
	Set tSC = $$$OK
	Try {
        set tArray = []
		set tSQL= "SELECT %NOLOCK ID,VistaFileNumber,VistaFieldNumber,VistaFieldName,VistaPointedToFileNumber,VistaFieldLength,"_
            "VistaFieldType,VistaMultipleFileNumber FROM Dim.VistaFieldv001 WHERE Sta3n=? and VistaFileNumber = ? AND OpCode is NULL"
		set tRSet=##Class(%SQL.Statement).%ExecDirect(.tStatement,tSQL,pSta3n,pVistaFileNumber)
			
		While tRSet.%Next() { 
			Set tObj = {}
            do tObj.%Set("id",tRSet.%Get("ID"))
			do tObj.%Set("VistaFileNumber",tRSet.%Get("VistaFileNumber"))
			do tObj.%Set("VistaFieldNumber",tRSet.%Get("VistaFieldNumber"))
            do tObj.%Set("VistaFieldName",tRSet.%Get("VistaFieldName"))
            do tObj.%Set("PointsToFileNumber",tRSet.%Get("VistaPointedToFileNumber"))
            do tObj.%Set("FieldLength",tRSet.%Get("VistaFieldLength"))
			do tObj.%Set("FieldType",tRSet.%Get("VistaFieldType"))
			do tObj.%Set("MultipleFileNumber",tRSet.%Get("VistaMultipleFileNumber"))
			do tArray.%Push(tObj)
		}
		Write tArray.%ToJSON()
	} 
	Catch ex {
		Set tSC = ex.AsStatus()
	}
    kill tArray,tRSet,tStatement,tObj
	Return tSC
}

/// Return an array of IRISClassNames in CB.AttributeMap as objects.
ClassMethod GetAMapClasses() As %Status
{
	Set tSC = $$$OK
    set tArray = []
	Try
	{
        set tRSet=##class(%SQL.Statement).%ExecDirect(.tStatement,"Select %NOLOCK DISTINCT IRISClassName From CB.AttributeMap")
		While tRSet.%Next()
		{
            set tObj={}
            do tObj.%Set("SchemaName",$PIECE(tRSet.%Get("IRISClassName"),".",1))
            do tObj.%Set("TableName",$PIECE(tRSet.%Get("IRISClassName"),".",2))
			Do tArray.%Push(tObj)
		}
	}
	Catch ex
	{
		Set tSC = ex.AsStatus() 
	}
	write tArray.%ToJSON()
	kill tArray,tRSet,tStatement,tObj
	Return tSC
}

/// Return an array of Vista Field objects
ClassMethod GetVistaField(pSta3n As %String, pVistaFileNumber As %String, pVistaFieldNumber As %String) As %Status
{
	Set tSC = $$$OK
	Try {
        set tArray = []
		set tSQL = "SELECT %NOLOCK ID,VistaFileNumber,VistaFieldNumber,VistaFieldName,VistaPointedToFileNumber,VistaFieldLength,"_
            "VistaFieldType,VistaMultipleFileNumber FROM Dim.VistaFieldv001 WHERE Sta3n=? and VistaFileNumber = ? AND "_
            "VistaFieldNumber=? AND OpCode is NULL"
		set tRSet=##Class(%SQL.Statement).%ExecDirect(.tStatement,tSQL,pSta3n,pVistaFileNumber,pVistaFieldNumber)
			
		While tRSet.%Next() { 
			Set tObj = {}
            do tObj.%Set("id",tRSet.%Get("ID"))
			do tObj.%Set("VistaFileNumber",tRSet.%Get("VistaFileNumber"))
			do tObj.%Set("VistaFieldNumber",tRSet.%Get("VistaFieldNumber"))
            do tObj.%Set("VistaFieldName",tRSet.%Get("VistaFieldName"))
            do tObj.%Set("PointsToFileNumber",tRSet.%Get("VistaPointedToFileNumber"))
            do tObj.%Set("FieldLength",tRSet.%Get("VistaFieldLength"))
			do tObj.%Set("FieldType",tRSet.%Get("VistaFieldType"))
			do tObj.%Set("MultipleFileNumber",tRSet.%Get("VistaMultipleFileNumber"))
			do tArray.%Push(tObj)
		}
		Write tArray.%ToJSON()
	} 
	Catch ex {
		Set tSC = ex.AsStatus()
	}
    kill tArray,tRSet,tStatement,tObj
	Return tSC
}

/// Description
ClassMethod AddAttributeMap() As %Status
{
    Set tSC = $$$OK
    Try {
        set tdata = %request.Content.Read()
        set tObj = {}.%FromJSON(tdata)
        set tIRISClassName = tObj.%Get("schema")_"."_tObj.%Get("table")
        set tSta3n = tObj.%Get("sta3n")
        set tFields = tObj.%Get("fields")
        Set tFld = tFields.%GetIterator()
	    Set tKey = ""
	    While tFld.%GetNext(.tKey,.tFieldObj) {
            set tFileNumber = tFieldObj.%Get("VistaFileNumber")
            set tFieldNumber = tFieldObj.%Get("VistaFieldNumber")
            set ^zdata(tKey,1)=tFileNumber_","_tFieldNumber_","_tSta3n
            &sql(SELECT ID INTO :tId FROM Dim.VistaFieldv001 WHERE VistaFileNumber=:tFileNumber AND VistaFieldNumber=:tFieldNumber AND Sta3n = :tSta3n)
            set tSC=##class(CB.AttributeMap).AddMap(tIRISClassName,tId)
        }
        &sql(SELECT ID INTO :tId FROM Dim.VistaFilev001 WHERE VistaFileNumber=:tFileNumber AND Sta3n = :tSta3n)
        set tSC=##class(CB.AttributeMap).AddPrimaryKeys(tId,tIRISClassName)

    }
    Catch ex {
        Set tSC=ex.AsStatus()
        set ^zdata(3)=tSC
    }
    Return tSC
}

/// Description
ClassMethod BuildClass(pIRISClassName As %String) As %Status
{
    Set tSC = $$$OK
    Try {
        set tSC = ##class(CB.ClassBuilder).BuildClass(pIRISClassName)
        write {"Status": "OK"}.%ToJSON()
    }
    Catch ex {
        Set tSC=ex.AsStatus()
    }
    Return tSC
}

}
