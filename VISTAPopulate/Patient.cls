Class VISTAPopulate.Patient Extends (%Persistent, %Populate)
{

Property Name As %String(COLLATION = "EXACT");

Property SSN As %String;

Property Gender As %String(DISPLAYLIST = ",FEMALE,MALE", VALUELIST = ",F,M");

Property DateOfBirth As %Date(MAXVAL = 57425, MINVAL = 25670);

Property Street As %String;

Property City As %String;

Property State As %String;

Property ZIP As %String;

Property Phone As %String;

Property Race As VISTAPopulate.VARaceFile;

Property Ethnicity As VISTAPopulate.VAEthnicityFile;

Property EmploymentStatus As %String(DISPLAYLIST = ",EMPLOYED FULL TIME,EMPLOYED PART TIME,NOT EMPLOYED,SELF EMPLOYED,RETIRED,ACTIVE MILITARY DUTY,UNKNOWN", VALUELIST = ",1,2,3,4,5,6,9");

Property Insurance As VISTAPopulate.VAInsuranceFile;

Property Occupation As VISTAPopulate.OccupationData;

Property Veteran As %Boolean;

Property IntegrationControlNumber As %Integer(MAXVAL = 500000, MINVAL = 10000);

Property MaritalStatus As VISTAPopulate.VAMaritalStatusFile;

Property TypeOfPatient As VISTAPopulate.VATypeOfPatientFile;

Index SSNIndex On SSN [ Unique ];

Index IntegrationControlNumberIndex On IntegrationControlNumber [ Unique ];

Index PatientNameIndex On Name;

Method LoadVISTAPatient() [ PublicList = (DUZ, DT, FDA, U, MSG, Sta3n) ]
{
	Set DUZ=1,DUZ(0)="@",DT=##class(%FilemanDate).DateToLogical($H)
	If $Data(^DPT("B",$ZCONVERT(..Name,"U"))) WRite "Patient Record Exists..",! Quit
	Set FDA(2,"+1,",.01)=$ZCONVERT(..Name,"U")
	Set FDA(2,"+1,",.02)=..Gender
	Set FDA(2,"+1,",.03)=##class(%FilemanDate).DateToLogical(..DateOfBirth)
	Set FDA(2,"+1,",.05)=$Order(^DIC(11,"B",..MaritalStatus.MaritalStatus,0))
	Set FDA(2,"+1,",.06)=$Order(^DIC(10,"B",$Extract(..Race.Race,1,30),0))
	Set FDA(2,"+1,",.07)=..Occupation.OccupationName
	Set FDA(2,"+1,",.09)=$Replace(..SSN,"-","")
	Set FDA(2,"+1,",.111)=$ZCONVERT(..Street,"U")
	Set FDA(2,"+1,",.112)=""        ; Street Line 2
	Set FDA(2,"+1,",.114)=$ZCONVERT(..City,"U")
	Set FDA(2,"+1,",.115)=$Order(^DIC(5,"C",$ZCONVERT(..State,"U"),0))
	Set FDA(2,"+1,",.1112)=..ZIP
	Set FDA(2,"+1,",.131)=..Phone
	Set FDA(2,"+1,",391)=$Order(^DG(391,"B",..TypeOfPatient.TypeOfPatient,0))
	Set FDA(2,"+1,",1901)=$Case(..Veteran,1:"Y",0:"N",:"")
	Set FDA(2,"+1,",.12105)="N"     ; TEMPORARY ADD ACTIVE
	Set FDA(2,"+1,",.2125)="N"      ; K-ADD SAME AS PNT'S
	Set FDA(2,"+1,",.21925)="N"     ; K2-ADD SAME AS PNT'S
	Set FDA(2,"+1,",.2515)="1"      ; SPOUSE EMPLOYMENT STATUS
	Set FDA(2,"+1,",.301)="N"       ; SERVICE CONNECTED
	Set FDA(2,"+1,",.31115)=..EmploymentStatus  ; EMPLOYMENT STATUS
	Set FDA(2,"+1,",.3192)="Y"      ; COVERED BY HEALTH INSURANCE
	Set FDA(2,"+1,",.32101)="Y"     ; VIETNAM SERVICE INDICATED
	Set FDA(2,"+1,",.32102)="N"     ; AGENT ORANGE EXPOS. INDICATED
	Set FDA(2,"+1,",.32103)="N"     ; RADIATION EXPOSURE INDICATED
	Set FDA(2,"+1,",.32201)="N"     ; PERSIAN GULF SERVICE
	Set FDA(2,"+1,",.322013)="N"    ; ENVIRONMENTAL CONTAMINANTS
	Set FDA(2,"+1,",.322016)="N"    ; SOMALIA SERVICE INDICATED
	Set FDA(2,"+1,",.3221)="N"      ; LEBANON SERVICE INDICATED
	Set FDA(2,"+1,",.3224)="N"      ; GRENEDA SERVICE INDICATED
	Set FDA(2,"+1,",.3227)="N"      ; PANAMA SERVICE INDICATED
	Set FDA(2,"+1,",.3285)="N"      ; SERVICE SECOND EPISODE
	Set FDA(2,"+1,",.32945)="N"     ; SERVICE THIRD EPISODE
	Set FDA(2,"+1,",.3305)="Y"      ; E-EMER. CONTACT SAME AS NOK
	Set FDA(2,"+1,",.3405)="Y"      ; D-DESIGNEE SAME AS NOK
	Set FDA(2,"+1,",.362)="0"       ; DISABILITY RET. FROM MILITARY
	Set FDA(2,"+1,",.381)="0"       ; ELIGIBLE FOR MEDICAID
	Set FDA(2,"+1,",.525)="N"       ; POW STATUS INDICATED
	Set FDA(2,"+1,",.5291)="N"      ; COMBAT SERVICE INDICATED
	Set FDA(2,"+1,",1010.15)="Y"    ; RECIEVED VA CARE PREVIOUSLY
	Set FDA(2,"+1,",994)="N"        ; MULTIPLE BIRTH INDICATOR 
	Set FDA(2,"+1,",991.01)=..IntegrationControlNumber
	Set FDA(2,"+1,",991.1)=..IntegrationControlNumber_"V"_$$CHECKDG^MPIFSPC(..IntegrationControlNumber)
	Set FDA(2.02,"+2,+1,",.01)=$Order(^DIC(10,"B",$Extract(..Race.Race,1,30),0))
	Set FDA(2.02,"+2,+1,",.02)="S"

	Set FDA(2.06,"+3,+1,",.01)=$Order(^DIC(10.2,"B",$Extract(..Ethnicity.Ethnicity,1,30),0))
 	Set FDA(2.06,"+3,+1,",.02)="S" 
	//Set FDA(2.312,"+4,+1,",.01)=$Order(^DIC(36,"B",$Extract($ZCONVERT(..Insurance.CompanyName,"U"),1,30),0))
	D UPDATE^DIE("","FDA",,"MSG")
	If $Get(MSG("DIERR","1","TEXT",1))]"" WRite $Get(MSG("DIERR","1","TEXT",1)),! ZW
	Else  Write "."
	Quit
}

