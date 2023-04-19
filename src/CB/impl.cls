/// Business logic class defined by OpenAPI in CB.spec<br/>
/// Created Apr 17, 2023 21:15:05
Class CB.impl Extends %REST.Impl [ ProcedureBlock ]
{

/// If ExposeServerExceptions is true, then details of internal errors will be exposed.
Parameter ExposeServerExceptions = 0;

/// Obtain a list of station numbers and station abbreviations.
ClassMethod GetSites() As %DynamicObject
{
    //(Place business logic here)
    //Do ..%SetStatusCode(<HTTP_status_code>)
    //Do ..%SetHeader(<name>,<value>)
    //Quit (Place response here) ; response may be a string, stream or dynamic object
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
///     sta3n<b"r/>
///     filenumber<br/>
ClassMethod GetSiteFields(sta3n As %String, filenumber As %String) As %Stream.Object
{
    //(Place business logic here)
    //Do ..%SetStatusCode(<HTTP_status_code>)
    //Do ..%SetHeader(<name>,<value>)
    //Quit (Place response here) ; response may be a string, stream or dynamic object
}

/// For a given IRIS ClassName Get the AttributeMap<br/>
/// The method arguments hold values for:<br/>
///     classname<br/>
ClassMethod GetAMap(classname As %String) As %Stream.Object
{
    Try {
        s ^zmike(classname)=""
        Set tRSet=##class(%ResultSet).%New("CB.AttributeMap:GetClassMap")
        set tSC=tRSet.%Execute(classname)
        Set tAMaps=[]
        While tRSet.%Next() {
            Set tAMap={}
            do tAMap.%Set("IRISPropertyName",tRSet.%Get("IRISPropertyName"))
            Do tAMap.%Set("VistaFieldNumber",tRSet.%Get("VistaFieldNumber"))
            Do tAMap.%Set("VistaFileNumber",tRSet.%Get("VistaFileNumber"))
            Do tAMap.%Set("DataDomain",tRSet.%Get("DataDomain"))
            Do tAMap.%Set("DataType",tRSet.%Get("DataType"))
            Do tAMap.%Set("VistaFieldDescription",tRSet.%Get("VistaFieldDescription"))
            Do tAMaps.%Push(tAMap)
        }
        Do ..%SetStatusCode("200")
        return tAMaps.%ToJSON()
    }
    Catch ex {
        Set tSC=ex.AsStatus()
    }
    //
    //Do ..%SetHeader(<name>,<value>)
    //Quit (Place response here) ; response may be a string, stream or dynamic object
}

}
