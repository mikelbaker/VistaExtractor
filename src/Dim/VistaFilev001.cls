Class Dim.VistaFilev001 Extends %Persistent
{

/// The three digit Station Number.
Property Sta3n As %Integer;

/// Embedded reference to VX130.VistaSite ;
Property VistaSite As VX130.VistaSite;

/// The VISTA file number
Property VistaFileNumber As %String(COLLATION = "EXACT");

/// The VISTA file name
Property VistaFileName As %String(COLLATION = "EXACT", MAXLEN = 250);

/// The description for the VISTA file.
Property VistaFileDescription As %String(MAXLEN = 20000);

/// The parent File of the VISTA sub-file
Property ParentVistaFile As Dim.VistaFilev001;

/// The global root of the VISTA file
Property GlobalRoot As %String(COLLATION = "EXACT");

/// If the record was deleted in VISTA this property
/// will be set to D otherwise this property is NULL.
Property OpCode As %String;

/// The first time this record was updated.
Property VistaCreateDate As %TimeStamp;

/// The last time this record was updated.
Property VistaEditDate As %TimeStamp;

/// Unique index to quickly find the record for the VISTA file.
Index MainIndex On (Sta3n, VistaFileNumber) [ Unique ];

/// Index on VISTA file name to quickly find file for VISTA site.
Index VistaFileNameIndex On (Sta3n, VistaFileName);

/// Loop through the FileMan Data Dictionary for the given site
/// finding all File and Subfile numbers.  Call UpdateObject
/// passing the Sta3n and the VistaFileNumber
ClassMethod BuildSite(pSta3n As %Integer, pStartIEN As %String = 0) As %Status
{
    Set sc = $$$OK
    Try {
        Set tNS=##class(VX130.VistaSite).%OpenId(pSta3n).Sta3a
        Set tVistaFileNumber = $ORDER(^|tNS|DD(pStartIEN))
        While +tVistaFileNumber {
            Set sc = ..UpdateObject(pSta3n,tVistaFileNumber)
            If $$$ISERR(sc) { Do $SYSTEM.OBJ.DisplayError(sc) }
            Set tVistaFileNumber = $ORDER(^|tNS|DD(tVistaFileNumber))
        }
    }
    Catch ex {
        Set sc=ex.AsStatus()
    }
    Return sc
}

/// Description
ClassMethod UpdateObject(pSta3n As %Integer, pFMPK As %String) As %Status
{
    Set sc = $$$OK
    Try {
        Set tVistaSite=##class(VX130.VistaSite).%OpenId(pSta3n)
        Set tNS=tVistaSite.Sta3a

        Set tVistaFileNumber=$PIECE(pFMPK,",",1)
        Return:(+tVistaFileNumber)'>0 sc

        If '$DATA(^|tNS|DD(tVistaFileNumber,0))
        {
            Set sc=..RemoveObject(pSta3n,pFMPK)
            Return sc
        }

        If +tVistaFileNumber {
            &sql(SELECT ID INTO :tId FROM Dim.VistaFilev001 WHERE Sta3n=:pSta3n AND VistaFileNumber=:tVistaFileNumber)
            If '$GET(tId)
            {
                Set oref=..%New()
                Set oref.Sta3n=pSta3n
                Set oref.VistaSite=tVistaSite
                Set oref.VistaFileNumber=tVistaFileNumber
                Set oref.VistaCreateDate=$ZDATETIME($ZTIMESTAMP,3)
                Set oref.OpCode=""
                Set $BIT(tBitFlag,1)=1
            } Else {
                Set oref=..%OpenId(tId,4,.sc)
                If '$$$ISOK(sc) {
                    return sc
                } 
            }
            
            Set $BIT(tBitFlag,2)=oref.setVistaFileName(tNS,tVistaFileNumber)
            If oref.VistaFileName']"" { return sc } // Don't save if no file name.
            Set $BIT(tBitFlag,3)=oref.setVistaFileDescription(tNS,tVistaFileNumber)
            Set $BIT(tBitFlag,4)=oref.setParentVistaFile(tNS,tVistaFileNumber)
            Set $BIT(tBitFlag,5)=oref.setGlobalRoot(tNS,tVistaFileNumber)

            If oref.OpCode]"" {
                Set oref.OpCode=""
                Set $BIT(tBitFlag,6)= 1
            }

            If $BITFIND(tBitFlag,1)>0 {
                If $GET(tLogEdits) {
                    Write ..%ClassName(1)," ",tId," "
                    For i = 1:1:6 {
                        Write $BIT(tBitFlag,i)
                    }
                    Write !
                }
            }
            Set oref.VistaEditDate=$ZDATETIME($ZTIMESTAMP,3)
            Set sc=oref.%Save()
        }
        Kill oref,tBitFlag,tNS,tVistaFileNumber,tVistaSite
    }
    Catch ex {
        Set sc=ex.AsStatus()
    }
    Return sc
}

