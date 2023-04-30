Class Dim.VistaFilev001 Extends (%Persistent, %JSON.Adaptor)
{

/// The three digit Station Number.
Property Sta3n As %Integer;

/// Embedded reference to VX130.VistaSite ;
Property VistaSite As VX130.VistaSite(%JSONINCLUDE = "INPUTONLY");

/// The VISTA file number
Property VistaFileNumber As %String(COLLATION = "EXACT");

/// The VISTA file name
Property VistaFileName As %String(COLLATION = "EXACT", MAXLEN = 250);

/// The description for the VISTA file.
Property VistaFileDescription As %String(%JSONINCLUDE = "INPUTONLY", MAXLEN = 20000);

/// The parent File of the VISTA sub-file
Property ParentVistaFile As Dim.VistaFilev001(%JSONINCLUDE = "INPUTONLY");

/// The global root of the VISTA file
Property GlobalRoot As %String(COLLATION = "EXACT");

/// If the record was deleted in VISTA this property
/// will be set to D otherwise this property is NULL.
Property OpCode As %String(%JSONINCLUDE = "INPUTONLY");

/// The first time this record was updated.
Property VistaCreateDate As %TimeStamp(%JSONINCLUDE = "INPUTONLY");

/// The last time this record was updated.
Property VistaEditDate As %TimeStamp(%JSONINCLUDE = "INPUTONLY");

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

/// Description
ClassMethod GetFileInfo(pSta3n As %Integer, pVistaFileNumber As %String, ByRef tsc As %Status) As %DynamicObject
{
    Set tsc = $$$OK
    Try {
        set tSQL="SELECT ID FROM Dim.VistaFilev001 WHERE Sta3n=? AND VistaFileNumber=? AND OpCode IS NULL"
        set tRSet=##class(%SQL.Statement).%ExecDirect(.tStatement,tSQL,pSta3n,pVistaFileNumber)
        
        while tRSet.%Next() {
            do ..%OpenId(tRSet.%Get("ID")).%JSONExportToString(.tFile)
        }
        set tFile=##class(%DynamicObject).%New().%FromJSON(tFile)
    }
    Catch ex {
        Set tSC=ex.AsStatus()
    }
    Return tFile
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
<ExtentSize>22338</ExtentSize>
<IdLocation>^Dim.VistaFilev001D</IdLocation>
<IndexLocation>^Dim.VistaFilev001I</IndexLocation>
<Property name="%%CLASSNAME">
<AverageFieldSize>2</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,0,16,$lb("-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000"),$lb(21,21,21,21,21,21,21,21,21,21,21,21,21,21,21),$lb(758198320,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,758198320))</Histogram>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="%%ID">
<AverageFieldSize>3.99</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,1,0,$lb(195,998,3241,4492,6981,8394,10895,11420,13856,15709,17507,18836,21518,22293,23115,23375),$lb(0,0,0,0,0,0,1,1,1,1,1,0,1,1,2),$lb(825832704,825832704,960051200,960051200,858928177,858928177,875837746,875837746,909719601,909719601,942881076,942881076,825243705,808991029,825504304,825504304,859321654,859321654,892809273,892809273,926232631,926232631,943207222,825767987,842085681,825569592,842152243,842152243,858861877,825308416,859256064,842216247))</Histogram>
<Selectivity>1</Selectivity>
</Property>
<Property name="GlobalRoot">
<AverageFieldSize>12.57</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,0,0,$lb("^%ZIS(1,","^DG(405.2,","^ECH(","^FBAA(162.1,","^GMR(124.3,","^IBE(350.9,","^LAB(95.3,","^MDK(704.201,","^PRSE(452.8,","^PS(52.92,","^PSD(58.35,","^RAMIS(71,","^SDEC(409.85,","^VA(200,","^XPD(9.6,","^XUCS(8987.2,"),$lb(1,1,1,1,1,1,1,1,2,3,1,1,1,1,2),$lb(1579506249,626674003,1145514036,1145514036,1162037288,1162037288,1178747201,1178747201,1196249640,1196249640,1229079848,1229079848,1279345192,1279345192,1296321320,1296321320,1347572549,1381188904,1395143986,674574894,1143485752,1347634216,1380011337,1380011337,1396983107,1396983107,1447110706,1447110706,1481655336,1346644025,1430475560,1582847299))</Histogram>
<OutlierSelectivity>.040179:"^VA(200,"</OutlierSelectivity>
<Selectivity>0.1393%</Selectivity>
</Property>
<Property name="OpCode">
<AverageFieldSize>2</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,0,0,$lb(" "," "," "," "," "," "," "," "," "," "," "," "," "," "," "," "),$lb(2,2,2,2,2,2,2,2,2,2,2,2,2,2,2),$lb(536870912,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,536870912))</Histogram>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="ParentVistaFile">
<AverageFieldSize>4.95</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,1,6,$lb(-10000000000000000000,-10000000000000000000,-10000000000000000000,-10000000000000000000,-10000000000000000000,-10000000000000000000,1006,3354,6973,8403,11106,13862,17216,18830,22294,23374),$lb(21,21,21,21,21,0,0,0,0,0,1,1,1,0,1),$lb(758198320,0,0,0,0,0,0,0,0,0,0,758198320,825241654,825241654,858993972,858993972,909719347,909719347,942944307,942944307,825307440,825307190,859321906,859321906,926036278,926036278,943207216,825767987,842150457,842152244,858994484,842216247))</Histogram>
<OutlierSelectivity>.339286:</OutlierSelectivity>
<Selectivity>0.1156%</Selectivity>
</Property>
<Property name="Sta3n">
<AverageFieldSize>4</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,1,0,$lb(516,516,516,516,516,548,548,548,548,548,673,673,673,673,673,673),$lb(3,3,3,3,1,3,3,3,3,0,3,3,3,3,3),$lb(892417536,0,0,0,0,0,0,0,0,825622528,876085248,0,0,0,0,0,0,0,0,892614656,909587200,0,0,0,0,0,0,0,0,0,0,909587200))</Histogram>
<Selectivity>33.3333%</Selectivity>
</Property>
<Property name="VistaCreateDate">
<AverageFieldSize>21</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,0,0,$lb("2023-03-15 19:00:40","2023-03-15 19:00:42","2023-03-15 19:00:48","2023-03-15 19:00:51","2023-03-15 19:00:57","2023-03-15 19:01:45","2023-03-15 19:01:51","2023-03-15 19:01:53","2023-03-15 19:01:58","2023-03-15 19:02:03","2023-03-15 19:02:19","2023-03-15 19:02:22","2023-03-15 19:02:28","2023-03-15 19:02:30","2023-03-15 19:02:32","2023-03-15 19:02:33"),$lb(18,18,17,18,15,17,18,18,15,17,17,18,17,18,18),$lb(842019379,805306368,838860800,838860800,939524096,876085248,892403712,822083584,922746880,809121079,825898037,875888640,892403712,822083584,855638016,855638016,939524096,825898296,842674227,808648704,825819136,825819136,842137600,838860800,939524096,842530816,858783744,805306368,838860800,838860800,855638016,842019379))</Histogram>
<Selectivity>2.6316%</Selectivity>
</Property>
<Property name="VistaEditDate">
<AverageFieldSize>21</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,0,0,$lb("2023-03-15 19:00:40","2023-03-15 19:00:42","2023-03-15 19:00:48","2023-03-15 19:00:51","2023-03-15 19:00:57","2023-03-15 19:01:45","2023-03-15 19:01:51","2023-03-15 19:01:53","2023-03-15 19:01:58","2023-03-15 19:02:03","2023-03-15 19:02:19","2023-03-15 19:02:22","2023-03-15 19:02:28","2023-03-15 19:02:30","2023-03-15 19:02:32","2023-03-15 19:02:33"),$lb(18,18,17,18,15,17,18,18,15,17,17,18,17,18,18),$lb(842019379,805306368,838860800,838860800,939524096,876085248,892403712,822083584,922746880,809121079,825898037,875888640,892403712,822083584,855638016,855638016,939524096,825898296,842674227,808648704,825819136,825819136,842137600,838860800,939524096,842530816,858783744,805306368,838860800,838860800,855638016,842019379))</Histogram>
<Selectivity>2.6316%</Selectivity>
</Property>
<Property name="VistaFileDescription">
<AverageFieldSize>203.03</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,0,0,$lb(" "," ","   ALLOWS THE GROUPING OF UNIT DOSE ORDERS, TO FACILITATE THE ENTRY OF"_$c(13,10)_"MULTIPLE ORDERS AT ONE TIME."_$c(13,10)," AN IRRADIATION EVENT IS THE OCCURRENCE OF RADIATION BEING APPLIED TO A "_$c(13,10)_"PATIENT IN A SINGLE CONTINUOUS TIME-FRAME BETW"," FOR WARD LOCATIONS ENTERED HERE, PRESCRIPTIONS FOR PATIENTS ON THESE WARDS"_$c(13,10)_"WILL NOT BE CANCELED BY THE AUTOCANCEL RX'S"," PHARMACY-SPECIFIC DATA -- NCPDP #, DEFAULT DEA #, ETC.  ONE BPS PHARMACY"_$c(13,10)_"HAS A LIST OF ONE OR MORE OUTPATIENT SITES (F"," THE SELECTED CODES MULTIPLE STORES THE CODES SELECTED BY THE USER TO"_$c(13,10)_"BE IN THE TAXONOMY. THE STORAGE HIERARCHY IS:"_$c(13,10)_" T"," THIS FIELD CONTAINS THE EVENT LOG DATA XML DOCUMENT IN"_$c(13,10)_"UUENCODED FORMAT."_$c(13,10)," THIS FIELD STORES AN OPTIONAL EXPLANATION FOR THE "_$c(13,10)_"REASON. THE TEXT CAN BE PRESENTED TO THE USER BY"_$c(13,10)_"THE GUI APPLICATI"," THIS FILE CONTAINS INFORMATION FOR IMAGING DICOM FIELDS THAT WILL BE "_$c(13,10)_"DISPLAYED WHEN CAPTURE OF AN IMAGE IS DONE WITHI"," THIS FILE DEFINES THE ITEMS, THEIR LOCATION, AND QUANTITY FOR EACH AREA"_$c(13,10)_"OF USE (AOU) IN THE HOSPITAL.  ADDITIONALLY, I"," THIS FILE WILL CONTAIN THE CURRENT WORK ORDER NUMBER FOR THE VAF 10-2529-3"_$c(13,10)_"THAT HAS BEEN INITIATED AND SEND TO THE LOC"," THIS IS THE DATE/TIME THAT THIS PERSON'S RESPONSIBILITIES FOR SCRUB"_$c(13,10)_"SUPPORT BEGAN.  BOTH DATE AND TIME MUST BE ENTERED"," THIS MULTIPLE CONTAINS THE LIST OF PAY-TO PROVIDERS FOR THIS VISTA"_$c(13,10)_"DATABASE."_$c(13,10)," THIS NODE CONTAINS A LIST OF IMAGES THAT WERE REFERENCED DURING"_$c(13,10)_"THE EXAM INTERPRETATION EITHER BY ANNOTATIONS, OR BY D"," YOU CAN ENTER ANY ADDITIONAL REFERENCE INFORMATION"_$c(13,10)_"RELATED TO THE SELECTION RULE. THE CONTENT OF THIS"_$c(13,10)_"FIELD IS NOT US"),$lb(2,1,1,1,1,1,3,12,8,11,11,6,6,6,1),$lb(536870912,0,0,0,538984780,538984780,1095639113,1095639113,1179603488,1179603488,1346912594,1346912594,1414022432,1159746373,1230184518,1129270868,1398034258,1162626080,1279598659,1129270868,1145390665,1145390665,1464421452,1179208773,1230184532,1230184532,1297435732,1297435732,1313817669,1414023507,1498371360,542723925))</Histogram>
<OutlierSelectivity>.104911:</OutlierSelectivity>
<Selectivity>0.0195%</Selectivity>
</Property>
<Property name="VistaFileName">
<AverageFieldSize>18.45</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,0,0,$lb("*ADDITIONAL PRINT LOCATIONS","ANSWERLIST","CODE MAPPINGS","DATE/TIME OF REPORT","DIETETIC ENCOUNTERS","ELEMENT TAG","FREQUENCY","IMP/EXP FORM LINE","MAGJ ZLIST SEARCH","NODES","PHARMACY BENEFITS MANAGER (PBM) APPLICATION","RECIPE","SECONDARY DIAGNOSTIC CODE","SYNONYM","VARIABLES","XUEPCS PSDRPH AUDIT"),$lb(0,0,0,1,0,0,0,0,0,0,0,0,1,0,0),$lb(708920388,708920388,1095652183,1095652183,1129268293,1129268293,1145132101,1096041775,1229280325,1145652564,1162626381,1162626381,1179796817,1179796817,1229803567,1229803567,1296123722,1296123722,1313817669,1313817669,1346912594,1346912594,1380270921,1380270921,1397048143,1162039118,1498304334,1398361679,1447121481,1447121481,1481983312,1481983312))</Histogram>
<OutlierSelectivity>.020089:"DESCRIPTION"</OutlierSelectivity>
<Selectivity>0.0340%</Selectivity>
</Property>
<Property name="VistaFileNumber">
<AverageFieldSize>8.5</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,0,0,$lb("3.5","9.82311","53.1119","59.701","115.1","131.02","200.0089834","356.012","373.05","453.14","712.01","811.231","2006.5771","6914.092","8991.2112","9999999.9201"),$lb(0,0,1,0,1,0,0,1,0,0,0,0,0,0,0),$lb(858666240,858666240,959330354,959330354,892546609,858665265,959330096,892939831,825308462,825568817,858861104,825438510,842018862,842018862,859125294,892743216,926101040,859255598,875901742,875901742,925970990,925970990,942747950,942747950,842018870,842018870,909717812,909717812,943274289,943274289,960051513,960051513))</Histogram>
<OutlierSelectivity>.004464:9.716</OutlierSelectivity>
<Selectivity>0.0188%</Selectivity>
</Property>
<Property name="VistaSite">
<AverageFieldSize>5</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,1,0,$lb(516,516,516,516,516,548,548,548,548,548,673,673,673,673,673,673),$lb(3,3,3,3,1,3,3,3,3,0,3,3,3,3,3),$lb(892417536,0,0,0,0,0,0,0,0,825622528,876085248,0,0,0,0,0,0,0,0,892614656,909587200,0,0,0,0,0,0,0,0,0,0,909587200))</Histogram>
<Selectivity>33.3333%</Selectivity>
</Property>
<SQLMap name="IDKEY">
<BlockCount>-4048</BlockCount>
</SQLMap>
<SQLMap name="MainIndex">
<BlockCount>-192</BlockCount>
</SQLMap>
<SQLMap name="VistaFileNameIndex">
<BlockCount>-296</BlockCount>
</SQLMap>
<StreamLocation>^Dim.VistaFilev001S</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
