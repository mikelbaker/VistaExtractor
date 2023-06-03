Class SDA.Utility Extends %RegisteredObject
{

/// Description
ClassMethod GetName(pName As %String, ByRef pSC As %Status) As HS.SDA3.Name
{
    Set pSC = $$$OK
    set tName=##class(HS.SDA3.Name).%New()
    Try {
        Set tName.GivenName=$PIECE($PIECE(pName,",",2)," ",1)
        Set tName.FamilyName=$PIECE(pName,",",1)
    }
    Catch ex {
        Set pSC=ex.AsStatus()
    }
    Return tName
}

ClassMethod GetAddress(pSta3n As %Integer, pStreet1 As %String, pStreet2 As %String, pCity As %String, pStateIEN As %String, pZip As %String, pType As %String = "Home", ByRef pSC As %Status) As HS.SDA3.Address
{
    Set pSC = $$$OK
    set tAddress=##class(HS.SDA3.Address).%New()
    Try {
        Set tAddress.Street = pStreet1_$SELECT(pStreet2]"":" "_pStreet2,1:"")
        Set tAddress.City.Description = pCity
        Set tAddress.State.Description = ..GetStateAbv(pSta3n,pStateIEN)
        Set tAddress.Zip.Code = pZip
        set tAddress.Use.Description = pType
    }
    Catch ex {
        Set pSC=ex.AsStatus()
    }
    Return tAddress
}

/// Description
ClassMethod GetPatient(pClassName As %String, pSta3n As %Integer, pPatientIEN As %String, pSC As %Status) As HS.SDA3.Patient
{
	Set tSC = $$$OK
	Try {
        set tSDAPatient=##class(HS.SDA3.Patient).%New()
        set tId=pSta3n_"||"_pPatientIEN
		set tPatient=$CLASSMETHOD(pClassName,"%OpenId",tId)
        quit:'$ISOBJECT(tPatient)
		
		set tSDAPatient.MPIID=tPatient.ICN
		set tSDAPatient.Name=..GetName(tPatient.Name)
        set tSDAPatient.Gender.Code=tPatient.SexCode
		set tSDAPatient.BirthTime=##class(%FilemanTimeStamp).LogicalToOdbc(tPatient.DateOfBirth)
        
        
		do tSDAPatient.Addresses.Insert(..GetAddress(
			tPatient.StreetAddressLine1,
			tPatient.StreetAddressLine2,
			tPatient.City,
			..GetStateAbv(pSta3n,tPatient.StateIEN),
			tPatient.Zip4))
		
		do tSDAPatient.ToQuickXML()
		quit
	}
	Catch ex {
		Set tSC=ex.AsStatus()
	}
	Return tSDAPatient
}

/// Description
ClassMethod GetStateAbv(pSta3n As %Integer, pStateIEN As %String, pSC As %Status) As %String
{
    Set pSC = $$$OK
    Try {
        set tStateAbv=""
        set tId=pSta3n_"||"_pStateIEN
        set tState=$CLASSMETHOD("Dim.State5v001","%OpenId",tId)
        set tStateAbv = $SELECT($ISOBJECT(tState):tState.Abbreviation,1:"")
    }
    Catch ex {
        Set pSC=ex.AsStatus()
    }
    Return tStateAbv
}

}
