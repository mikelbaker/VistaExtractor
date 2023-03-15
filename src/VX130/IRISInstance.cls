/// A list of all IRIS instances known to the VX130 system.
Class VX130.IRISInstance Extends (%Persistent, %JSON.Adaptor)
{

/// A unique id for the IRIS instance.
Property InstanceID As %Integer;

/// The name of the instance or if a container the container name.
Property InstanceName As %String;

/// The port of the IRIS webserver for the instance.
Property WebserverPort As %Integer;

/// The port of the IRIS super server for the instance.
Property SuperServerPort As %Integer;

/// The IPAddress for the IRIS instance or container.
Property IPAddress As %String;

Index MainIndex On InstanceID [ IdKey, PrimaryKey, Unique ];

Index InstanceNameIndex On InstanceName [ Unique ];

/// Add some intial records to the VX130.IRISInstance table.
ClassMethod Init() As %Status
{
    Set tsc = $$$OK
    Try {
        &sql(INSERT INTO VX130.IRISInstance(InstanceID,InstanceName,WebserverPort,SuperServerPort,IPAddress) VALUES(8,'v08',52773,1972,'v08') )
    }
    Catch ex {
        Set tsc=ex.AsStatus()
    }
    Return tsc
}

/// Return The IRISInstanceID of the current Instance.
ClassMethod GetInstanceID() As %Integer
{
    // if using containers leave this uncommented.
    set tInstanceName=$PIECE($SYSTEM,":",1)
    // if using Server uncomment next line.
    //set tInstanceName=$PIECE($SYSTEM,":",2)
    &sql(SELECT ID INTO :tID FROM VX130.IRISInstance WHERE InstanceName=:tInstanceName)
    // do something
    return $GET(tID)
}

Storage Default
{
<Data name="IRISInstanceDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>IRISInstance</Value>
</Value>
<Value name="3">
<Value>InstanceName</Value>
</Value>
<Value name="4">
<Value>WebserverPort</Value>
</Value>
<Value name="5">
<Value>SuperServerPort</Value>
</Value>
<Value name="6">
<Value>IPAddress</Value>
</Value>
</Data>
<DataLocation>^VX130.IRISInstanceD</DataLocation>
<DefaultData>IRISInstanceDefaultData</DefaultData>
<IdLocation>^VX130.IRISInstanceD</IdLocation>
<IndexLocation>^VX130.IRISInstanceI</IndexLocation>
<StreamLocation>^VX130.IRISInstanceS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
