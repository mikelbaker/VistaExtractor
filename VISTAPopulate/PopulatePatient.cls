Class VISTAPopulate.PopulatePatient Extends %RegisteredObject
{

/// Description
ClassMethod GetReferenceData() As %Status
{
    Set sc = $$$OK
    do ##class(VISTAPopulate.VARaceFile).PopulateFromVISTA()
    do ##class(VISTAPopulate.VAMaritalStatusFile).PopulateFromVISTA()
    do ##class(VISTAPopulate.VATypeOfPatientFile).PopulateFromVISTA()
    do ##class(VISTAPopulate.VAInsuranceFile).PopulateFromVISTA()
    do ##class(VISTAPopulate.VAEthnicityFile).PopulateFromVISTA()
    do ##class(VISTAPopulate.OccupationData).Populate()
    do ##class(VISTAPopulate.Patient).Populate(100)
    set tSQL="SELECT %NOLOCK ID FROM VISTAPopulate.Patient"
    set tRSet=##class(%SQL.Statement).%ExecDirect(.tStatement,tSQL)
    while tRSet.%Next() {
        set tID=tRSet.%Get("ID")
        set tOref=##class(VISTAPopulate.Patient).%OpenId(tID)
        do tOref.LoadVISTAPatient()
    }
    Return sc
}

}
