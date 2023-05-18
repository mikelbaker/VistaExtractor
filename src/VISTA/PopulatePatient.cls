Class VISTA.PopulatePatient Extends %RegisteredObject
{

/// Description
ClassMethod GetReferenceData() As %Status
{
    Set sc = $$$OK
    do ##class(VISTA.VARaceFile).PopulateFromVISTA()
    do ##class(VISTA.VAMaritalStatusFile).PopulateFromVISTA()
    do ##class(VISTA.VATypeOfPatientFile).PopulateFromVISTA()
    do ##class(VISTA.VAInsuranceFile).PopulateFromVISTA()
    do ##class(VISTA.VAEthnicityFile).PopulateFromVISTA()
    do ##class(VISTA.OccupationData).Populate()
    do ##class(VISTA.Patient).Populate(100)
    set tSQL="SELECT %NOLOCK ID FROM VISTA.Patient"
    set tRSet=##class(%SQL.Statement).%ExecDirect(.tStatement,tSQL)
    while tRSet.%Next() {
        set tID=tRSet.%Get("ID")
        set tOref=##class(VISTA.Patient).%OpenId(tID)
        do tOref.LoadVISTAPatient()
    }
    Return sc
}

}
