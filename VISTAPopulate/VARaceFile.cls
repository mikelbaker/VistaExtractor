/// A Class that contains all of the Race records from the RACE File # 10
Class VISTAPopulate.VARaceFile Extends %Persistent
{

Property Race As %String(COLLATION = "EXACT");

Property Abbreviation As %String;

Property HL7Value As %String;

Property CDCValue As %String;

Property PTFValue As %String;

Property Inactive As %Boolean;

Property InactivationDate As %Date;

Property IEN As %Integer;

Index RaceIndex On Race;

ClassMethod PopulateFromVISTA()
{
	Write !,"Initializing VARaceFile Data...",!
	Write "Deleting old Data...",!
	Do ..%KillExtent()
	Write "Adding new Data...",!
	Set D0=$Order(^DIC(10,0))
	While +D0
	{
		Set oRace=..%New()
		Set oRace.Race=$Piece($Get(^DIC(10,D0,0)),"^",1) 
		Set oRace.Abbreviation=$Piece($Get(^DIC(10,D0,0)),"^",2)
		Set oRace.HL7Value=$Piece($Get(^DIC(10,D0,0)),"^",3)
		Set oRace.CDCValue=$Piece($Get(^DIC(10,D0,0)),"^",4)
		Set oRace.PTFValue=$Piece($Get(^DIC(10,D0,0)),"^",5)
		Set oRace.Inactive=$Piece($Get(^DIC(10,D0,.02)),"^",1)
		Set InactiveDate=$Piece($Get(^DIC(10,D0,.02)),"^",2)
		Set:+InactiveDate oRace.InactivationDate=##class(%FilemanDate).LogicalToDate(InactiveDate)
		Set oRace.IEN=D0
		Write:oRace.%Save() "."
		Set D0=$Order(^DIC(10,D0))
	}
}

Storage Default
{
<Data name="VARaceFileDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Race</Value>
</Value>
<Value name="3">
<Value>Abbreviation</Value>
</Value>
<Value name="4">
<Value>HL7Value</Value>
</Value>
<Value name="5">
<Value>CDCValue</Value>
</Value>
<Value name="6">
<Value>PTFValue</Value>
</Value>
<Value name="7">
<Value>Inactive</Value>
</Value>
<Value name="8">
<Value>InactivationDate</Value>
</Value>
<Value name="9">
<Value>IEN</Value>
</Value>
</Data>
<DataLocation>^VISTAPopulate.VARaceFileD</DataLocation>
<DefaultData>VARaceFileDefaultData</DefaultData>
<IdLocation>^VISTAPopulate.VARaceFileD</IdLocation>
<IndexLocation>^VISTAPopulate.VARaceFileI</IndexLocation>
<StreamLocation>^VISTAPopulate.VARaceFileS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