Storage Default
{
<Data name="PatientDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Name</Value>
</Value>
<Value name="3">
<Value>SSN</Value>
</Value>
<Value name="4">
<Value>Gender</Value>
</Value>
<Value name="5">
<Value>DateOfBirth</Value>
</Value>
<Value name="6">
<Value>Street</Value>
</Value>
<Value name="7">
<Value>City</Value>
</Value>
<Value name="8">
<Value>State</Value>
</Value>
<Value name="9">
<Value>ZIP</Value>
</Value>
<Value name="10">
<Value>Phone</Value>
</Value>
<Value name="11">
<Value>Race</Value>
</Value>
<Value name="12">
<Value>Ethnicity</Value>
</Value>
<Value name="13">
<Value>EmploymentStatus</Value>
</Value>
<Value name="14">
<Value>Insurance</Value>
</Value>
<Value name="15">
<Value>Occupation</Value>
</Value>
<Value name="16">
<Value>Veteran</Value>
</Value>
<Value name="17">
<Value>IntegrationControlNumber</Value>
</Value>
<Value name="18">
<Value>MaritalStatus</Value>
</Value>
<Value name="19">
<Value>TypeOfPatient</Value>
</Value>
</Data>
<DataLocation>^VISTAPopulate.PatientD</DataLocation>
<DefaultData>PatientDefaultData</DefaultData>
<IdLocation>^VISTAPopulate.PatientD</IdLocation>
<IndexLocation>^VISTAPopulate.PatientI</IndexLocation>
<StreamLocation>^VISTAPopulate.PatientS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
