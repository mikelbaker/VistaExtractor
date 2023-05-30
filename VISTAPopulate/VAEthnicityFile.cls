/// A Class that contains all of the Ethnicity records from the ETHNICITY File # 10.2
Class VISTAPopulate.VAEthnicityFile Extends %Persistent
{

Property Ethnicity As %String(COLLATION = "EXACT");

Property Abbreviation As %String;

Property HL7Value As %String;

Property CDCValue As %String;

Property PTFValue As %String;

Property Inactive As %Boolean;

Property InactivationDate As %Date;

Property IEN As %Integer;

Index EthnicityIndex On Ethnicity;

ClassMethod PopulateFromVISTA()
{
	Write !,"Initializing VAEthnicityFile Data...",!
	Write "Deleting old Data...",!
	Do ..%KillExtent()
	Write "Adding new Data...",!
	Set D0=$Order(^DIC(10.2,0))
	While +D0
	{
		Set oEthn=..%New()
		Set oEthn.Ethnicity=$Piece($Get(^DIC(10.2,D0,0)),"^",1) 
		Set oEthn.Abbreviation=$Piece($Get(^DIC(10.2,D0,0)),"^",2)
		Set oEthn.HL7Value=$Piece($Get(^DIC(10.2,D0,0)),"^",3)
		Set oEthn.CDCValue=$Piece($Get(^DIC(10.2,D0,0)),"^",4)
		Set oEthn.PTFValue=$Piece($Get(^DIC(10.2,D0,0)),"^",5)
		Set oEthn.Inactive=$Piece($Get(^DIC(10.2,D0,.02)),"^",1)
		Set InactiveDate=$Piece($Get(^DIC(10.2,D0,.02)),"^",2)
		Set:+InactiveDate oEthn.InactivationDate=##class(%FilemanDate).LogicalToDate(InactiveDate)
		Set oEthn.IEN=D0
		Write:oEthn.%Save() "."
		Set D0=$Order(^DIC(10.2,D0))
	}
}

Storage Default
{
<Data name="VAEthnicityFileDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Ethnicity</Value>
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
<DataLocation>^VISTAPopulate.VAEthnicityFileD</DataLocation>
<DefaultData>VAEthnicityFileDefaultData</DefaultData>
<IdLocation>^VISTAPopulate.VAEthnicityFileD</IdLocation>
<IndexLocation>^VISTAPopulate.VAEthnicityFileI</IndexLocation>
<StreamLocation>^VISTAPopulate.VAEthnicityFileS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