/// Description
ClassMethod RemoveObject(pSta3n As %Integer, pFMPK As %String) As %Status
{
    Set sc = $$$OK
    Try {
        Set tVistaSite=##class(VX130.VistaSite).%OpenId(pSta3n)
        Set tNS=tVistaSite.Sta3a

        Set tVistaFileNumber=$PIECE(pFMPK,",",1)
        Return:(+tVistaFileNumber)'>0 sc

        If '$DATA(^|tNS|DD(tVistaFileNumber,0))
        {
            &sql(UPDATE %NOLOCK Dim.VistaFilev001 SET OpCode='D',VistaEditDate=GETUTCDATE() WHERE Sta3n=:pSta3n AND VistaFileNumber=:tVistaFileNumber)

            Return sc
        }
        Kill tNS,tVistaFileNumber,tVistaSite
    }
    Catch ex {
        Set tSC=ex.AsStatus()
    }
    Return sc
}

/// Get VistaFileName from the VISTA global.
Method setVistaFileName(pNS As %String, pVistaFileNumber As %String) As %Integer
{
    Set tFlag=0
    Set tVistaFileName=$ORDER(^|pNS|DD(pVistaFileNumber,0,"NM",""))

    If ..VistaFileName'=tVistaFileName
    {
        Set ..VistaFileName=tVistaFileName
        Set tFlag=1
    }
    Return tFlag
}

/// Get VistaFileDescription from the VISTA global.
Method setVistaFileDescription(pNS As %String, pVistaFileNumber As %String) As %Integer
{
    Set tFlag=0
    Set tVistaFileDescription=""
    If $DATA(^|pNS|DIC(pVistaFileNumber,"%D")) {
        // Parent File get Description From ^DIC
        Set tD1=$ORDER(^|pNS|DIC(pVistaFileNumber,"%D",0))
        While +tD1 {
            Set tVistaFileDescription=tVistaFileDescription_
                $GET(^|pNS|DIC(pVistaFileNumber,"%D",tD1,0))_$C(13,10)
            Set tD1=$ORDER(^|pNS|DIC(pVistaFileNumber,"%D",tD1))
        }       
    }

    If tVistaFileDescription="" {
        // Maybe a subfile
        Set tUp=$GET(^|pNS|DD(pVistaFileNumber,0,"UP"))
        If +tUp {
            Set tParentFieldNumber = $ORDER(^|pNS|DD(tUp,"SB",pVistaFileNumber,0))
            If +tParentFieldNumber {
                Set tD1 = $ORDER(^|pNS|DD(tUp,tParentFieldNumber,21,0))
                While +tD1 {
                    Set tVistaFileDescription=tVistaFileDescription_
                        $GET(^|pNS|DD(tUp,tParentFieldNumber,21,tD1,0))_$C(13,10)
                    Set tD1 = $ORDER(^|pNS|DD(tUp,tParentFieldNumber,21,tD1))
                }
            }
        }
    }
    If ..VistaFileDescription'=tVistaFileDescription
    {
        Set ..VistaFileDescription=tVistaFileDescription
        Set tFlag=1
    }
    Return tFlag
}

/// Get ParentVistaFile from the VISTA global.
Method setParentVistaFile(pNS As %String, pVistaFileNumber As %String) As %Integer
{
    Set tFlag=0
    Set tParentVistaFile = $GET(^|pNS|DD(pVistaFileNumber,0,"UP"))
    &sql(SELECT ID INTO :tId FROM Dim.VistaFilev001 WHERE VistaSite->Sta3a=:pNS AND VistaFileNumber=:tParentVistaFile)
    Set tParentVistaFile=""
    If $GET(tId) {
        Set tParentVistaFile=..%OpenId(tId)
    }
    If ..ParentVistaFile'=tParentVistaFile
    {
        Set ..ParentVistaFile=tParentVistaFile
        Set tFlag=1
    }
    Return tFlag
}

/// Get GlobalRoot from the VISTA global.
Method setGlobalRoot(pNS As %String, pVistaFileNumber As %String) As %Integer
{
    Set tFlag=0
    Set tVFN = pVistaFileNumber
    Set tUp = $GET(^|pNS|DD(tVFN,0,"UP"))

    While +tUp {
        Set tVFN=tUp
        Set tUp = $GET(^|pNS|DD(tVFN,0,"UP"))
    }
    Set tGlobalRoot = $GET(^|pNS|DIC(tVFN,0,"GL"))
    If ..GlobalRoot'=tGlobalRoot
    {
        Set ..GlobalRoot=tGlobalRoot
        Set tFlag=1
    }
    Return tFlag
}

Storage Default
{
<Data name="VistaFilev001DefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Sta3n</Value>
</Value>
<Value name="3">
<Value>VistaSite</Value>
</Value>
<Value name="4">
<Value>VistaFileNumber</Value>
</Value>
<Value name="5">
<Value>VistaFileName</Value>
</Value>
<Value name="6">
<Value>VistaFileDescription</Value>
</Value>
<Value name="7">
<Value>ParentVistaFile</Value>
</Value>
<Value name="8">
<Value>GlobalRoot</Value>
</Value>
<Value name="9">
<Value>OpCode</Value>
</Value>
<Value name="10">
<Value>VistaCreateDate</Value>
</Value>
<Value name="11">
<Value>VistaEditDate</Value>
</Value>
</Data>
<DataLocation>^Dim.VistaFilev001D</DataLocation>
<DefaultData>VistaFilev001DefaultData</DefaultData>
<IdLocation>^Dim.VistaFilev001D</IdLocation>
<IndexLocation>^Dim.VistaFilev001I</IndexLocation>
<StreamLocation>^Dim.VistaFilev001S</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
