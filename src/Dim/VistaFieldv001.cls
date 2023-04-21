Class Dim.VistaFieldv001 Extends (%Persistent, %JSON.Adaptor)
{

/// The three digit Station Number.
Property Sta3n As %Integer;

/// Embedded reference to vxVX130130.VistaSite ;
Property VistaSite As VX130.VistaSite(%JSONINCLUDE = "INPUTONLY");

/// The VISTA file number
Property VistaFileNumber As %String(COLLATION = "EXACT");

/// Embedded reference to Dim.VistaFilev001
Property VistaFile As Dim.VistaFilev001(%JSONINCLUDE = "INPUTONLY");

/// The VISTA field number
Property VistaFieldNumber As %String;

/// The VISTA field Name
Property VistaFieldName As %String;

/// The VISTA field Type
Property VistaFieldType As %String;

/// If the VISTA field type is FreeText this is the MAXLEN
Property VistaFieldLength As %String(%JSONINCLUDE = "INPUTONLY");

/// If the VISTA field type is SetOfCodes this is the code string
Property VistaFieldCodes As %String(%JSONINCLUDE = "INPUTONLY", MAXLEN = 2000);

/// If the VISTA field type is Numeric this is the length and scale.
Property VistaFieldNumericScale As %String(%JSONINCLUDE = "INPUTONLY");

/// If the VISTA field type is SubFile this is the sub-file number.
Property VistaMultipleFileNumber As %String;

/// Embeded reference to VistaFile if the VISTA field type is SubFile.
Property VistaMultipleFile As Dim.VistaFilev001(%JSONINCLUDE = "INPUTONLY");

/// If the VISTA field type is Pointer this is the Pointed to Vista file number.
Property VistaPointedToFileNumber As %String;

/// Embeded reference to VistaFile if the VISTA field type is Pointer.
Property PointerToVistaFile As Dim.VistaFilev001(%JSONINCLUDE = "INPUTONLY");

/// The Vista Field Description.
Property VistaFieldDescription As %String(%JSONINCLUDE = "INPUTONLY", MAXLEN = 20000);

/// The global node that contains data for this field
Property GlobalNode As %String(MAXLEN = 2000);

/// The '^' delimited piece of the global node for this VistaField
Property Piece As %String;

/// If the record was deleted in VISTA this property
/// will be set to D otherwise this property is NULL.
Property OpCode As %String(%JSONINCLUDE = "INPUTONLY");

/// The first time this record was updated.
Property VistaCreateDate As %TimeStamp(%JSONINCLUDE = "INPUTONLY");

/// The last time this record was updated.
Property VistaEditDate As %TimeStamp(%JSONINCLUDE = "INPUTONLY");

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

ClassMethod GetSiteFieldList(pSta3n As %Integer, pVistaFileNumber As %String, ByRef tsc As %Status) As %DynamicArray
{
    Set tsc = $$$OK
    Try {
        set tSQL="SELECT ID FROM Dim.VistaFieldv001 WHERE Sta3n=? AND VistaFileNumber=? AND OpCode IS NULL"
        set tRSet=##class(%SQL.Statement).%ExecDirect(.tStatement,tSQL,pSta3n,pVistaFileNumber)
        set tFieldArray=##class(%DynamicArray).%New()
        while tRSet.%Next() {
            do ..%OpenId(tRSet.%Get("ID")).%JSONExportToString(.tField)
            do tFieldArray.%Push(tField)
        }
    }
    Catch ex {
        Set tSC=ex.AsStatus()
    }
    Return tFieldArray
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
<ExtentSize>200954</ExtentSize>
<IdLocation>^Dim.VistaFieldv001D</IdLocation>
<IndexLocation>^Dim.VistaFieldv001I</IndexLocation>
<Property name="%%CLASSNAME">
<AverageFieldSize>2</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,0,16,$lb("-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000"),$lb(21,21,21,21,21,21,21,21,21,21,21,21,21,21,21),$lb(758198320,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,758198320))</Histogram>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="%%ID">
<AverageFieldSize>4.69</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,1,0,$lb(519,8905,31054,47554,59418,70629,81215,97992,107921,121693,138325,155976,164255,173641,185167,193856),$lb(0,0,0,0,0,0,0,0,1,1,1,1,1,1,1),$lb(892418304,892418304,943271989,943271989,858861621,858861621,876033333,876033333,892941361,892941361,925906482,925906482,942748209,942748209,959920441,959920441,825243449,808925490,842085945,842085945,859321138,859321138,892680503,892680503,909390389,909390389,926103092,926103092,943010102,943010102,959658037,825832248))</Histogram>
<Selectivity>1</Selectivity>
</Property>
<Property name="GlobalNode">
<AverageFieldSize>21.51</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,0,0,$lb(" ^%ZTER(3.077,D0,1,D1,3)"," ^DGCPT(46,D0,0)"," ^DIC(49,D0,730)"," ^ENG(6910.2,D0,1,D1,0)"," ^GMR(123.6,D0,0)"," ^IBE(357.6,D0,2)"," ^LAB(62.4,D0,9)"," ^MAG(2005,D0,6)"," ^MCAR(700,D0,5)"," ^ONCO(165.5,D0,2.2)"," ^PRC(442,D0,11,D1,0)"," ^PRPF(470,D0,1)"," ^PS(52.48,D0,11,D1,0)"," ^PSDRUG(D0,950,D1,0)"," ^RORDATA(799.6,D0,4,D1,0)"," ^YTT(601.3,D0,0)"),$lb(2,3,2,2,2,2,2,3,2,2,4,3,4,2,2),$lb(543040858,626676805,1145520976,1195593812,1229137972,1145652008,1162757928,1162757928,1196249640,1196249640,1229079848,1229079848,1279345192,1279345192,1296123688,1095182386,1128354344,1296253266,1330529103,1330529103,1347568424,1126708276,1346775092,1380992552,1395143986,674574894,1146246471,1347634258,1380930116,1380930116,1498698792,543054164))</Histogram>
<OutlierSelectivity>.010409:"^KMPD(8973.1,D0,6.9)"</OutlierSelectivity>
<Selectivity>0.0650%</Selectivity>
</Property>
<Property name="OpCode">
<AverageFieldSize>2</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,0,0,$lb(" "," "," "," "," "," "," "," "," "," "," "," "," "," "," "," "),$lb(2,2,2,2,2,2,2,2,2,2,2,2,2,2,2),$lb(536870912,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,536870912))</Histogram>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="Piece">
<AverageFieldSize>3.2</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,0,0,$lb(" "," 0"," 1"," 1"," 1"," 11"," 14"," 2"," 2"," 24"," 3"," 4"," 5"," 6"," 79"," 9"),$lb(1,1,3,3,2,2,1,3,2,1,1,1,1,1,1),$lb(536870912,0,805306368,805306368,822083584,0,0,0,0,0,822083584,822083584,872415232,825491456,838860800,0,0,0,872415232,842268672,855638016,855638016,872415232,872415232,889192448,889192448,905969664,905969664,926482432,926482432,956301312,540606464))</Histogram>
<OutlierSelectivity>.213383:1</OutlierSelectivity>
<Selectivity>0.9323%</Selectivity>
</Property>
<Property name="PointerToVistaFile">
<AverageFieldSize>2.66</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,1,13,$lb(-10000000000000000000,-10000000000000000000,-10000000000000000000,-10000000000000000000,-10000000000000000000,-10000000000000000000,-10000000000000000000,-10000000000000000000,-10000000000000000000,-10000000000000000000,-10000000000000000000,-10000000000000000000,-10000000000000000000,1703,11402,23648),$lb(21,21,21,21,21,21,21,21,21,21,21,21,0,1,0),$lb(758198320,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,758198320,825700403,925905664,825503794,825308208,842217012,842217012))</Histogram>
<OutlierSelectivity>.852788:</OutlierSelectivity>
<Selectivity>0.0167%</Selectivity>
</Property>
<Property name="Sta3n">
<AverageFieldSize>4</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,1,0,$lb(516,516,516,516,516,548,548,548,548,548,673,673,673,673,673,673),$lb(3,3,3,3,1,3,3,3,3,0,3,3,3,3,3),$lb(892417536,0,0,0,0,0,0,0,0,825622528,876085248,0,0,0,0,0,0,0,0,892614656,909587200,0,0,0,0,0,0,0,0,0,0,909587200))</Histogram>
<Selectivity>33.3333%</Selectivity>
</Property>
<Property name="VistaCreateDate">
<AverageFieldSize>21</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,0,0,$lb("2023-03-15 19:03:14","2023-03-15 19:03:34","2023-03-15 19:04:25","2023-03-15 19:05:03","2023-03-15 19:05:31","2023-03-15 19:06:50","2023-03-15 19:07:14","2023-03-15 19:07:52","2023-03-15 19:08:15","2023-03-15 19:08:47","2023-03-15 19:17:59","2023-03-15 19:18:41","2023-03-15 19:19:00","2023-03-15 19:19:21","2023-03-15 19:19:48","2023-03-15 19:20:07"),$lb(17,15,15,17,15,15,17,15,17,14,15,15,17,17,14),$lb(842019379,825491456,859045888,859452212,876229173,876229173,893005875,808648704,858849280,893006641,909784368,909784368,926560564,825491456,892469248,926561586,943337781,825556992,876019712,808991284,825702965,926561593,943338545,943338545,960114736,808452096,842072064,842072064,876085248,825834036,842021424,842019379))</Histogram>
<Selectivity>0.7315%</Selectivity>
</Property>
<Property name="VistaEditDate">
<AverageFieldSize>21</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,0,0,$lb("2023-03-15 19:03:14","2023-03-15 19:03:34","2023-03-15 19:04:25","2023-03-15 19:05:03","2023-03-15 19:05:31","2023-03-15 19:06:50","2023-03-15 19:07:14","2023-03-15 19:07:52","2023-03-15 19:08:15","2023-03-15 19:08:47","2023-03-15 19:17:59","2023-03-15 19:18:41","2023-03-15 19:19:00","2023-03-15 19:19:21","2023-03-15 19:19:48","2023-03-15 19:20:07"),$lb(17,15,15,17,15,15,17,15,17,14,15,15,17,17,14),$lb(842019379,825491456,859045888,859452212,876229173,876229173,893005875,808648704,858849280,893006641,909784368,909784368,926560564,825491456,892469248,926561586,943337781,825556992,876019712,808991284,825702965,926561593,943338545,943338545,960114736,808452096,842072064,842072064,876085248,825834036,842021424,842019379))</Histogram>
<Selectivity>0.7315%</Selectivity>
</Property>
<Property name="VistaFieldCodes">
<AverageFieldSize>10.06</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,0,0,$lb(" "," "," "," "," "," "," "," "," "," "," "," 0:REGULAR;1:BOLD;2:ITALIC;3:BOLD ITALIC;"," C:COMMERCIAL;I:INDIVIDUAL;F:FEDERAL;"," LAB(64.061,"," S:SET;P:POINTER;V:VARIABLE POINTER;"," Y:YES;N:NO;U:UNKNOWN;"),$lb(2,2,2,2,2,2,2,2,2,2,1,1,1,1,1),$lb(536870912,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,809128517,809128517,1127891791,1127891791,1279345192,1279345192,1396331333,1396331333,1496996165,542718553))</Histogram>
<OutlierSelectivity>.684015:</OutlierSelectivity>
<Selectivity>0.0098%</Selectivity>
</Property>
<Property name="VistaFieldDescription">
<AverageFieldSize>125.25</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,0,0,$lb(" "," "," "," A POINTER TO THE SPECIAL TOUR INDICATOR FILE (#457.2) WHICH IDENTIFIES THE"_$c(13,10)_"SCHEDULED TYPE OF SPECIAL (NON-REGULAR) HOU"," ENTER THE CALENDAR MONTH AND YEAR OF THE ACCOUNTING PERIOD YOU WOULD LIKE"_$c(13,10)_"THIS OBLIGATION DOCUMENT TRANSACTION TO AFFE"," INDICATES THE TIME AND LEAVE UNIT IS ENTITLED TO PREMIUM PAY."_$c(13,10)," SYSTEM USER WHO TRIGGERED THE E-PHARMACY EVENT. THIS CAN BE THE SYSTEM"_$c(13,10)_"USER WHO ENTERS PRESCRIPTION OR MAKES BILLING O"," THE REPORT WINDOW WIDTH SETTINGS."_$c(13,10)," THIS FIELD CONTAINS THE DATE AND TIME THAT THE ACTION WAS TAKEN ON THIS "_$c(13,10)_"EXAM RECORD. THIS FIELD IS FILLED IN BY THE S"," THIS FIELD IS A POINTER TO THE NATIONAL SERVICE FILE #730, AND IS"_$c(13,10)_"USED TO LINK THE LOCALLY BUILT 'SERVICE/SECTION' FIL"," THIS FIELD WILL HOLD THE TYPE OF ACTION TO TAKE WHEN AN ERROR OF THIS"_$c(13,10)_"TYPE OCCURS."_$c(13,10)," THIS IS THE ANALYSIS ACCOUNT."_$c(13,10)," THIS IS THE FIRST 30-60 CHARACTERS OF THE DESCRIPTION OF THE NON-ACUTE"_$c(13,10)_"CLASSIFICATION."_$c(13,10)," THIS IS THE OVERRIDE VALUE THAT WILL BE USED FOR THE PAYER RESPONSE FOR "_$c(13,10)_"BILLING REQUESTS. THE VALUE WILL BE USED TO P"," THIS IS THE VENDOR ORDERING ADDRESS LINE 2."_$c(13,10)," YES/NO FLAG NOTING IF THE PSYCHOSOCIAL TAB HAS BEEN COMPLETED."_$c(13,10)),$lb(2,2,1,1,1,1,1,3,12,12,6,13,13,13,1),$lb(536870912,0,0,0,0,0,1092636751,1092636751,1162761285,1162761285,1229866057,1229866057,1398362964,1398362964,1414022432,1159746117,1230184518,1129270868,1230184513,1230184513,1464421452,1179206988,1230184532,1095647564,1179210323,1179210323,1331053906,1331053906,1447382596,1414023507,1497715503,542721363))</Histogram>
<OutlierSelectivity>.141264:</OutlierSelectivity>
<Selectivity>0.0025%</Selectivity>
</Property>
<Property name="VistaFieldLength">
<AverageFieldSize>2.55</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,0,0,$lb(" "," "," "," "," "," "," "," "," "," "," "," 15"," 250"," 35"," 6"," 99"),$lb(2,2,2,2,2,2,2,2,2,2,1,1,1,1,1),$lb(536870912,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,825556992,825556992,842346496,842346496,859111424,859111424,905969664,905969664,960036864,540621056))</Histogram>
<OutlierSelectivity>.683271:</OutlierSelectivity>
<Selectivity>0.4146%</Selectivity>
</Property>
<Property name="VistaFieldName">
<AverageFieldSize>17.75</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,0,0,$lb(" # DAYS"," ANNOTATION DISPLAY FONT NAME"," CHECK DIGIT"," CV STATUS ELIGIBILITY"," DIAGNOSIS"," EPSDT?"," HEADER BLOCK"," LABEL PRINTER COOLER"," NAICS DESCRIPTION"," ORDERED TEST"," PERIOD OF SERVICE"," QUANTITY"," ROUTINE TAG"," STOP POLICY FROM BILLING"," TOUR #1 SCH STOP TIME-4"," ZIP CODE"),$lb(1,1,2,1,1,1,1,1,1,1,1,1,1,1,1),$lb(539172932,589317185,1095650895,1095650895,1128809795,1212498763,1444959060,1129717843,1145651527,1145651527,1162892100,1162892100,1212498244,1212498244,1279345221,1279345221,1312901443,1312901443,1330791493,1330791493,1346720329,1346720329,1364541774,1364541774,1380930900,1380930900,1398034256,1398034256,1414485330,1414485330,1514754080,542787920))</Histogram>
<OutlierSelectivity>.019331:"NAME"</OutlierSelectivity>
<Selectivity>0.0050%</Selectivity>
</Property>
<Property name="VistaFieldNumber">
<AverageFieldSize>4.64</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,0,0,$lb(" .001"," .01"," .02"," .04"," .11"," 1"," 107"," 137"," 18.1"," 2.9"," 3"," 35"," 5"," 6"," 76.1"," 999"),$lb(3,3,3,2,1,2,2,2,1,1,2,1,1,1,1),$lb(539897904,808517632,822083584,822083584,838860800,838860800,872415232,808714240,825294848,774975744,822083584,0,808910848,808910848,859242496,859242496,942551296,825765425,841890048,841890048,855638016,0,889192448,859111424,889192448,889192448,905969664,905969664,926297649,926297649,960051456,540621113))</Histogram>
<OutlierSelectivity>.124907:.01</OutlierSelectivity>
<Selectivity>0.0234%</Selectivity>
</Property>
<Property name="VistaFieldNumericScale">
<AverageFieldSize>2.46</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,0,0,$lb(" "," "," "," "," "," "," "," "," "," "," "," "," "," 10,2"," 3,0"," 9,2"),$lb(2,2,2,2,2,2,2,2,2,2,2,2,1,1,1),$lb(536870912,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,825240626,825240626,858533888,858533888,959197696,540617778))</Histogram>
<OutlierSelectivity>.85948:</OutlierSelectivity>
<Selectivity>0.2667%</Selectivity>
</Property>
<Property name="VistaFieldType">
<AverageFieldSize>9.78</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,0,0,$lb(" COMPUTED"," DATE"," FREETEXT"," FREETEXT"," FREETEXT"," FREETEXT"," FREETEXT"," NUMERIC"," NUMERIC"," POINTER"," POINTER"," SETOFCODES"," SETOFCODES"," SETOFCODES"," SUBFILE"," WORDPROCESSING"),$lb(1,1,10,10,10,10,1,9,1,9,1,12,12,2,1),$lb(541282125,1129270608,1145132101,1145132101,1179796805,0,0,0,0,0,0,0,0,1179796805,1314213189,0,0,1314213189,1347373390,0,0,1347373390,1397052495,0,0,0,0,1163153222,1430406729,1398096454,1464816196,542592850))</Histogram>
<Selectivity>10.0000%</Selectivity>
</Property>
<Property name="VistaFile">
<AverageFieldSize>6.52</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,1,0,$lb(76,1098,3970,5869,7180,8486,9849,12009,13129,14930,16648,19098,19976,21025,22464,23341),$lb(0,0,0,0,0,0,0,1,1,1,1,2,0,1,1),$lb(926285824,926285824,825243960,825243960,859387696,859387696,892876345,892876345,925972528,925972528,942946358,942946358,959984697,959984697,825372720,842018873,858862137,858862137,876163888,876163888,909521976,909521976,959461688,809056256,959919616,825833783,842084402,825242165,842282548,842282548,858993713,842216244))</Histogram>
<OutlierSelectivity>.0171:7575</OutlierSelectivity>
<Selectivity>0.1473%</Selectivity>
</Property>
<Property name="VistaFileNumber">
<AverageFieldSize>7.36</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,0,0,$lb(".4031","40.807","52.48","62.4701","95","165.5","354.71","366.033","423.1","459.01","691.04","790.404","1927.4","2100","8935.913","9002313.9227"),$lb(0,0,0,0,0,0,1,0,1,0,0,0,0,0,0),$lb(775172147,775172147,875572792,875572792,892481076,892481076,909258292,909258292,959774720,959774720,825636142,825636142,859124782,892612151,909520432,859190830,875705134,842214961,892939824,875903278,909717806,909717806,926494766,926494766,825831991,825831991,842084400,842084400,943272757,943272757,959459378,959459378))</Histogram>
<OutlierSelectivity>.023048:165.5</OutlierSelectivity>
<Selectivity>0.1377%</Selectivity>
</Property>
<Property name="VistaMultipleFile">
<AverageFieldSize>2.35</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,1,14,$lb(-10000000000000000000,-10000000000000000000,-10000000000000000000,-10000000000000000000,-10000000000000000000,-10000000000000000000,-10000000000000000000,-10000000000000000000,-10000000000000000000,-10000000000000000000,-10000000000000000000,-10000000000000000000,-10000000000000000000,-10000000000000000000,2458,23338),$lb(21,21,21,21,21,21,21,21,21,21,21,21,21,0,1),$lb(758198320,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,758198320,842282296,875902976,858993464,842216243))</Histogram>
<OutlierSelectivity>.92342:</OutlierSelectivity>
<Selectivity>0.0005%</Selectivity>
</Property>
<Property name="VistaMultipleFileNumber">
<AverageFieldSize>2.52</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,0,0,$lb(" "," "," "," "," "," "," "," "," "," "," "," "," "," "," 194.41"," 9002313.9221"),$lb(2,2,2,2,2,2,2,2,2,2,2,2,2,1,1),$lb(536870912,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,825832494,825832494,959459378,540618800))</Histogram>
<OutlierSelectivity>.92342:</OutlierSelectivity>
<Selectivity>0.0005%</Selectivity>
</Property>
<Property name="VistaPointedToFileNumber">
<AverageFieldSize>2.56</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,0,0,$lb(" "," "," "," "," "," "," "," "," "," "," "," "," "," 1927.41"," 366.17"," 9999999.41"),$lb(2,2,2,2,2,2,2,2,2,2,2,2,1,1,1),$lb(536870912,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,825831991,825831991,859190830,859190830,960051513,540621113))</Histogram>
<OutlierSelectivity>.852788:</OutlierSelectivity>
<Selectivity>0.0117%</Selectivity>
</Property>
<Property name="VistaSite">
<AverageFieldSize>5</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,1,0,$lb(516,516,516,516,516,548,548,548,548,548,673,673,673,673,673,673),$lb(3,3,3,3,1,3,3,3,3,0,3,3,3,3,3),$lb(892417536,0,0,0,0,0,0,0,0,825622528,876085248,0,0,0,0,0,0,0,0,892614656,909587200,0,0,0,0,0,0,0,0,0,0,909587200))</Histogram>
<Selectivity>33.3333%</Selectivity>
</Property>
<SQLMap name="IDKEY">
<BlockCount>-32004</BlockCount>
</SQLMap>
<SQLMap name="MainIndex">
<BlockCount>-1468</BlockCount>
</SQLMap>
<StreamLocation>^Dim.VistaFieldv001S</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
