/// Information about a VISTA site that is used by VX130.
Class VX130.VistaSite Extends (%Persistent, %JSON.Adaptor)
{

/// THe unique station number of a VISTA system
Property Sta3n As %Integer [ Required ];

/// The the character abbreviation for the VISTA system
Property Sta3a As %String [ Required ];

/// The Site Name for this VISTA system.
Property SiteName As %String;

/// The Site belongs to this VISN.
Property VISN As %Integer;

/// The IRISINstance that mirrors this VISTA site'd databases.
Property IRISInstance As VX130.IRISInstance(%JSONINCLUDE = "INPUTONLY");

Index MainIndex On Sta3n [ IdKey, PrimaryKey, Unique ];

Index Sta3aIndex On Sta3a;

/// Add some initial records to the VX130.VistaSite table.
ClassMethod Init() As %Status
{
    Set sc = $$$OK
    Try {
        d ..%KillExtent()
        &sql(INSERT INTO VX130.VX130.VistaSite(Sta3n,Sta3a,SiteName,VISN,IRISINstance) VALUES(516,'BAY','Bay Pines VAMC',8,8))
        &sql(INSERT INTO VX130.VX130.VistaSite(Sta3n,Sta3a,SiteName,VISN,IRISINstance) VALUES(673,'TAM','Tampa VAMC',8,8))
        &sql(INSERT INTO VX130.VX130.VistaSite(Sta3n,Sta3a,SiteName,VISN,IRISINstance) VALUES(548,'WPB','West Palm Beach VAMC',8,8))
    }
    Catch ex {
        Set tSC=ex.AsStatus()
    }
    Return sc
}

/// Given a three character abbreviation for the VISTA site return
/// the unique station number.
ClassMethod GetSta3n(pSta3a As %String) As %String
{
    &sql(SELECT Sta3n INTO :tSta3n FROM VX130.VistaSite where Sta3a=:pSta3a)
    return $GET(tSta3n)
}

/// Description
ClassMethod GetSiteList(ByRef tsc As %Status) As %DynamicArray
{
    Set tsc = $$$OK
    Try {
        set tSQL="SELECT Sta3n FROM VX130.VistaSite"
        set tRSet=##class(%SQL.Statement).%ExecDirect(.tStatement,tSQL)
        set tSiteArray=##class(%DynamicArray).%New()
        while tRSet.%Next() {
            do ..%OpenId(tRSet.%Get("Sta3n")).%JSONExportToString(.tSite)
            do tSiteArray.%Push(tSite)
        }
    }
    Catch ex {
        Set tSC=ex.AsStatus()
    }
    Return tSiteArray
}

/// Description
Storage Default
{
<Data name="VistaSiteDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Sta3a</Value>
</Value>
<Value name="3">
<Value>SiteName</Value>
</Value>
<Value name="4">
<Value>VISN</Value>
</Value>
<Value name="5">
<Value>IRISInstance</Value>
</Value>
</Data>
<DataLocation>^VX130.VistaSiteD</DataLocation>
<DefaultData>VistaSiteDefaultData</DefaultData>
<Description>
<![CDATA[Description]]></Description>
<IdLocation>^VX130.VistaSiteD</IdLocation>
<IndexLocation>^VX130.VistaSiteI</IndexLocation>
<StreamLocation>^VX130.VistaSiteS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
