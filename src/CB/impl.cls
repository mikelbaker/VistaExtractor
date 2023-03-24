/// Business logic class defined by OpenAPI in CB.spec<br/>
/// Created Mar 19, 2023 12:43:09
Class CB.impl Extends %REST.Impl [ ProcedureBlock ]
{

/// If ExposeServerExceptions is true, then details of internal errors will be exposed.
Parameter ExposeServerExceptions = 0;

/// Obtain a list of station numbers and station abbreviations.
ClassMethod GetSites() As %Stream.Object
{
    set tSQL="SELECT Sta3n,Sta3a FROM VX130.VistaSite"
    set tRSet=##class(%SQL.Statement).%ExecDirect(.tStatement,tSQL)
    set tArray=[]
    while tRSet.%Next() {
        set tObj={}
        do tObj.%Set("Sta3n",tRSet.%Get("Sta3n"))
        do tObj.%Set("Sta3a",tRSet.%Get("Sta3a"))
        do tArray.%Push(tObj)
    }
    Do ..%SetStatusCode("200")
    //Do ..%SetHeader(<name>,<value>)
    //do ..%SetContentType("application/json")
    set tObj={}
    do tObj.%Set("Site",tArray)
    Quit tObj
}

/// for a given station number and FileMan file number return information about that file.<br/>
/// The method arguments hold values for:<br/>
///     sta3n<br/>
///     filenumber<br/>
ClassMethod GetSiteFile(sta3n As %String, filenumber As %String) As %Stream.Object
{
    //(Place business logic here)
    //Do ..%SetStatusCode(<HTTP_status_code>)
    //Do ..%SetHeader(<name>,<value>)
    //Quit (Place response here) ; response may be a string, stream or dynamic object
}

/// For a given station number and FileMan file number return information about the fields in that file.<br/>
/// The method arguments hold values for:<br/>
///     sta3n<br/>
///     filenumber<br/>
ClassMethod GetSiteFields(sta3n As %String, filenumber As %String) As %Stream.Object
{
    set tSQL="SELECT ID,VistaFileNumber,VistaFieldNumber,VistaFieldName,VistaFieldType FROM Dim.VistaFieldv001 WHERE Sta3n=? AND VistaFileNumber=?"
    set tRSet=##class(%SQL.Statement).%ExecDirect(.tStatement,tSQL,sta3n,filenumber)
    set tArray=[]
    while tRSet.%Next() {
        set tObj={}
        do tObj.%Set("id",tRSet.%Get("ID"))
        do tObj.%Set("FMFileNumber",tRSet.%Get("VistaFileNumber"))
        do tObj.%Set("FMFieldNumber",tRSet.%Get("VistaFieldNumber"))
        do tObj.%Set("FMFieldName",tRSet.%Get("VistaFieldName"))
        do tObj.%Set("FMFieldType",tRSet.%Get("VistaFieldType"))
        do tArray.%Push(tObj)
    }
    Do ..%SetStatusCode("200")
    //Do ..%SetHeader(<name>,<value>)
    //do ..%SetContentType("application/json")
    set tObj={}
    do tObj.%Set("Field",tArray)
    Quit tObj
}

}
