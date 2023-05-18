/// A Class that contains all of the Patient Types From the TYPE OF PATIENT File # 391
Class VISTA.VATypeOfPatientFile Extends %Persistent
{

Property TypeOfPatient As %String(COLLATION = "EXACT");

Property IgnoreVeteranChecks As %Boolean;

Property InfoToAsk As %String;

Property MakeRecordSensitive As %Boolean;

Property IsVeteran As %Boolean;

Property IDFormat As %String;

Property NewPatientInputDR As %String(MAXLEN = 250);

Property IEN As %Integer;

Index TypeOfPatientIndex On TypeOfPatient;

ClassMethod PopulateFromVISTA()
{
	Write !,"Initializing VATypeOfPatientFile Data...",!
	Write "Deleting old Data...",!
	Do ..%KillExtent()
	Write "Adding new Data...",!
	Set D0=$Order(^DG(391,0))
	While +D0
	{
		Set oType=..%New()
		Set oType.TypeOfPatient=$Piece($Get(^DG(391,D0,0)),"^",1) 
		Set oType.IgnoreVeteranChecks=$Piece($Get(^DG(391,D0,0)),"^",2)
		Set oType.InfoToAsk=$Piece($Get(^DG(391,D0,0)),"^",3)
		Set oType.MakeRecordSensitive=$Piece($Get(^DG(391,D0,0)),"^",4)
		Set oType.IsVeteran=$Piece($Get(^DG(391,D0,0)),"^",5)
		Set IDFormatIEN=$Piece($Get(^DG(391,D0,0)),"^",5)
		If +IDFormatIEN
		{
			Set oType.IDFormat=$Piece($Get(^DIC(8.2,IDFormatIEN,0)),"^",1)
		}
		Set oType.NewPatientInputDR=$Get(^DG(391,D0,"DR"))
		Set oType.IEN=D0
		Write:oType.%Save() "."
		Set D0=$Order(^DG(391,D0))
	}
}

Storage Default
{
<Data name="VATypeOfPatientFileDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>TypeOfPatient</Value>
</Value>
<Value name="3">
<Value>IgnoreVeteranChecks</Value>
</Value>
<Value name="4">
<Value>InfoToAsk</Value>
</Value>
<Value name="5">
<Value>MakeRecordSensitive</Value>
</Value>
<Value name="6">
<Value>IsVeteran</Value>
</Value>
<Value name="7">
<Value>IDFormat</Value>
</Value>
<Value name="8">
<Value>NewPatientInputDR</Value>
</Value>
<Value name="9">
<Value>IEN</Value>
</Value>
</Data>
<DataLocation>^VISTA.VATypeOfPatientFileD</DataLocation>
<DefaultData>VATypeOfPatientFileDefaultData</DefaultData>
<IdLocation>^VISTA.VATypeOfPatientFileD</IdLocation>
<IndexLocation>^VISTA.VATypeOfPatientFileI</IndexLocation>
<StreamLocation>^VISTA.VATypeOfPatientFileS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
