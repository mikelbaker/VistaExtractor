/// A Class that contains all of the Insurance records from the INSURANCE COMPANY File # 36
Class VISTA.VAInsuranceFile Extends %Persistent
{

Property IEN As %Integer;

Property CompanyName As %String(COLLATION = "EXACT");

Property Reimburse As %String(DISPLAYLIST = ",WILL REIMBURSE,WILL REIMBURSE IF TREATED UNDER VAR 6046(C) OR VAR 6060.2(A),DEPENDS ON POLICY - CHECK WITH COMPANY,WILL NOT REIMBURSE;", VALUELIST = ",Y,*,**,N");

Property Street As %String;

Property City As %String;

Property StateIEN As %String;

Property Zip As %String;

Property Fax As %String;

Index InsuranceIndex On CompanyName;

ClassMethod PopulateFromVISTA()
{
	Set D0=$Order(^DIC(36,0))
	if '+D0 {
		set ^DIC(36,1,0)="BLUE CROSS BLUE SHIELD^Y"
		set ^DIC(36,1,.11)="1 MEMORIAL DR^^^BOSTON^25^999991111"
		set ^DIC(36,1,4)="^^^22^0^0^1^0"
		set ^DIC(36,"B","BLUE CROSS BLUE SHIELD",1)=""
	}
	Write !,"Initializing VAInsuranceFile Data...",!
	Write "Deleting old Data...",!
	Do ..%KillExtent()
	Write "Adding new Data...",!
	Set D0=$Order(^DIC(36,0))
	While +D0
	{
		If ($Piece($Get(^DIC(36,D0,0)),"^",1)]"")
		{
			Set oCompany=..%New()
			Set oCompany.CompanyName=$Piece($Get(^DIC(36,D0,0)),"^",1)
			Set oCompany.Reimburse=$Piece($Get(^DIC(36,D0,0)),"^",2)
			Set oCompany.Street=$Piece($Get(^DIC(36,D0,.11)),"^",1)
			Set oCompany.City=$Piece($Get(^DIC(36,D0,.11)),"^",4)
			Set oCompany.StateIEN=$Piece($Get(^DIC(36,D0,.11)),"^",5)
			Set oCompany.Zip=$Piece($Get(^DIC(36,D0,.11)),"^",6)
			Set oCompany.Fax=$Piece($Get(^DIC(36,D0,.11)),"^",9)
			Set oCompany.IEN=D0
			Write:oCompany.%Save() "."
		}
		Set D0=$Order(^DIC(36,D0))
	}
}

Storage Default
{
<Data name="VAInsuranceFileDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>IEN</Value>
</Value>
<Value name="3">
<Value>CompanyName</Value>
</Value>
<Value name="4">
<Value>Reimburse</Value>
</Value>
<Value name="5">
<Value>Street</Value>
</Value>
<Value name="6">
<Value>City</Value>
</Value>
<Value name="7">
<Value>StateIEN</Value>
</Value>
<Value name="8">
<Value>Zip</Value>
</Value>
<Value name="9">
<Value>Fax</Value>
</Value>
</Data>
<DataLocation>^VISTA.VAInsuranceFileD</DataLocation>
<DefaultData>VAInsuranceFileDefaultData</DefaultData>
<IdLocation>^VISTA.VAInsuranceFileD</IdLocation>
<IndexLocation>^VISTA.VAInsuranceFileI</IndexLocation>
<StreamLocation>^VISTA.VAInsuranceFileS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
