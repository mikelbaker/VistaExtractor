Class Dim.VistaFieldv001 Extends %Persistent
{

/// The three digit Station Number.
Property Sta3n As %Integer;

/// Embedded reference to vxVX130130.VistaSite ;
Property VistaSite As VX130.VistaSite;

/// The VISTA file number
Property VistaFileNumber As %String(COLLATION = "EXACT");

/// Embedded reference to Dim.VistaFilev001
Property VistaFile As Dim.VistaFilev001;

/// The VISTA field number
Property VistaFieldNumber As %String;

/// The VISTA field Name
Property VistaFieldName As %String;

/// The VISTA field Type
Property VistaFieldType As %String;

/// If the VISTA field type is FreeText this is the MAXLEN
Property VistaFieldLength As %String;

/// If the VISTA field type is SetOfCodes this is the code string
Property VistaFieldCodes As %String(MAXLEN = 2000);

/// If the VISTA field type is Numeric this is the length and scale.
Property VistaFieldNumericScale As %String;

/// If the VISTA field type is SubFile this is the sub-file number.
Property VistaMultipleFileNumber As %String;

/// Embeded reference to VistaFile if the VISTA field type is SubFile.
Property VistaMultipleFile As Dim.VistaFilev001;

/// If the VISTA field type is Pointer this is the Pointed to Vista file number.
Property VistaPointedToFileNumber As %String;

/// Embeded reference to VistaFile if the VISTA field type is Pointer.
Property PointerToVistaFile As Dim.VistaFilev001;

/// The Vista Field Description.
Property VistaFieldDescription As %String(MAXLEN = 20000);

/// The global node that contains data for this field
Property GlobalNode As %String(MAXLEN = 2000);

/// The '^' delimited piece of the global node for this VistaField
Property Piece As %String;

/// If the record was deleted in VISTA this property
/// will be set to D otherwise this property is NULL.
Property OpCode As %String;

/// The first time this record was updated.
Property VistaCreateDate As %TimeStamp;

/// The last time this record was updated.
Property VistaEditDate As %TimeStamp;

/// Unique index to quickly find the record for the VISTA file.
Index MainIndex On (Sta3n, VistaFileNumber, VistaFieldNumber) [ Unique ];

/// Loop through the FileMan Data Dictionary for the given site
/// finding all File and Subfile numbers.  Then loop through all 
/// Field numbers for the file and call UpdateObject
/// passing the Sta3n and the VistaFileNumber,VistaFieldNumber
ClassMethod BuildSite(pSta3n As %Integer, pStartIEN As %String = 0) As %Status
{
    Set sc = $$$OK
    Try {
        Set tNS=##class(VX130.VistaSite).%OpenId(pSta3n).Sta3a
        Set tVistaFileNumber = $ORDER(^|tNS|DD(pStartIEN))
        While +tVistaFileNumber {
            Set tVistaFieldNumber = $ORDER(^|tNS|DD(tVistaFileNumber,0))
            While +tVistaFieldNumber {
                Set sc = ..UpdateObject(pSta3n,tVistaFileNumber_","_tVistaFieldNumber)
                If $$$ISERR(sc) { Do $SYSTEM.OBJ.DisplayError(sc) }
                Set tVistaFieldNumber = $ORDER(^|tNS|DD(tVistaFileNumber,tVistaFieldNumber))
            }
            Set tVistaFileNumber = $ORDER(^|tNS|DD(tVistaFileNumber))
        }
    }
    Catch ex {
        Set sc=ex.AsStatus()
    }
    Return sc
}

/// Using given VistaFileNumber and VistaFieldNumber,  obtain
/// data about the field from the VISTA data dictionary.
ClassMethod UpdateObject(pSta3n As %Integer, pFMPK As %String) As %Status
{
    Set sc = $$$OK
    Try {
        Set tVistaSite=##class(VX130.VistaSite).%OpenId(pSta3n)
        Set tNS=tVistaSite.Sta3a

        Set tVistaFileNumber=$PIECE(pFMPK,",",1)
        Return:(+tVistaFileNumber)'>0 sc

        Set tVistaFieldNumber=$PIECE(pFMPK,",",2)
        Return:(+tVistaFieldNumber)'>0 sc

        If '$DATA(^|tNS|DD(tVistaFileNumber,tVistaFieldNumber,0))
        {
            Set sc=..RemoveObject(pSta3n,pFMPK)
            Return sc
        }

        If +tVistaFileNumber {
            &sql(SELECT ID INTO :tId FROM Dim.VistaFieldv001 
                    WHERE Sta3n=:pSta3n 
                    AND VistaFileNumber=:tVistaFileNumber 
                    AND VistaFieldNumber=:tVistaFieldNumber)
            If '$GET(tId)
            {
                Set oref=..%New()
                Set oref.Sta3n=pSta3n
                Set oref.VistaSite=tVistaSite
                Set oref.VistaFileNumber=tVistaFileNumber
                Set oref.VistaFieldNumber=tVistaFieldNumber
                Set oref.VistaCreateDate=$ZDATETIME($ZTIMESTAMP,3)
                Set oref.OpCode=""
                Set $BIT(tBitFlag,1)=1
            } Else {
                Set oref=..%OpenId(tId,4,.sc)
                If '$$$ISOK(sc) {
                    return sc
                } 
            }
            
            Set $BIT(tBitFlag,2)=oref.setVistaFieldName(tNS,tVistaFileNumber,tVistaFieldNumber)
            If oref.VistaFieldName']"" { return sc } // Don't save if no field name.
            Set $BIT(tBitFlag,3)=oref.setVistaFieldDescription(tNS,tVistaFileNumber,tVistaFieldNumber)
            Set $BIT(tBitFlag,4)=oref.setVistaFile(tNS,tVistaFileNumber,tVistaFieldNumber)
            Set $BIT(tBitFlag,5)=oref.setVistaFieldType(tNS,tVistaFileNumber,tVistaFieldNumber)
            Set $BIT(tBitFlag,6)=oref.setGlobalNode(tNS,tVistaFileNumber,tVistaFieldNumber)
            Set $BIT(tBitFlag,7)=oref.setPiece(tNS,tVistaFileNumber,tVistaFieldNumber)
            Set $BIT(tBitFlag,8)=oref.setVistaFieldLength(tNS,tVistaFileNumber,tVistaFieldNumber)
            Set $BIT(tBitFlag,9)=oref.setVistaFieldCodes(tNS,tVistaFileNumber,tVistaFieldNumber)
            Set $BIT(tBitFlag,10)=oref.setVistaMultipleFileNumber(tNS,tVistaFileNumber,tVistaFieldNumber)
            Set $BIT(tBitFlag,11)=oref.setVistaPointedToFileNumber(tNS,tVistaFileNumber,tVistaFieldNumber)
            Set $BIT(tBitFlag,12)=oref.setVistaFieldNumericScale(tNS,tVistaFileNumber,tVistaFieldNumber)

            If oref.OpCode]"" {
                Set oref.OpCode=""
                Set $BIT(tBitFlag,13)= 1
            }

            If $BITFIND(tBitFlag,1)>0 {
                If $GET(tLogEdits) {
                    Write ..%ClassName(1)," ",tId," "
                    For i = 1:1:13 {
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

/// Get VistaFieldName( from the VISTA global.
Method setVistaFieldName(pNS As %String, pVistaFileNumber As %String, pVistaFieldNumber As %String) As %Integer
{
    Set tFlag=0
    Set tVistaFieldName=$PIECE(^|pNS|DD(pVistaFileNumber,pVistaFieldNumber,0),"^",1)

    If ..VistaFieldName'=tVistaFieldName
    {
        Set ..VistaFieldName=tVistaFieldName
        Set tFlag=1
    }
    Return tFlag
}

/// Get VistaFileDescription from the VISTA global.
Method setVistaFieldDescription(pNS As %String, pVistaFileNumber As %String, pVistaFieldNumber As %String) As %Integer
{
    Set tFlag=0
    Set tVistaFieldDescription=""
    If $DATA(^|pNS|DD(pVistaFileNumber,pVistaFieldNumber,21)) {
        // Parent File get Description From ^DIC
        Set tD1=$ORDER(^|pNS|DD(pVistaFileNumber,pVistaFieldNumber,21,0))
        While +tD1 {
            Set tVistaFieldDescription=tVistaFieldDescription_
                $GET(^|pNS|DD(pVistaFileNumber,pVistaFieldNumber,21,tD1,0))_$C(13,10)
            Set tD1=$ORDER(^|pNS|DD(pVistaFileNumber,pVistaFieldNumber,21,tD1))
        }       
    }

    If ..VistaFieldDescription'=tVistaFieldDescription
    {
        Set ..VistaFieldDescription=tVistaFieldDescription
        Set tFlag=1
    }
    Return tFlag
}

/// Get VistaFile from the Dim.VistaFilev001 table.
Method setVistaFile(pNS As %String, pVistaFileNumber As %String, pVistaFieldNumber As %String) As %Integer
{
    Set tFlag=0
    &sql(SELECT ID INTO :tId FROM Dim.VistaFilev001 WHERE VistaSite->Sta3a=:pNS AND VistaFileNumber=:pVistaFileNumber)
    Set tVistaFile=""
    If $GET(tId) {
        Set tVistaFile=..%OpenId(tId)
    }
    If ..VistaFile'=tVistaFile
    {
        Set ..VistaFile=tVistaFile
        Set tFlag=1
    }
    Return tFlag
}

/// Get VistaFieldType from the VISTA global.
Method setVistaFieldType(pNS As %String, pVistaFileNumber As %String, pVistaFieldNumber As %String) As %Integer
{
    Set tFlag=0
    Set tType = $PIECE($GET(^|pNS|DD(pVistaFileNumber,pVistaFieldNumber,0)),"^",2)
    If tType?.E1N.E {}
    Set tVistaFieldType=$SELECT(tType["C":"Computed",
        tType["V":"VariablePointer",tType["P":"Pointer",tType["N":"Numeric",
        tType["D":"Date",tType["W":"WordProcessing",tType["S":"SetOfCodes",
        tType["K":"MCode",1:"FreeText")

    If ..VistaFieldType'=tVistaFieldType
    {
        Set ..VistaFieldType=tVistaFieldType
        Set tFlag=1
    }
    Return tFlag
}

/// Get VistaFieldType from the VISTA global.
Method setGlobalNode(pNS As %String, pVistaFileNumber As %String, pVistaFieldNumber As %String) As %Integer
{
    Set tFlag=0
    Set tFiles=pVistaFileNumber
    set tFileNum=pVistaFileNumber
    Set tUp=$GET(^|pNS|DD(pVistaFileNumber,0,"UP"))
    While +tUp {
        Set tMultipleFieldNumber=$ORDER(^|pNS|DD(tUp,"SB",tFileNum,0))
        Set tFiles=tUp_":"_tMultipleFieldNumber_","_tFiles
        Set tFileNum=tUp
        Set tUp=$GET(^|pNS|DD(tUp,0,"UP"))
    }
    Set tGlobalNode=$GET(^|pNS|DIC(tFileNum,0,"GL"))_"D0"
    For i=1:1 {
        Quit:$PIECE(tFiles,",",i)=""
        Set tFileNum = $PIECE($PIECE(tFiles,",",i),":",1)
        Set tMultipleFieldNumber=$PIECE($PIECE(tFiles,",",i),":",2)
        If tMultipleFieldNumber]"" {
            Set tConstant = $PIECE($PIECE(^|pNS|DD(tFileNum,tMultipleFieldNumber,0),"^",4),";",1)
            If +tConstant'=tConstant {
                Set tGlobalNode=tGlobalNode_","""_tConstant_""",D"_i
            } Else {
                Set tGlobalNode=tGlobalNode_","_tConstant_",D"_i
            }
        }       
    }
    If pVistaFieldNumber=".001" {
        Set tGlobalNode=tGlobalNode_")"
    } Else {
        Set tFieldNode=$PIECE($PIECE($GET(^|pNS|DD(pVistaFileNumber,pVistaFieldNumber,0)),"^",4),";",1)
        If +tFieldNode'=tFieldNode {
            Set tGlobalNode=tGlobalNode_","""_tFieldNode_""")"
        } Else {
            Set tGlobalNode=tGlobalNode_","_tFieldNode_")"
        }
    }
    If tGlobalNode'["^" { Set tGlobalNode = "" }
    If ..GlobalNode'=tGlobalNode
    {
        Set ..GlobalNode=tGlobalNode
        Set tFlag=1
    }
    Return tFlag
}

/// Get GlobalNode Piece from the VISTA global.
Method setPiece(pNS As %String, pVistaFileNumber As %String, pVistaFieldNumber As %String) As %Integer
{
    Set tFlag=0
    Set tPiece=$PIECE($PIECE($GET(^|pNS|DD(pVistaFileNumber,pVistaFieldNumber,0)),"^",4),";",2)
    If $EXTRACT(tPiece,1)="E" {
        Set tPiece=1
    } ElseIf +tPiece'=tPiece {
        Set tPiece=""
    }

    If ..Piece'=tPiece
    {
        Set ..Piece=tPiece
        Set tFlag=1
    }
    Return tFlag
}

/// Get maximum VistaFieldLength from the VISTA global.
Method setVistaFieldLength(pNS As %String, pVistaFileNumber As %String, pVistaFieldNumber As %String) As %Integer
{
    Set tFlag=0
    Set tVistaFieldLength=$PIECE($GET(^|pNS|DD(pVistaFileNumber,pVistaFieldNumber,0)),"^",5)
    Set tVistaFieldLength=$PIECE($PIECE(tVistaFieldLength,"K:$L(X)>",2),"!",1)
    If +tVistaFieldLength'=tVistaFieldLength {
        Set tVistaFieldLength=""
    }
    If ..VistaFieldLength'=tVistaFieldLength
    {
        Set ..VistaFieldLength=tVistaFieldLength
        Set tFlag=1
    }
    Return tFlag
}

/// Get set of codes values from the VISTA global.
Method setVistaFieldCodes(pNS As %String, pVistaFileNumber As %String, pVistaFieldNumber As %String) As %Integer
{
    Set tFlag=0
    Set tVistaFieldCodes=$PIECE($GET(^|pNS|DD(pVistaFileNumber,pVistaFieldNumber,0)),"^",3)

    If ..VistaFieldCodes'=tVistaFieldCodes
    {
        Set ..VistaFieldCodes=tVistaFieldCodes
        Set tFlag=1
    }
    Return tFlag
}

/// Get VistaPointedToFileNumber from the VISTA global.
Method setVistaPointedToFileNumber(pNS As %String, pVistaFileNumber As %String, pVistaFieldNumber As %String) As %Integer
{
    Set tFlag=0
    Set tPointerToVistaFile=""
    If ..VistaFieldType="Pointer"
    {
        Set tVistaPointedToFileNumber=$ZSTRIP($PIECE($GET(^|pNS|DD(pVistaFileNumber,pVistaFieldNumber,0)),"^",2),"*E'N",,".")
        &sql(SELECT Sta3n INTO :tSta3n FROM vx130.VistaSite WHERE Sta3a=:pNS)
        If +tVistaPointedToFileNumber,+tSta3n {
            &sql(SELECT ID INTO :tPointerToVistaFile FROM Dim.VistaFilev001 WHERE Sta3n=:tSta3n AND VistaFileNumber=:tVistaPointedToFileNumber)
        }
    } Else {
        Set tVistaPointedToFileNumber=""
    }
    
    If ..VistaPointedToFileNumber'=tVistaPointedToFileNumber
    {
        Set ..PointerToVistaFile=##class(Dim.VistaFilev001).%OpenId(tPointerToVistaFile)
        Set ..VistaPointedToFileNumber=tVistaPointedToFileNumber
        Set tFlag=1
    }
    Return tFlag
}

/// Get VistaMultipleFileNumber from the VISTA global.
Method setVistaMultipleFileNumber(pNS As %String, pVistaFileNumber As %String, pVistaFieldNumber As %String) As %Integer
{
    Set tFlag=0
    Set tNode=$PIECE($GET(^|pNS|DD(pVistaFileNumber,pVistaFieldNumber,0)),"^",4)
    Set tVistaMultipleFileNumber=""
    If $PIECE(tNode,";",2)=0
    {
        Set tVistaMultipleFileNumber=$ZSTRIP($PIECE($GET(^|pNS|DD(pVistaFileNumber,pVistaFieldNumber,0)),"^",2),"*E'N",,".")
        &sql(SELECT Sta3n INTO :tSta3n FROM vx130.VistaSite WHERE Sta3a=:pNS)
        If +tVistaMultipleFileNumber,+tSta3n {
            &sql(SELECT ID INTO :tVistaMultipleFile FROM Dim.VistaFilev001 WHERE Sta3n=:tSta3n AND VistaFileNumber=:tVistaMultipleFileNumber)
        }
    } Else {
        Set tVistaMultipleFileNumber=""
    }
    
    If ..VistaMultipleFileNumber'=tVistaMultipleFileNumber
    {
        Set ..VistaFieldType="SubFile"
        Set ..VistaMultipleFile=##class(Dim.VistaFilev001).%OpenId(tVistaMultipleFile)
        Set ..VistaMultipleFileNumber=tVistaMultipleFileNumber
        Set tFlag=1
    }
    Return tFlag
}

Method setVistaFieldNumericScale(pNS As %String, pVistaFileNumber As %String, pVistaFieldNumber As %String) As %Integer
{
    Set tFlag=0
    If ..VistaFieldType="Numeric"
    {
        Set tVistaFieldNumericScale=$PIECE($PIECE($GET(^|pNS|DD(pVistaFileNumber,pVistaFieldNumber,0)),"^",2),"J",2)
        Set tDecimal=$PIECE(tVistaFieldNumericScale,",",2)
        Set tVistaFieldNumericScale=tVistaFieldNumericScale+tDecimal_","_+tDecimal

        If ..VistaFieldNumericScale'=tVistaFieldNumericScale
        {
            Set ..VistaFieldNumericScale=tVistaFieldNumericScale
            Set tFlag=1
        }
    }
    Return tFlag
}

Storage Default
{
<Data name="VistaFieldv001DefaultData">
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
<Value>VistaFile</Value>
</Value>
<Value name="6">
<Value>VistaFieldNumber</Value>
</Value>
<Value name="7">
<Value>VistaFieldName</Value>
</Value>
<Value name="8">
<Value>VistaFieldType</Value>
</Value>
<Value name="9">
<Value>VistaFieldLength</Value>
</Value>
<Value name="10">
<Value>VistaFieldCodes</Value>
</Value>
<Value name="11">
<Value>VistaFieldNumericScale</Value>
</Value>
<Value name="12">
<Value>VistaMultipleFileNumber</Value>
</Value>
<Value name="13">
<Value>VistaMultipleFile</Value>
</Value>
<Value name="14">
<Value>VistaPointedToFileNumber</Value>
</Value>
<Value name="15">
<Value>PointerToVistaFile</Value>
</Value>
<Value name="16">
<Value>VistaFieldDescription</Value>
</Value>
<Value name="17">
<Value>GlobalNode</Value>
</Value>
<Value name="18">
<Value>Piece</Value>
</Value>
<Value name="19">
<Value>OpCode</Value>
</Value>
<Value name="20">
<Value>VistaCreateDate</Value>
</Value>
<Value name="21">
<Value>VistaEditDate</Value>
</Value>
</Data>
<DataLocation>^Dim.VistaFieldv001D</DataLocation>
<DefaultData>VistaFieldv001DefaultData</DefaultData>
<IdLocation>^Dim.VistaFieldv001D</IdLocation>
<IndexLocation>^Dim.VistaFieldv001I</IndexLocation>
<StreamLocation>^Dim.VistaFieldv001S</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
