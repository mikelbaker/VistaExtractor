Class CB.AttributeMap Extends (%Persistent, %JSON.Adaptor)
{

/// Description
Property IRISPropertyName As %String(COLLATION = "EXACT", MAXLEN = 200);

// Description

Property IRISClassName As %String(COLLATION = "EXACT", MAXLEN = 200);

// Description

Property VistaField As Dim.VistaFieldv001;

// Description

Property VistaFile As Dim.VistaFilev001;

// PKIEN,WordProcessing,VariablePointerIEN,IEN,SetOfCodes

Property DataDomain As %String;

/// %Numeric,%Integer,%String,%FilemanTimeStamp 
Property DataType As %String;

Property MaxLength As %Integer;

/// Description
Property NumericScale As %String;

/// Description
ClassMethod Init() As %Status
{
    Do ..%KillExtent()
    Set sc = $$$OK
    &sql(INSERT INTO CB.AttributeMap(DataType, IRISClassName, IRISPropertyName, MaxLength, VistaField) VALUES('%String','SPatient.SPatient2v001','Name','30','784'))
    &sql(INSERT INTO CB.AttributeMap(DataType, IRISClassName, IRISPropertyName, MaxLength, VistaField) VALUES('%String','SPatient.SPatient2v001','SexCode','50','785'))
    &sql(INSERT INTO CB.AttributeMap(DataType, IRISClassName, IRISPropertyName, MaxLength, VistaField) VALUES('%String','SPatient.SPatient2v001','SelfIdentifiedGenderCode','50','786'))
    &sql(INSERT INTO CB.AttributeMap(DataType, IRISClassName, IRISPropertyName, MaxLength, VistaField) VALUES('%String','SPatient.SPatient2v001','MaritalStatusIEN','50','791'))
    &sql(INSERT INTO CB.AttributeMap(DataType, IRISClassName, IRISPropertyName, MaxLength, VistaField) VALUES('%String','SPatient.SPatient2v001','RaceIEN','50','792'))
    &sql(INSERT INTO CB.AttributeMap(DataType, IRISClassName, IRISPropertyName, MaxLength, VistaField) VALUES('%String','SPatient.SPatient2v001','Occupation','30','793'))
    &sql(INSERT INTO CB.AttributeMap(DataType, IRISClassName, IRISPropertyName, MaxLength, VistaField) VALUES('%String','SPatient.SPatient2v001','ReligiousPreferenceIEN','50','794'))
    &sql(INSERT INTO CB.AttributeMap(DataType, IRISClassName, IRISPropertyName, MaxLength, VistaField) VALUES('%String','SPatient.SPatient2v001','SocialSecurityNumber','50','798'))
    &sql(INSERT INTO CB.AttributeMap(DataType, IRISClassName, IRISPropertyName, MaxLength, VistaField) VALUES('%String','SPatient.SPatient2v001','StreetAddressLine1','35','822'))
    &sql(INSERT INTO CB.AttributeMap(DataType, IRISClassName, IRISPropertyName, MaxLength, VistaField) VALUES('%String','SPatient.SPatient2v001','StreetAddressLine2','30','825'))
    &sql(INSERT INTO CB.AttributeMap(DataType, IRISClassName, IRISPropertyName, MaxLength, VistaField) VALUES('%String','SPatient.SPatient2v001','StreetAddressLine3','30','826'))
    &sql(INSERT INTO CB.AttributeMap(DataType, IRISClassName, IRISPropertyName, MaxLength, VistaField) VALUES('%String','SPatient.SPatient2v001','City','15','827'))
    &sql(INSERT INTO CB.AttributeMap(DataType, IRISClassName, IRISPropertyName, MaxLength, VistaField) VALUES('%String','SPatient.SPatient2v001','StateIEN','50','828'))
    &sql(INSERT INTO CB.AttributeMap(DataType, IRISClassName, IRISPropertyName, MaxLength, VistaField) VALUES('%String','SPatient.SPatient2v001','ZipCode','5','844'))
    &sql(INSERT INTO CB.AttributeMap(DataType, IRISClassName, IRISPropertyName, MaxLength, VistaField) VALUES('%String','SPatient.SPatient2v001','ServiceConnectedCode','50','1010'))
    &sql(INSERT INTO CB.AttributeMap(DataType, IRISClassName, IRISPropertyName, MaxLength, VistaField) VALUES('%String','SPatient.SPatient2v001','VeteranCode','50','1333'))
    &sql(INSERT INTO CB.AttributeMap(DataType, IRISClassName, IRISPropertyName, VistaField) VALUES('%FilemanTimeStamp','SPatient.SPatient2v001','DateOfBirth','789'))
    &sql(INSERT INTO CB.AttributeMap(DataType, IRISClassName, IRISPropertyName, VistaField) VALUES('%FilemanTimeStamp','SPatient.SPatient2v001','DateEnteredIntoFile','809'))
    &sql(INSERT INTO CB.AttributeMap(DataType, IRISClassName, IRISPropertyName, VistaField) VALUES('%Integer','SPatient.SPatient2v001','PatientICN','1289'))
    &sql(INSERT INTO CB.AttributeMap(DataDomain,DataType, IRISClassName, IRISPropertyName, VistaFile) VALUES('FMPK','%String','SPatient.SPatient2v001','PatientIEN','118'))
    &sql(INSERT INTO CB.AttributeMap(DataType, IRISClassName, IRISPropertyName, MaxLength, VistaField) VALUES('%String','Dim.State5v001','Name','30','2808'))
    &sql(INSERT INTO CB.AttributeMap(DataType, IRISClassName, IRISPropertyName, MaxLength, VistaField) VALUES('%String','Dim.State5v001','Abbreviation','5','2809'))
    &sql(INSERT INTO CB.AttributeMap(DataType, IRISClassName, IRISPropertyName, MaxLength, VistaField) VALUES('%String','Dim.State5v001','VAStateCode','2','2810'))
    &sql(INSERT INTO CB.AttributeMap(DataType, IRISClassName, IRISPropertyName, MaxLength, VistaField) VALUES('%String','Dim.State5v001','Capital','30','2814'))
    &sql(INSERT INTO CB.AttributeMap(DataDomain,DataType, IRISClassName, IRISPropertyName, VistaFile) VALUES('FMPK','%String','Dim.State5v001','StateIEN','294'))
    &sql(INSERT INTO VX130.GlobalsToWatch(GlobalName,ClassName,NumberOfSubscripts,PrimaryKeys,FirstSubscript,SubscriptCompare) VALUES ('^DPT','SPatient.SPatient2v001',2,'1',NULL,NULL))
    &sql(INSERT INTO VX130.GlobalsToWatch(GlobalName,ClassName,NumberOfSubscripts,PrimaryKeys,FirstSubscript,SubscriptCompare) VALUES ('^DIC','Dim.State5v001',3,'2','5',NULL))
    
    Return sc
}

/// Given a VistaFile ID, add all VistaFields to the attributeMap
ClassMethod New(pVistaFileID As %Integer, pIRISClassName As %String) As %Status
{
    Set tSC = $$$OK
    Try {
        &sql(SELECT COUNT(*) INTO :tCOUNT FROM CB.AttributeMap WHERE IRISClassName=:pIRISClassName)
        if $GET(tCOUNT)>0 {
            set tSC=$SYSTEM.Status.Error(5001, pIRISClassName_" was found in AttributeMap. Re-version or remove records from AttributeMap.")
            quit
        }
        set tSC=..AddPrimaryKeys(pVistaFileID,pIRISClassName,.tParentVistaFile)
        quit:'tSC
        while $GET(tParentVistaFile)]"" {
            set tSC=..AddPrimaryKeys(tParentVistaFile,pIRISClassName,.tParentVistaFile)
            quit:'tSC
        }
        set tSQL="SELECT ID,VistaFieldName,VistaFieldType,VistaFieldNumericScale "_
            "FROM Dim.VistaFieldv001 WHERE VistaFile=? "_
            "AND VistaFieldType NOT IN ('SubFile','Computed')"
        set tRSet=##class(%SQL.Statement).%ExecDirect(.tStatement,tSQL,pVistaFileID)
        while tRSet.%Next() {
            set tPointer=0
            set tSoC=0
            set tAMap=..%New()
            set tAMap.IRISClassName=pIRISClassName
            set tVistaField=##class(Dim.VistaFieldv001).%OpenId(tRSet.%Get("ID"))
            set tAMap.VistaField=tVistaField
            set tType=tRSet.%Get("VistaFieldType")
            if tType["Date" {
                set tType="%FilemanTimeStamp"
            } elseif tType["Numeric" {
                set tType="%Numeric"
                set tVistaFieldNumericScale=tRSet.%Get("VistaFieldNumericScale")
                set tAMap.NumericScale=tVistaFieldNumericScale
                if $PIECE(tVistaFieldNumericScale,",",2)=0 {
                    set tType="%Integer"
                } 
            } elseif tType="Pointer" {
                set tPointer=1
                set tType="%String"
                set tAMap.MaxLength=50
            } elseif tType="SetOfCodes" {
                set tSoC=1
                set tType="%String"
                set tAMap.MaxLength=50
            } elseif (tType="WordProcessing") {
                set tAMap.MaxLength=8000
            } else {
                set tType="%String"
                if tVistaField.VistaFieldLength]"" {
                    set tAMap.MaxLength=tVistaField.VistaFieldLength
                } else {
                    set tAMap.MaxLength=50
                }
                
            }
            set tAMap.DataType=tType
            set tAMap.IRISPropertyName=..FMToIRIS(tRSet.%Get("VistaFieldName"),tPointer,tSoC)
            
            set tSC=tAMap.%Save()
            quit:$$$ISERR(tSC)
        }
    }
    Catch ex {
        Set tSC=ex.AsStatus()
    }
    Return tSC
}

/// Given a VistaFieldName transform into an IRIS PropertyName
ClassMethod FMToIRIS(pFMFieldName As %String, pPointer As %Boolean, pSoC As %Boolean, ByRef tSC As %Status) As %String
{
    
    Set tSC = $$$OK
    Try {
        Set tIRISName=$ZCONVERT(pFMFieldName,"W")
        Set tIRISName=$ZSTRIP(tIRISName,"*P")
        if pPointer {
            set tIRISName=tIRISName_"IEN"
        }
        if pSoC {
            set tIRISName=tIRISName_"Code"
        }
    }
    Catch ex {
        Set tSC=ex.AsStatus()
    }
    Return tIRISName
}

/// Description
Query GetClassMap(pIRISClassName As %String) As %SQLQuery [ SqlProc ]
{
    SELECT IRISPropertyName,VistaField->VistaFieldNumber,VistaField->VistaFileNumber, DataDomain, DataType, VistaField->VistaFieldDescription
    FROM CB.AttributeMap
    WHERE IRISClassName=:pIRISClassName
}

/// Description
ClassMethod AddPrimaryKeys(pVistaFileID As %Integer, pIRISClassName As %String, ByRef tVistaParentFile As %Integer) As %Status
{
    Set tSC = $$$OK
    Try {
        set tSQL="SELECT %NOLOCK ParentVistaFile,VistaFileName FROM Dim.VistaFilev001 WHERE ID=?"
        set tRSet=##class(%SQL.Statement).%ExecDirect(.tStatement,tSQL,pVistaFileID)
        do tRSet.%Next()
        set tVistaFileName=tRSet.%Get("VistaFileName")
        if tVistaFileName']"" {
            set tSC=$SYSTEM.Status.Error(5001,"VistaFileName is NULL for VistaFile with ID="_pVistaFileID)
            quit
        }
        set tPrimaryKey=..%New()
        set tPrimaryKey.VistaFile=##class(Dim.VistaFilev001).%OpenId(pVistaFileID)
        set tPrimaryKey.DataDomain="FMPK"
        set tPrimaryKey.IRISClassName=pIRISClassName
        set tPrimaryKey.DataType="%String"
        set tPrimaryKey.IRISPropertyName=..FMToIRIS(tRSet.%Get("VistaFileName"),1)
        set tPrimaryKey.MaxLength=50
        set tSC=tPrimaryKey.%Save()
        quit:'tSC
        set tVistaParentFile=tRSet.%Get("ParentVistaFile")
    }
    Catch ex {
        Set tSC=ex.AsStatus()
    }
    Return tSC
}

