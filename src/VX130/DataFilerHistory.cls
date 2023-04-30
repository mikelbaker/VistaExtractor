Class VX130.DataFilerHistory Extends %Persistent
{

/// Description
Property StartDateTime As %TimeStamp;

/// Description
Property NumberFiled As %Integer;

/// Description
Property EndDateTime As %TimeStamp;

/// Description
Property ClassName As %String(COLLATION = "EXACT", MAXLEN = 250);

/// Description
Property Sta3n As %Integer;

/// Description
Property NumberErrored As %Integer;

/// Description
Index StartDateIndex On StartDateTime;

/// Description
Index ClassNameIndex On ClassName;

/// Description
Index FilingIndex On (ClassName, Sta3n, EndDateTime);

/// Description
ClassMethod StartFilers() As %Status
{
    Set tSC = $$$OK
    Try {
        set tSQL="SELECT %NOLOCK ClassName,Sta3n,COUNT(*) As NumRecords FROM VX130.DataFilerQueue GROUP BY ClassName,Sta3n ORDER BY NumRecords DESC"
        set tRSet=##class(%SQL.Statement).%ExecDirect(.tStatement,tSQL)
        while tRSet.%Next() {
            set tClassName=tRSet.%Get("ClassName")
            set tSta3n=tRSet.%Get("Sta3n")
            &sql(SELECT %NOLOCK COUNT(*) INTO :tCnt FROM VX130.DataFilerHistory WHERE ClassName=:tClassName AND Sta3n=:tSta3n and EndDateTime is NULL )
            if $GET(tCnt)=0 {
                Job ##class(VX130.DataFiler).FileRecords(tClassName,tSta3n)
            }
        }
    }
    Catch ex {
        Set tSC=ex.AsStatus()
    }
    Return tSC
}

Storage Default
{
<Data name="DataFilerHistoryDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>StartDateTime</Value>
</Value>
<Value name="3">
<Value>NumberFiled</Value>
</Value>
<Value name="4">
<Value>EndDateTime</Value>
</Value>
<Value name="5">
<Value>ClassName</Value>
</Value>
<Value name="6">
<Value>Sta3n</Value>
</Value>
<Value name="7">
<Value>NumberErrored</Value>
</Value>
</Data>
<DataLocation>^VX130.DataFilerHistoryD</DataLocation>
<DefaultData>DataFilerHistoryDefaultData</DefaultData>
<IdLocation>^VX130.DataFilerHistoryD</IdLocation>
<IndexLocation>^VX130.DataFilerHistoryI</IndexLocation>
<StreamLocation>^VX130.DataFilerHistoryS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
