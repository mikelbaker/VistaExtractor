/// Store the status for each JournalReader known by VX130.
Class VX130.JournalReaderStatus Extends %Persistent
{

/// A link to the VX130.IRISInstance table.
Property IRISInstance As VX130.IRISInstance;

/// True means run.
/// Anything else means stop.
Property RunFlag As %Boolean;

/// A string that will be populated with the overall health of a 
/// VX130.JournalReader
Property MonitorStatus As %String(MAXLEN = 250);

Index MainIndex On IRISInstance [ IdKey, PrimaryKey, Unique ];

/// Initialize table with data.
ClassMethod Init() As %Status
{
    Set tsc = $$$OK
    Try {
        do ..%KillExtent()
        &sql(INSERT INTO VX130.JournalReaderStatus(IRISInstance,RunFlag) VALUES(8,1))
    }
    Catch ex {
        Set tSC=ex.AsStatus()
    }
    Return tsc
}

/// Get the RunFlag for an IRIS instances journal reader.
ClassMethod GetStatus() As %String
{
    set tInstanceID=##class(VX130.IRISInstance).GetInstanceID()
    &sql(SELECT %NOLOCK RunFlag INTO :tRunFlag FROM VX130.JournalReaderStatus WHERE IRISInstance=:tInstanceID)
    return $GET(tRunFlag)
}

Storage Default
{
<Data name="JournalReaderStatusDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>IRISInstance</Value>
</Value>
<Value name="3">
<Value>RunFlag</Value>
</Value>
<Value name="4">
<Value>MonitorStatus</Value>
</Value>
</Data>
<DataLocation>^VX130.JournalReaderStatusD</DataLocation>
<DefaultData>JournalReaderStatusDefaultData</DefaultData>
<IdLocation>^VX130.JournalReaderStatusD</IdLocation>
<IndexLocation>^VX130.JournalReaderStatusI</IndexLocation>
<StreamLocation>^VX130.JournalReaderStatusS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
