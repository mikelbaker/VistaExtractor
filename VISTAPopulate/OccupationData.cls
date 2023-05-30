Class VISTAPopulate.OccupationData Extends %Persistent
{

Property OccupationName As %String(COLLATION = "EXACT");

Index OccupationIndex On OccupationName;

ClassMethod AddOccupation(OccupationName As %String)
{
	Set oOccupation=..%New()
	Set oOccupation.OccupationName=OccupationName
	Do oOccupation.%Save()
	Write "."
}

ClassMethod Populate()
{
	Write !,"Initializing Occupation Data...",!
	Do ..%KillExtent()
	For i=4:1 Set name=$Piece($Text(Populate+i),";",3) Quit:name="EOL"  Do ..AddOccupation($ZCONVERT(name,"U"))
	;;Able Seamen
	;;Administrative Assistant
	;;Advertising Account Executive
	;;Aeronautical & Aerospace Engineer
	;;Air Traffic Controller
	;;Airport Administrator
	;;Art Appraiser
	;;Bank Examiner
	;;Biology Professor
	;;Biomedical Engineer
	;;Budget Analyst
	;;Camp Director
	;;Casino Cashier
	;;Chemical Engineer
	;;Chief Financial Officer
	;;University Professor
	;;Computer Programmer
	;;Computer Software Engineers
	;;Court Clerk
	;;Customs Inspector
	;;Dental Hygienist
	;;Dentist (MD)
	;;Electrical Engineers
	;;Elevator Mechanic
	;;Explosives Worker
	;;Farm Hand
	;;File Clerk
	;;Fire Inspector
	;;Funeral Director
	;;Glass Blower
	;;Harbor Master
	;;Hospital Administrator
	;;Hospital Nurse
	;;Hotel Manager
	;;Industrial Engineer
	;;Insurance Claim Examiner
	;;Laboratory Tester
	;;Law Clerks
	;;Loan Officer
	;;Marine Architect
	;;Mechanical Engineer
	;;Medical Photographer
	;;Mining Engineer
	;;Music Therapist
	;;Office Clerk
	;;Personnel Assistant
	;;Physician's Assistant (PA)
	;;Police Officer
	;;Property Accountant
	;;Quarry Worker
	;;Radio Operators
	;;Real Estate Lawyer
	;;Restaurant Manager
	;;Screen Writer
	;;Ship Mate
	;;Social Worker
	;;Sports Agent
	;;Systems Accountant
	;;Teachers Aide
	;;Travel Agent
	;;Watch Repairers
	;;Zoologist
	;;EOL
}

Storage Default
{
<Data name="OccupationDataDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>OccupationName</Value>
</Value>
</Data>
<DataLocation>^VISTAPopulate.OccupationDataD</DataLocation>
<DefaultData>OccupationDataDefaultData</DefaultData>
<IdLocation>^VISTAPopulate.OccupationDataD</IdLocation>
<IndexLocation>^VISTAPopulate.OccupationDataI</IndexLocation>
<StreamLocation>^VISTAPopulate.OccupationDataS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
