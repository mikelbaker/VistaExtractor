/// A Class that contains all of the Marital Status records from the MARITAL STATUS File # 11
Class VISTAPopulate.VAMaritalStatusFile Extends %Persistent
{

Property MaritalStatus As %String(COLLATION = "EXACT");

Property Abbreviation As %String;

Property MaritalStatusCode As %String(DISPLAYLIST = ",DIVORCED,MARRIED,NEVER MARRIED,SEPARATED,WIDOWED,UNKNOWN;", VALUELIST = ",D,M,N,S,W,U");

Property IEN As %Integer;

Index MaritalStatusIndex On MaritalStatus;

ClassMethod PopulateFromVISTA()
{
	Write !,"Initializing VAMaritalStatusFile Data...",!
	Write "Deleting old Data...",!
	Do ..%KillExtent()
	Write "Adding new Data...",!
	Set D0=$Order(^DIC(11,0))
	While +D0
	{
		Set oMS=..%New()
		Set oMS.MaritalStatus=$Piece($Get(^DIC(11,D0,0)),"^",1) 
		Set oMS.Abbreviation=$Piece($Get(^DIC(11,D0,0)),"^",2)
		Set oMS.MaritalStatusCode=$Piece($Get(^DIC(11,D0,0)),"^",3)
		Set oMS.IEN=D0
		Write:oMS.%Save() "."
		Set D0=$Order(^DIC(11,D0))
	}
}

Storage Default
{
<Data name="VAMaritalStatusFileDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>MaritalStatus</Value>
</Value>
<Value name="3">
<Value>Abbreviation</Value>
</Value>
<Value name="4">
<Value>MaritalStatusCode</Value>
</Value>
<Value name="5">
<Value>IEN</Value>
</Value>
</Data>
<DataLocation>^VISTAPopulate.VAMaritalStC7B6D</DataLocation>
<DefaultData>VAMaritalStatusFileDefaultData</DefaultData>
<IdLocation>^VISTAPopulate.VAMaritalStC7B6D</IdLocation>
<IndexLocation>^VISTAPopulate.VAMaritalStC7B6I</IndexLocation>
<StreamLocation>^VISTAPopulate.VAMaritalStC7B6S</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
