Class CB.ClassBuilder Extends %RegisteredObject
{

/// Description
ClassMethod BuildClass(pIRISClassName As %String) As %Status
{
    Set tSC = $$$OK
    Try {
        &sql(SELECT %NOLOCK COUNT(*) INTO :tCnt FROM CB.AttributeMap WHERE IRISClassName=:pIRISClassName )
        if +$GET(tCnt)=0 {
            set tSC=$SYSTEM.Status.Error(5001, pIRISClassName_" was not found in AttributeMap.")
            quit
        }
        &sql(SELECT %NOLOCK COUNT(*) INTO :tCnt FROM %Dictionary.ClassDefinition WHERE name=:pIRISClassName)
        if +$GET(tCnt)>0 {
            set tSC=$SYSTEM.Status.Error(5001, pIRISClassName_" was found in %Dictionary.ClassDefinition.")
            quit
        }
        set tSC=..CreateClass(pIRISClassName, .tClassDef)
        quit:'tSC

        set tSC=..AddProperties(tClassDef)
        quit:'tSC

        set tSC=..AddCommonPropeties(tClassDef)
        quit:'tSC

        set tSC=..AddClassDescription(tClassDef)
        quit:'tSC

        set tSC=..AddIndex(tClassDef)
        quit:'tSC

        set tSC= ..AddBuildSite(tClassDef)
        quit:'tSC

        set tSC=..AddUpdateObject(tClassDef)
        quit:'tSC

    }
    Catch ex {
        Set tSC=ex.AsStatus()
    }
    Return tSC
}

/// Description
ClassMethod AddProperties(pClassDef As %Dictionary.ClassDefinition) As %Status
{
    #Dim tFMField As Dim.VistaFieldv001
    Set tSC = $$$OK
    Try {
        set tIRISClassName=pClassDef.Name
        set tSQL="SELECT %NOLOCK ID FROM CB.AttributeMap WHERE IRISClassName=?"
        set tRSet=##class(%SQL.Statement).%ExecDirect(.tStatement,tSQL,tIRISClassName)
        while tRSet.%Next() {
            set tId=tRSet.%Get("ID")
            set tAMap=##class(CB.AttributeMap).%OpenId(tId)
            set tSC=..AddProperty(tAMap,pClassDef)
            quit:'tSC

        }
    }
    Catch ex {
        Set tSC=ex.AsStatus()
    }
    Return tSC
}

/// Description
ClassMethod CreateClass(pIRISClassName As %String, ByRef tClassDef As %Dictionary.ClassDefinition) As %Status
{
    Set tSC = $$$OK
    Try {
        set tClassDef=##class(%Dictionary.ClassDefinition).%New(pIRISClassName)
        set tClassDef.Super="%Persistent,%JSON.Adaptor"
        set tClassDef.ClassType="persistent"
        set tClassDef.ProcedureBlock=0
        set tClassDef.SqlRowIdPrivate=1
        set tSC=tClassDef.%Save()
    }
    Catch ex {
        Set tSC=ex.AsStatus()
    }
    Return tSC
}

/// Description
ClassMethod DeleteClass(pIRISClassName As %String) As %Status
{
    Set tSC = $$$OK
    Try {
        set tSC=##class(%Dictionary.ClassDefinition).%DeleteId(pIRISClassName)
    }
    Catch ex {
        Set tSC=ex.AsStatus()
    }
    Return tSC
}

/// Description
ClassMethod AddProperty(pAttributeMap As CB.AttributeMap, pClassDef As %Dictionary.ClassDefinition) As %Status
{
    Set tSC = $$$OK
    Try {
        set tPropertyName=pAttributeMap.IRISPropertyName
        set tProperty=##class(%Dictionary.PropertyDefinition).%New()
            set tProperty.Name=tPropertyName
            set tProperty.parent=pClassDef
            if pAttributeMap.DataDomain="PKIEN" {
                set tProperty.Required=1
            } else {
                set tProperty.Description="Vista File #"_pAttributeMap.VistaField.VistaFile.VistaFileNumber_$C(13,10)_
                    "Vista Field #"_pAttributeMap.VistaField.VistaFieldNumber_$C(13,10)_
                    pAttributeMap.VistaField.VistaFieldDescription
            }
            set tType=pAttributeMap.DataType
            if tType="%String" {
                do tProperty.Parameters.SetAt(pAttributeMap.MaxLength,"MAXLEN")
                do tProperty.Parameters.SetAt("EXACT","COLLATION")
            } elseif tType="%Numeric" {
                set tNumericScale=pAttributeMap.NumericScale
                set tMinMax=..CalculateMinMax(tNumericScale)
                do tProperty.Parameters.SetAt(tMinMax,"MAXVAL")
                do tProperty.Parameters.SetAt("-"_tMinMax,"MINVAL")
                do tProperty.Parameters.SetAt($PIECE(tNumericScale,",",2),"SCALE")
            }
            set tProperty.Type=pAttributeMap.DataType
            
            set tSC=tProperty.%Save()
            quit:'tSC
            set tSC=pClassDef.Properties.Insert(tProperty)
            quit:'tSC
            set tSC=pClassDef.%Save()
            quit:'tSC
    }
    Catch ex {
        Set tSC=ex.AsStatus()
    }
    Return tSC
}

/// Description
ClassMethod AddCommonPropeties(pClassDef As %Dictionary.ClassDefinition) As %Status
{
    Set tSC = $$$OK
    Try {
        for tPropertyName="Sta3n","OpCode","VistaCreateDate","VistaEditDate" {
            Set tProperty=##class(%Dictionary.PropertyDefinition).%New()
            set tProperty.Name=tPropertyName
            
            if tPropertyName="Sta3n" {
                set tProperty.Required=1
                set tProperty.Type="%Integer"
                set tProperty.Description="The 3 digit station number"
            } elseif tPropertyName["Date" {
                set tProperty.Type="%TimeStamp"
                set tProperty.Required=1
                if tPropertyName["Create" {
                    set tProperty.Description="The UTC Timestamp when the record was created."
                } else {
                    set tProperty.Description="The UTC Timestamp when the record last changed."
                }
            } else {
                set tProperty.Type="%String"
                set tProperty.Description="This property is null unless the Vista Record was deleted."
            }
            
            set tProperty.parent=pClassDef
            set tSC=tProperty.%Save()
            quit:'tSC
            set tSC=pClassDef.Properties.Insert(tProperty)
            quit:'tSC
            set tSC=pClassDef.%Save()
            quit:'tSC
        }
        
    }
    Catch ex {
        Set tSC=ex.AsStatus()
    }
    Return tSC
}

/// Description
ClassMethod AddClassDescription(pClassDef As %Dictionary.ClassDefinition) As %Status
{
    Set sc = $$$OK
    Try {
        set tClassName=pClassDef.Name
        &sql(SELECT %NOLOCK TOP 1 ID INTO :tId FROM CB.AttributeMap WHERE IRISClassName=:tClassName AND VistaField IS NOT NULL)
        if +$GET(tId)=0 {
            set tSC=$SYSTEM.Status.Error(5001, tClassName_" was not found in AttributeMap.")
            quit
        }
        set tFileDesciption=##class(CB.AttributeMap).%OpenId(tId).VistaField.VistaFile.VistaFileDescription
        set pClassDef.Description="History: "_$C(13,10)_
            "Class Built by ClassBuilder v1.0 on "_$ZDATETIME($ZTIMESTAMP,3)_$C(13,10,13,10)_
            tFileDesciption
        set tSC=pClassDef.%Save()
    }
    Catch ex {
        Set tSC=ex.AsStatus()
    }
    Return sc
}

/// Description
ClassMethod CalculateMinMax(pNumericScale As %String, ByRef tSC As %Status) As %String
{
    Set tSC = $$$OK
    Try {
        set tWholeDigits=$PIECE(pNumericScale,",",1)
        set tDecimalDigits=$PIECE(pNumericScale,",",2)
        set $PIECE(tWhole,"9",(tWholeDigits-tDecimalDigits+1))="."
        set $PIECE(tDecimal,"9",(tDecimalDigits+1))=""
    }
    Catch ex {
        Set tSC=ex.AsStatus()
    }
    Return tWhole_tDecimal
}

/// Description
ClassMethod AddIndex(pClassDef As %Dictionary.ClassDefinition) As %Status
{
    #Dim tIndex As %Dictionary.IndexDefinition
    Set tSC = $$$OK
    Try {
        set tClassName=pClassDef.Name
        set tSQL="SELECT %NOLOCK IRISPropertyName FROM CB.AttributeMap WHERE IRISClassName=? AND VistaFile IS NOT NULL ORDER BY VistaFile"
        set tRSet=##class(%SQL.Statement).%ExecDirect(.tStatement,tSQL,tClassName)
        set tProperties="Sta3n"
        while tRSet.%Next() {
            set tProperties=tProperties_","_tRSet.%Get("IRISPropertyName")
        }
        set tIndex=##class(%Dictionary.IndexDefinition).%New()
        set tIndex.parent=pClassDef
        set tIndex.Name="MainIndex"
        set tIndex.PrimaryKey=1
        set tIndex.IdKey=1
        set tIndex.Unique=1
        set tIndex.Properties=tProperties
        set tSC=tIndex.%Save()
        quit:'tSC
        do pClassDef.Indices.Insert(tIndex)
        set tSC=pClassDef.%Save()
        quit:'tSC

        set tIndex=##class(%Dictionary.IndexDefinition).%New()
        set tIndex.parent=pClassDef
        set tIndex.Name="VistaEditDateIndex"
        set tIndex.Properties="VistaEditDate"
        set tSC=tIndex.%Save()
        quit:'tSC
        do pClassDef.Indices.Insert(tIndex)
        set tSC=pClassDef.%Save()
        quit:'tSC
    }
    Catch ex {
        Set tSC=ex.AsStatus()
    }
    Return tSC
}

/// Description
ClassMethod AddBuildSite(pClassDef As %Dictionary.ClassDefinition) As %Status
{
    Set tSC = $$$OK
    Try {
        set tCodeStream=##class(%Stream.TmpCharacter).%New()
        do tCodeStream.Write(..BuildSiteCode(pClassDef.Name))
        set tMethod=##class(%Dictionary.MethodDefinition).%New()
        set tMethod.Name="BuildSite"
        set tMethod.parent=pClassDef
        set tMethod.ClassMethod=1
        set tMethod.Implementation=tCodeStream
        set tMethod.FormalSpec="pSta3n:%Integer,pStartIEN:%String=0"
        set tMethod.ReturnType="%Status"
        set tSC = tMethod.%Save()
        quit:'tSC
        set tSC = pClassDef.Methods.Insert(tMethod)
        quit:'tSC
        set tSC = pClassDef.%Save()
        quit:'tSC
    }
    Catch ex {
        Set tSC=ex.AsStatus()
    }
    Return tSC
}

/// Description
ClassMethod BuildSiteCode(pIRISClassName As %String, ByRef tSC As %Status) As %String
{
    Set tSC = $$$OK
    Try {
        set tCode=$C(9)_"set tSC = $$$OK"_$C(13,10,9)_
            "Try {"_$C(13,10,9,9)_
                "set tVistaSite = ##class(VX130.VistaSite).%OpenId(pSta3n)"_$C(13,10,9,9)_
                "set tNS = tVistaSite.Sta3a"_$C(13,10,9,9)_"kill tVistaSite"_$C(13,10,9,9)_
                "set tLastIEN = """""_$C(13,10)
        set tCodeEnd=""
        set tTab=$C(9,9)
        set tD=0
        set tPropertyNames=""
        set tSQL="SELECT %NOLOCK IRISPropertyName,VistaFile FROM CB.AttributeMap WHERE IRISClassName=? AND VistaFile IS NOT NULL ORDER BY VistaFile"
        set tRSet=##class(%SQL.Statement).%ExecDirect(.tStatement,tSQL,pIRISClassName)
        while tRSet.%Next() {
            
            set tPropertyName(tD)="t"_tRSet.%Get("IRISPropertyName")
            if tD=0 {
                set tLastIEN="set tLastIEN = "_tPropertyName(tD)
            } else {
                set tLastIEN=tLastIEN_"_"",""_"_tPropertyName(tD)
            }
            set tVistaFile=tRSet.%Get("VistaFile")
            &sql(SELECT GlobalNode INTO :tGlobalNode FROM Dim.VistaFieldv001 WHERE VistaFile=:tVistaFile AND VistaFieldNumber='.01')
            if $GET(tGlobalNode)']"" {
                set tSC=$SYSTEM.Status.Error(5001, "Missing Global Node in DataDictionary for "_tVisaFile_" .01 field")
                quit
            }
            set tGlobal=$PIECE($PIECE(tGlobalNode,"^",2),"D"_tD,1)_"D"_tD
            if tD=0 {
                set tCode=tCode_tTab_"set "_tPropertyName(tD)_" = $ORDER(^|tNS|"_$REPLACE(tGlobal,"D0","pStartIEN")_"))"_$C(13,10)
            } else {
                set tCode=tCode_tTab_"set "_tPropertyName(tD)_" = $ORDER(^|tNS|"_tGlobal_"))"_$C(13,10)
            }
            
            set tCode=tCode_tTab_"while +"_tPropertyName(tD)_" {"_$C(13,10)
            set tCodeEnd=tTab_$C(9)_"set "_tPropertyName(tD)_" = $ORDER(^|tNS|"_tGlobal_"))"_$C(13,10)_
                tTab_"}"_$C(13,10)
            set tD=tD+1
            set tTab=tTab_$C(9)
        }
        set tCode=tCode_tTab_tLastIEN_$C(13,10)_tTab_"set tSC=..UpdateObject(pSta3n,tLastIEN,1)"_$C(13,10)
        set tCode=tCode_tCodeEnd_$C(9)_"}"_$C(13,10,9)_"Catch ex {"_$C(13,10,9,9)_
            "Set tSC=ex.AsStatus()"_$C(13,10,9)_"}"_$C(13,10,9)_
            "return tSC"_$C(13,10)
        for tI=0:1:(tD-1) {
            set tCode=$REPLACE(tCode,"D"_tI,tPropertyName(tI))
        }
    }
    Catch ex {
        Set tSC=ex.AsStatus()
    }
    Return tCode
}

ClassMethod AddUpdateObject(pClassDef As %Dictionary.ClassDefinition) As %Status
{
    Set tSC = $$$OK
    Try {
        set tCodeStream=##class(%Stream.TmpCharacter).%New()
        do tCodeStream.Write(..UpdateObjectCode(pClassDef.Name))
        set tMethod=##class(%Dictionary.MethodDefinition).%New()
        set tMethod.Name="UpdateObject"
        set tMethod.parent=pClassDef
        set tMethod.ClassMethod=1
        set tMethod.Implementation=tCodeStream
        set tMethod.FormalSpec="pSta3n:%Integer,pFMPK:%String,pHistoricalPull:%Boolean=0,pLogEdits:%Boolean=0"
        set tMethod.ReturnType="%Status"
        set tSC = tMethod.%Save()
        quit:'tSC
        set tSC = pClassDef.Methods.Insert(tMethod)
        quit:'tSC
        set tSC = pClassDef.%Save()
        quit:'tSC
    }
    Catch ex {
        Set tSC=ex.AsStatus()
    }
    Return tSC
}

/// Description
ClassMethod UpdateObjectCode(pIRISClassName As %String, ByRef tSC As %Status) As %String
{
    Set tSC = $$$OK
    set tCode=$C(9)_
        "set tSC=$$$OK"_$C(13,10,9)_
        "Try {"_$C(13,10,9,9)_
            "set tVistaSite=##class(VX130.VistaSite).%OpenId(pSta3n)"_$C(13,10,9,9)_
	        "set tNS=tVistaSite.Sta3a"_$C(13,10,9,9)_
            "kill tVistaSite"_$C(13,10,9,9)_
	        "kill tBitFlag"_$C(13,10,13,10,9,9) 
    set tD=0  
    Try {
        set tId=$C(9,9)_"set tId = pSta3n"
        set tSQL="SELECT %NOLOCK IRISPropertyName,VistaFile FROM CB.AttributeMap WHERE IRISClassName=? AND VistaFile IS NOT NULL ORDER BY VistaFile"
        set tRSet=##class(%SQL.Statement).%ExecDirect(.tStatement,tSQL,pIRISClassName)
        while tRSet.%Next() {
            set tVistaFile=tRSet.%Get("VistaFile")
            &sql(SELECT GlobalNode INTO :tGlobalNode FROM Dim.VistaFieldv001 WHERE VistaFile=:tVistaFile AND VistaFieldNumber='.01')
            set tPropertyName(tD)="t"_tRSet.%Get("IRISPropertyName")
            set tId=tId_"_""||""_"_tPropertyName(tD)
            if tD=0 {
                set tMethodSig="t"_tRSet.%Get("IRISPropertyName")
            } else {
                set tMethodSig=tMethodSig_",t"_tRSet.%Get("IRISPropertyName")
            }

            set tCode=tCode_"set "_tPropertyName(tD)_" = $PIECE(pFMPK,""^"","_(tD+1)_")"_$c(13,10,9,9)_
                "quit:(+"_tPropertyName(tD)_"'>0)"_$C(13,10,13,10,9,9)_
                "if ($GET(^|tNS|"_$PIECE(tGlobalNode,"^",2)_")="""") {"_$C(13,10,9,9,9)_
                    "set tSC = ..RemoveObject(pSta3n,pFMPK)"_$C(13,10,9,9,9)_
                    "quit"_$C(13,10,9,9)_"}"_$C(13,10)
            set tD=tD+1
        }
        kill tRSet,tSQL
        set tCode=tCode_tId_$C(13,10,9,9)_
            "set tObj = ..%OpenId(tId,4,.tSC)"_$C(13,10,13,10,9,9)_
            "if '$$$ISOK(tSC) {"_$C(13,10,9,9,9)_
                "if $System.Status.GetErrorCodes(tSC)'=5809 {"_$C(13,10,9,9,9,9)_
			    "// Error is not because the object does not exist.  Probably can't get lock."_$C(13,10,9,9,9,9)_
                "quit"_$C(13,10,9,9,9)_
                "}"_$C(13,10,9,9)_
            "} // Either got lock or object does not exist yet."_$C(13,10,13,10,9,9)_
            "if '$ISOBJECT(tObj) {"_$C(13,10,9,9,9)_
                "set tObj=..%New()"_$C(13,10,9,9,9)_
                "set tObj.Sta3n=pSta3n"_$C(13,10,9,9,9)
        
        for tI=0:1:(tD-1) {
            set tCode=tCode_
                "set tObj."_$EXTRACT(tPropertyName(tI),2,$LENGTH(tPropertyName(tI)))_" = "_tPropertyName(tI)_$C(13,10,9,9,9)
        }
		set tCode=tCode_
            "set tObj.VistaCreateDate=$Case(pHistoricalPull,1:""1900-01-01"",:$ZDATETIME($ZTIMESTAMP,3))"_$C(13,10,9,9,9)_
		    "set tObj.OpCode="""""_$C(13,10,9,9,9)_
            "set $BIT(tBitFlag,1)=1"_$C(13,10,9,9)_
            "}"_$C(13,10,13,10,9,9)
        
        set tSQL="SELECT IRISPropertyName FROM CB.AttributeMap WHERE IRISClassName=? AND VistaField IS NOT NULL"
        set tRSet=##class(%SQL.Statement).%ExecDirect(.tStatement,tSQL,pIRISClassName)
        set tI=2
        while tRSet.%Next() {
            set tCode=tCode_"set $BIT(tBitFlag,"_tI_")=tObj.set"_tRSet.%Get("IRISPropertyName")_"(tNS,"_tMethodSig_")"_$C(13,10,9,9)
            set tI=tI+1
        }
       
        set tCode=tCode_$C(13,10,9,9)_
            "if tObj.OpCode]"""" {"_$C(13,10,9,9,9)_
                "set tObj.OpCode="""""_$C(13,10,9,9,9)_
                "Set $BIT(tBitFlag,"_tI_")=1"_$C(13,10,9,9)_
            "}"_$C(13,10,9,9)_
            "if $BITFIND(tBitFlag,1)>0 {"_$C(13,10,9,9,9)_
                "// Something changed."_$C(13,10,9,9,9)_
                "if pLogEdits {"_$C(13,10,9,9,9,9)_
                    "write ..%ClassName(1),tId,"" """_$C(13,10,9,9,9,9)_
                    "for tzz=1:1:"_tI_" {"_$C(13,10,9,9,9,9,9)_
                        "write $BIT(tBitFlag,tzz)"_$C(13,10,9,9,9,9)_
                    "}"_$C(13,10,9,9,9,9)_
                    "write !"_$C(13,10,9,9,9,9)_
                    "///read tzzz"_$C(13,10,9,9,9)_
                    "}"_$C(13,10,9,9,9)_
                "set tObj.VistaEditDate=$ZDATETIME($ZTIMESTAMP,3)"_$C(13,10,9,9,9)_
                "set tSC=tObj.%Save()"_$C(13,10,9,9)_
            "}"_$C(13,10,9,9)_
            "quit"_$C(13,10,9)_
            "}"_$C(13,10,9)_
            "Catch ex {"_$C(13,10,9,9)_
                "set tSC=ex.AsStatus()"_$C(13,10,9)_
            "}"_$C(13,10,9)_
            "kill tObj"_$C(13,10,9)_
            "return tSC"_$C(13,10)
        for tI=0:1:(tD-1) {
            set tCode=$REPLACE(tCode,"D"_tI,tPropertyName(tI))
        }
    }
    Catch ex {
        Set tSC=ex.AsStatus()
    }
    Return tCode
}

}
