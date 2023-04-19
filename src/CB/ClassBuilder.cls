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
            set tFMField=pAttributeMap.VistaField
            set tType=tFMField.VistaFieldType
            if tType["Date" {
                set tProperty.Type="%FilemanTimeStamp"
            } else {
                set tProperty.Type="%String"
                do tProperty.Parameters.SetAt(50,"MAXLEN")
                do tProperty.Parameters.SetAt("EXACT","COLLATION")
            }
            if pAttributeMap.DataDomain="PKIEN" {
                set tProperty.Required=1
            }
            set tProperty.Description=tFMField.VistaFieldDescription
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
        &sql(SELECT %NOLOCK TOP 1 ID INTO :tId FROM CB.AttributeMap WHERE IRISClassName=:tClassName)
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

}
