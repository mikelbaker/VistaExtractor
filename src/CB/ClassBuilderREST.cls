Class CB.ClassBuilderREST Extends %CSP.REST
{

/// Description
Parameter HandleCorsRequest = 1;

/// Description
XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
<Route Url="/sites" Method="GET" Call="GetSites" />
<Route Url="/file/:sta3n/:filenumber" Method="GET" Call="GetSiteFile" />
<Route Url="/fields/:sta3n/:filenumber" Method="GET" Call="GetSiteFields" />
</Routes>
}

/// Description
ClassMethod GetSites() As %Status
{
    Set tsc = $$$OK
    Try {
        set tSiteList=##class(VX130.VistaSite).GetSiteList()
        do tSiteList.%ToJSON()
    }
    Catch ex {
        Set tsc=ex.AsStatus()
    }
    Return tsc
}

ClassMethod GetSiteFile(pSta3n As %Integer, pVistaFileNumber As %String) As %Status
{
    Set tsc = $$$OK
    Try {
        set tFile=##class(Dim.VistaFilev001).GetFileInfo(pSta3n,pVistaFileNumber)
        do tFile.%ToJSON()
    }
    Catch ex {
        Set tsc=ex.AsStatus()
    }
    Return tsc
}

ClassMethod GetSiteFields(pSta3n As %Integer, pVistaFileNumber As %String) As %Status
{
    Set tsc = $$$OK
    Try {
        set tFile=##class(Dim.VistaFieldv001).GetSiteFieldList(pSta3n,pVistaFileNumber)
        do tFile.%ToJSON()
    }
    Catch ex {
        Set tsc=ex.AsStatus()
    }
    Return tsc
}

}
