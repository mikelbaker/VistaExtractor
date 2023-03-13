Class VX130.DataFilerQueue Extends %Persistent
{

/// Description
Property ClassName As %String(COLLATION = "EXACT", MAXLEN = 500);

/// Description
Property PrimaryKeys As %String;

/// Description
Property Sta3n As %Integer;

/// Description
Property InsertDateTime As %TimeStamp;

Index MainIndex On (ClassName, Sta3n, PrimaryKeys) [ IdKey, PrimaryKey, Unique ];

/// Description
ClassMethod Add(pClassName As %String, pSta3n As %Integer, pPrimaryKeys As %String) As %Status
{
    Set tsc = $$$OK
    Try {
        &sql(INSERT INTO VX130.DataFilerQueue(ClassName,Sta3n,PrimaryKeys,InsertDateTime) VALUES(:pClassName,:pSta3n,:pPrimaryKeys,GETUTCDATE()))
        if ($GET(SQLCODE)'=0)&($GET(SQLCODE)'=100) {
            // error
        }
    }
    Catch ex {
        Set tsc=ex.AsStatus()
    }
    Return tsc
}

Storage Default
{
<Data name="DataFilerQueueDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>ClassName</Value>
</Value>
<Value name="3">
<Value>PrimaryKeys</Value>
</Value>
<Value name="4">
<Value>Sta3n</Value>
</Value>
<Value name="5">
<Value>InsertDateTime</Value>
</Value>
</Data>
<DataLocation>^VX130.DataFilerQueueD</DataLocation>
<DefaultData>DataFilerQueueDefaultData</DefaultData>
<IdLocation>^VX130.DataFilerQueueD</IdLocation>
<IndexLocation>^VX130.DataFilerQueueI</IndexLocation>
<StreamLocation>^VX130.DataFilerQueueS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
