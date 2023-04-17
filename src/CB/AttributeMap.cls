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

// Description

Property DataDomain As %String;

// PKIEN,WordProcessing,VariablePointerIEN,IEN,SetOfCodes

/// Description
Property DataType As %String;

// %Numeric,%Integer,%String,%FilemanTimeStamp 

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
        set tSQL="SELECT ID,VistaFieldName,VistaFieldType "_
            "FROM Dim.VistaFieldv001 WHERE VistaFile=? "_
            "AND VistaFieldType NOT IN ('SubFile','Computed')"
        set tRSet=##class(%SQL.Statement).%ExecDirect(.tStatement,tSQL,pVistaFileID)
        while tRSet.%Next() {
            set tAMap=..%New()
            set tAMap.IRISClassName=pIRISClassName
            set tVistaField=##class(Dim.VistaFieldv001).%OpenId(tRSet.%Get("ID"))
            set tAMap.VistaField=tVistaField
            set tType=tRSet.%Get("VistaFieldType")
            set tAMap.DataType=tType
            set tAMap.IRISPropertyName=..FMToIRIS(tRSet.%Get("VistaFieldName"),$CASE(tType,"Pointer":1,:0))
            
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
ClassMethod FMToIRIS(pFMFieldName As %String, pPointer As %Boolean, ByRef tSC As %Status) As %String
{
    
    Set tSC = $$$OK
    Try {
        Set tIRISName=$ZCONVERT(pFMFieldName,"W")
        Set tIRISName=$ZSTRIP(tIRISName,"*P")
        if pPointer {
            set tIRISName=tIRISName_"IEN"
        }
    }
    Catch ex {
        Set tSC=ex.AsStatus()
    }
    Return tIRISName
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
</Data>
<DataLocation>^CB.AttributeMapD</DataLocation>
<DefaultData>AttributeMapDefaultData</DefaultData>
<IdLocation>^CB.AttributeMapD</IdLocation>
<IndexLocation>^CB.AttributeMapI</IndexLocation>
<StreamLocation>^CB.AttributeMapS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
