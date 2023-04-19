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
        set tClassName=pClassDef.Name
        set tSQL="SELECT %NOLOCK IRISPropertyName,VistaFile FROM CB.AttributeMap WHERE IRISClassName=? AND VistaFile IS NOT NULL ORDER BY VistaFile"
        set tRSet=##class(%SQL.Statement).%ExecDirect(.tStatement,tSQL,tClassName)
        while tRSet.%Next() {
            set tPropertyName=tRSet.%Get("IRISPropertyName")
            set tVistaFile=tRSet.%Get("VistaFile")
            &sql(SELECT GlobalNode INTO :tGlobalNode FROM Dim.VistaFieldv001 WHERE VistaFile=:tVistaFile AND VistaFieldNumber='.01')
            if $GET(tGlobalNode)']"" {
                quit
            }
            
        }
    }
    Catch ex {
        Set tSC=ex.AsStatus()
    }
    Return tSC
}

}
