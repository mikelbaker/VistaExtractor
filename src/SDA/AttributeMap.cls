Class SDA.AttributeMap Extends %Persistent
{

/// Description
Property VX130ClassName As %String(COLLATION = "EXACT", MAXLEN = 250);

/// Description
Property VX130Properties As %String(COLLATION = "EXACT", MAXLEN = 500);

/// Description
Property SDAClassName As %String(COLLATION = "EXACT", MAXLEN = 250);

/// Description
Property SDAPropertyName As %String(COLLATION = "EXACT", MAXLEN = 250);

/// Description
Property HelperClassMethod As %String(COLLATION = "EXACT", MAXLEN = 500);

/// Description
Property List As %Boolean;

/// Description
ClassMethod Init() As %Status
{
    Set tSC = $$$OK
    Try {
        do ..%KillExtent()
        &SQL(INSERT INTO SDA.AttributeMap(SDAClassName,SDAPropertyName,VX130ClassName,VX130Properties,HelperClassMethod)
            VALUES('HS.SDA3.Patient','MPIID','SPatient.SPatient2v001','PatientICN',NULL))
        &SQL(INSERT INTO SDA.AttributeMap(SDAClassName,SDAPropertyName,VX130ClassName,VX130Properties,HelperClassMethod)
            VALUES('HS.SDA3.Patient','Name','SPatient.SPatient2v001','Name','##class(SDA.Utility).GetName'))
        &SQL(INSERT INTO SDA.AttributeMap(SDAClassName,SDAPropertyName,VX130ClassName,VX130Properties,HelperClassMethod)
            VALUES('HS.SDA3.Patient','Gender.Code','SPatient.SPatient2v001','SexCode',NULL))
        &SQL(INSERT INTO SDA.AttributeMap(SDAClassName,SDAPropertyName,VX130ClassName,VX130Properties,HelperClassMethod)
            VALUES('HS.SDA3.Patient','BirthTime','SPatient.SPatient2v001','DateOfBirth','##class(%FilemanTimeStamp).LogicalToOdbc'))
        &SQL(INSERT INTO SDA.AttributeMap(SDAClassName,SDAPropertyName,VX130ClassName,VX130Properties,HelperClassMethod,List)
            VALUES('HS.SDA3.Patient','Addresses','SPatient.SPatient2v001','Sta3n,StreetAddressLine1,StreetAddressLine2,City,StateIEN,ZipCode','##class(SDA.Utility).GetAddress',1))
        
    }
    Catch ex {
        Set tSC=ex.AsStatus()
    }
    Return tSC
}

/// Description
ClassMethod SDACode(pVX130ClassName As %String, ByRef pSC As %Status) As %String
{
    Set pSC = $$$OK
    Try {
        set tCode=$C(9)_"Set pSC = $$$OK"_$C(13,10)_
	        $C(9)_"Try {"_$C(13,10)
        set tSQL="SELECT SDAClassName,SDAPropertyName,VX130ClassName, VX130Properties,HelperClassMethod,List "_
            "FROM SDA.AttributeMap WHERE VX130ClassName=?"
        set tRSet=##class(%SQL.Statement).%ExecDirect(.tStatement,tSQL,pVX130ClassName)
        while tRSet.%Next() {
            if $GET(tSDAClassName)']"" {
                set tSDAClassName=tRSet.%Get("SDAClassName")
                set tCode=tCode_$C(9,9)_"Set tSDA=##class("_tSDAClassName_").%New()"_$C(13,10)_
                    $C(9,9)_"Set tOref=..%OpenId(pId,0)"_$C(13,10)_
                    $C(9,9)_"Quit:'$ISOBJECT(tOref)"_$C(13,10,13,10)
            }
            set tHelper=tRSet.%Get("HelperClassMethod")
            set tVX130Properties=tRSet.%Get("VX130Properties")
            set tList=tRSet.%Get("List")
            set tSDAProperty=tRSet.%Get("SDAPropertyName")
            if tHelper']"" {
                Set tCode=tCode_$C(9,9)_"set tSDA."_tSDAProperty_"=tOref."_tVX130Properties_$C(13,10)
            } else {
                set tPropertyList=$LISTFROMSTRING(tVX130Properties,",")
                if $LISTLENGTH(tPropertyList)=1 {
                    set tCode=tCode_$C(9,9)_"set tSDA."_tSDAProperty_"="_tHelper_"(tOref."_
                        $LISTGET(tPropertyList,1)_")"_$C(13,10)
                } else {
                    if tList {
                        set tCode=tCode_$C(9,9)_"do tSDA."_tSDAProperty_".Insert("_tHelper_"("_$C(13,10)
                    } else {
                        Set tCode=tCode_$C(9,9)_"set tSDA."_tSDAProperty_"="_tHelper_"("_$C(13,10)
                    }
                    for i=1:1:$LISTLENGTH(tPropertyList) {
                        set tCode=tCode_$C(9,9,9)_"tOref."_$LISTGET(tPropertyList,i)
                        if i<$LISTLENGTH(tPropertyList) {
                            set tCode=tCode_","_$C(13,10)
                        }
                    }
                    if tList {
                        set tCode=tCode_"))"_$C(13,10)
                    } else {
                        set tCode=tCode_")"_$C(13,10)
                    }
                }
            }      
        }
        set tCode=tCode_$C(13,10,9,9)_"//do tSDA.ToQuickXML()"_$C(13,10)_
            $C(9,9)_"quit"_$C(13,10)_
            $C(9)_"}"_$C(13,10)_
            $C(9)_"Catch ex {"_$C(13,10)_
            $C(9,9)_"Set pSC=ex.AsStatus()"_$C(13,10)_
            $C(9)_"}"_$C(13,10)_
            $C(9)_"Return tSDA"_$C(13,10)
    }
    Catch ex {
        Set pSC=ex.AsStatus()
    }
    Return tCode
}

Storage Default
{
<Data name="AttributeMapDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>VX130ClassName</Value>
</Value>
<Value name="3">
<Value>VX130Properties</Value>
</Value>
<Value name="4">
<Value>SDAClassName</Value>
</Value>
<Value name="5">
<Value>SDAPropertyName</Value>
</Value>
<Value name="6">
<Value>HelperClassMethod</Value>
</Value>
<Value name="7">
<Value>List</Value>
</Value>
</Data>
<DataLocation>^SDA.AttributeMapD</DataLocation>
<DefaultData>AttributeMapDefaultData</DefaultData>
<IdLocation>^SDA.AttributeMapD</IdLocation>
<IndexLocation>^SDA.AttributeMapI</IndexLocation>
<StreamLocation>^SDA.AttributeMapS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