/// Description
ClassMethod DeleteAttributeMap(pIRISClassName As %String) As %Status
{
    Set sc = $$$OK
    Try {
        &sql(DELETE %NOLOCK FROM CB.AttributeMap where IRISClassName=:pIRISClassName)
    }
    Catch ex {
        Set tSC=ex.AsStatus()
    }
    Return sc
}

/// Description
ClassMethod AddMap(pIRISClassName As %String, pFMFieldId As %Integer) As %Status
{
    Set sc = $$$OK
    Try {
        set tSQL="SELECT ID,VistaFieldName,VistaFieldType,VistaFieldNumericScale "_
            "FROM Dim.VistaFieldv001 WHERE ID=? "
        set tRSet=##class(%SQL.Statement).%ExecDirect(.tStatement,tSQL,pFMFieldId)
        while tRSet.%Next() {
            set tPointer=0
            set tSoC=0
            set tAMap=..%New()
            set tAMap.IRISClassName=pIRISClassName
            set tVistaField=##class(Dim.VistaFieldv001).%OpenId(tRSet.%Get("ID"))
            set tAMap.VistaField=tVistaField
            set tType=tRSet.%Get("VistaFieldType")
            if tType["Date" {
                set tType="%FilemanTimeStamp"
            } elseif tType["Numeric" {
                set tType="%Numeric"
                set tVistaFieldNumericScale=tRSet.%Get("VistaFieldNumericScale")
                set tAMap.NumericScale=tVistaFieldNumericScale
                if $PIECE(tVistaFieldNumericScale,",",2)=0 {
                    set tType="%Integer"
                } 
            } elseif tType="Pointer" {
                set tPointer=1
                set tType="%String"
                set tAMap.MaxLength=50
            } elseif tType="SetOfCodes" {
                set tSoC=1
                set tType="%String"
                set tAMap.MaxLength=50
            } elseif (tType="WordProcessing") {
                set tAMap.MaxLength=8000
            } else {
                set tType="%String"
                if tVistaField.VistaFieldLength]"" {
                    set tAMap.MaxLength=tVistaField.VistaFieldLength
                } else {
                    set tAMap.MaxLength=50
                }
                
            }
            set tAMap.DataType=tType
            set tAMap.IRISPropertyName=..FMToIRIS(tRSet.%Get("VistaFieldName"),tPointer,tSoC)
            
            set tSC=tAMap.%Save()
            quit:$$$ISERR(tSC)
        }
    }
    Catch ex {
        Set tSC=ex.AsStatus()
    }
    Return sc
}

Storage Default
{
<Data name="AttributeMapDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>IRISPropertyName</Value>
</Value>
<Value name="3">
<Value>IRISClassName</Value>
</Value>
<Value name="4">
<Value>VistaField</Value>
</Value>
<Value name="5">
<Value>VistaFile</Value>
</Value>
<Value name="6">
<Value>DataDomain</Value>
</Value>
<Value name="7">
<Value>DataType</Value>
</Value>
<Value name="8">
<Value>MaxLength</Value>
</Value>
<Value name="9">
<Value>NumericScale</Value>
</Value>
</Data>
<DataLocation>^CB.AttributeMapD</DataLocation>
<DefaultData>AttributeMapDefaultData</DefaultData>
<IdLocation>^CB.AttributeMapD</IdLocation>
<IndexLocation>^CB.AttributeMapI</IndexLocation>
<StreamLocation>^CB.AttributeMapS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
