Class CB.ClassBuilder Extends %RegisteredObject
{

/// Using the given IRIS ClassName find the records in the CB.AttributeMap
/// and create a VX130 class that will maintain the VX130 records when the
/// VISTA records are updated.  This class will have the following characteristics:
/// 1. The record will have a MainIndex that will be the primarykey and id, that
///     index will contain the 3 digit station number, (Sta3n), and all of the
///     FileMan Internal Entry Numbers, (IENs), that make that record unique on
///     the VISTA system.
/// 2. The record will have a property and an index on the VistaEditDate.  
///     The VistaEditDate will be updated with the current UTC date anytime the
///     VISTA record is changed. This allows the user to quickly find all of the 
///     records that have changed during some timeframe so that it will be easy
///     to extract any new records but also any records that where modified during
///     that timeframe.
/// 3. The record will have a property named VistaCreateDate.  This date will only
///     be set the first time the record is discovered on the VISTA system.  If an 
///     historical pull of the data is run on existing records, those records will
///     have a VistaCreateDate of '1900-01-01'.  If the record is discovered by
///     the normal process that watches for changes in the VISTA system then the
///     VistaEditDate will be set to the current UTC date.
/// 4. UTC dates are used for the VistaCreateDate and VistaEditDate so that the user
///     does not need to worry about what timezone the VISTA system is in when determining
///     which records were updated during some timeframe.
/// 5. All classes will have a property named OpCode.  This property will be null
///     unless the record is deleted on the VISTA system.  If the record is deleted the
///     OpCode will be set to 'D' on the VX130 record and the VistaEditDate will be set
///     to the current UTC date and time.
///     That will allow the user to find any records they may have already transferred,
///     and to remove them from thier database or otherwise hide it from users.
/// 6. All classes will have a class method named UpdateObject.  The UpdateObject method
///     takes a Sta3n and the unique IENs from the VISTA system and checks all of the
///     class properties for changes.  If changes are detected, the properties will be
///     updated and the VistaEditDate will be updated.  If the record did not exist then
///     the VistaCreateDate will also be updated.
/// 7. All classes will have a class method named RemoveObject.  The RemoveObject method
///     takes a Sta3n and the unique IENs from the VISTA system and checks to see if the
///     record exists in the VX130 database and the VISTA database.  If the record was
///     deleted from the VISTA database and it exists oin the VX130 database the OpCode
///     will be set equal to 'D' and the VistaEditDate will be updated.
/// 8. All classes have a class method named BuildSite.  The BuildSite method takes a
///     Sta3n and loops through all of the VISTA records at that site and will add the
///     record to the VX130 database if it does not exist.  Any record that is added using
///     the BuildSite method will set the VistaCreateDate to '1900-01-01' but the
///     VistaEditDate will be set the the current UTC date time.
/// 9. All classes will have properties that are specific to the fields that were mapped
///     in the CB.AttributeMap.  A set method is created for each property and that code
///     will find the correspoding data for that VISTA field and compare it to the value
///     stored in the VX130. If the values are the same the return value will be false,
///     (no changes), if the VISTA value is different the property will be updated and the 
///     return value will be set to true.  That in turn will trigger a %Save() on the
///     object and update the VistaEditDate and if necessary update the VistaCreateDate.
///      
/// 
ClassMethod BuildClass(pIRISClassName As %String) As %Status
{
    Set tSC = $$$OK
    Try {
        &sql(SELECT %NOLOCK COUNT(*) INTO :tCnt FROM CB.AttributeMap WHERE IRISClassName=:pIRISClassName )
        if +$GET(tCnt)=0 {
            set tSC=$SYSTEM.Status.Error(5001, pIRISClassName_" was not found in AttributeMap.")
            quit
        }
        &sql(SELECT %NOLOCK COUNT(*) INTO :tCnt FROM %Dictionary.ClassDefinition WHERE name=:pIRISClassName)
        if +$GET(tCnt)>0 {
            set tSC=$SYSTEM.Status.Error(5001, pIRISClassName_" was found in %Dictionary.ClassDefinition.")
            quit
        }
        set tSC=..CreateClass(pIRISClassName, .tClassDef)
        quit:'tSC

        set tSC=..AddProperties(tClassDef)
        quit:'tSC

        set tSC=..AddCommonPropeties(tClassDef)
        quit:'tSC

        set tSC=..AddClassDescription(tClassDef)
        quit:'tSC

        set tSC=..AddIndex(tClassDef)
        quit:'tSC

        set tSC= ..AddBuildSite(tClassDef)
        quit:'tSC

        set tSC=..AddUpdateObject(tClassDef)
        quit:'tSC

        set tSC=..AddRemoveObject(tClassDef)
        quit:'tSC

        set tSC=..AddSetMethods(tClassDef)
        quit:'tSC

        set tIO="./OutputFile"
        OPEN tIO:("NWS")
        USE tIO do $SYSTEM.OBJ.Compile(pIRISClassName,"cuk")
        CLOSE tIO

    }
    Catch ex {
        Set tSC=ex.AsStatus()
    }
    Return tSC
}

/// This method uses the CB.AttributeMap data to add properties to the class
/// with the correct type and constraints. For each record returned from
/// the CB.AttributeMap it will call the AddProperty method to add a property
/// to the class being built. 
ClassMethod AddProperties(pClassDef As %Dictionary.ClassDefinition) As %Status
{
    #Dim tFMField As Dim.VistaFieldv001
    Set tSC = $$$OK
    Try {
        set tIRISClassName=pClassDef.Name
        set tSQL="SELECT %NOLOCK ID FROM CB.AttributeMap WHERE IRISClassName=?"
        set tRSet=##class(%SQL.Statement).%ExecDirect(.tStatement,tSQL,tIRISClassName)
        while tRSet.%Next() {
            set tId=tRSet.%Get("ID")
            set tAMap=##class(CB.AttributeMap).%OpenId(tId)
            set tSC=..AddProperty(tAMap,pClassDef)
            quit:'tSC

        }
    }
    Catch ex {
        Set tSC=ex.AsStatus()
    }
    Return tSC
}

/// This method creates the class inherting from %Persistent and %JSON,Adaptor.
ClassMethod CreateClass(pIRISClassName As %String, ByRef tClassDef As %Dictionary.ClassDefinition) As %Status
{
    Set tSC = $$$OK
    Try {
        set tClassDef=##class(%Dictionary.ClassDefinition).%New(pIRISClassName)
        set tClassDef.Super="%Persistent,%JSON.Adaptor"
        set tClassDef.ClassType="persistent"
        set tClassDef.ProcedureBlock=0
        set tClassDef.SqlRowIdPrivate=1
        set tSC=tClassDef.%Save()
    }
    Catch ex {
        Set tSC=ex.AsStatus()
    }
    Return tSC
}

/// This method takes an IRIS class name and checks the IRIS data dictionary for 
/// a class definition.  If found it will delete the class and defintion from the
/// VX130 system.
ClassMethod DeleteClass(pIRISClassName As %String) As %Status
{
    Set tSC = $$$OK
    Try {
        set tSC=##class(%Dictionary.ClassDefinition).%DeleteId(pIRISClassName)
    }
    Catch ex {
        Set tSC=ex.AsStatus()
    }
    Return tSC
}

/// Given a CB.AttributeMap record and a class definition object, this method
/// will add the property with the type defined in the AttrbuteMap along with
/// any constraints that need to be placed on that property type.
ClassMethod AddProperty(pAttributeMap As CB.AttributeMap, pClassDef As %Dictionary.ClassDefinition) As %Status
{
    Set tSC = $$$OK
    Try {
        set tPropertyName=pAttributeMap.IRISPropertyName
        set tProperty=##class(%Dictionary.PropertyDefinition).%New()
            set tProperty.Name=tPropertyName
            set tProperty.parent=pClassDef
            if pAttributeMap.DataDomain="PKIEN" {
                set tProperty.Required=1
            } else {
                set tProperty.Description="Vista File #"_pAttributeMap.VistaField.VistaFile.VistaFileNumber_$C(13,10)_
                    "Vista Field #"_pAttributeMap.VistaField.VistaFieldNumber_$C(13,10)_
                    pAttributeMap.VistaField.VistaFieldDescription
            }
            set tType=pAttributeMap.DataType
            if tType="%String" {
                do tProperty.Parameters.SetAt(pAttributeMap.MaxLength,"MAXLEN")
                do tProperty.Parameters.SetAt("EXACT","COLLATION")
            } elseif tType="%Numeric" {
                set tNumericScale=pAttributeMap.NumericScale
                set tMinMax=..CalculateMinMax(tNumericScale)
                do tProperty.Parameters.SetAt(tMinMax,"MAXVAL")
                do tProperty.Parameters.SetAt("-"_tMinMax,"MINVAL")
                do tProperty.Parameters.SetAt($PIECE(tNumericScale,",",2),"SCALE")
            }
            set tProperty.Type=pAttributeMap.DataType
            
            set tSC=tProperty.%Save()
            quit:'tSC
            set tSC=pClassDef.Properties.Insert(tProperty)
            quit:'tSC
            set tSC=pClassDef.%Save()
            quit:'tSC
    }
    Catch ex {
        Set tSC=ex.AsStatus()
    }
    Return tSC
}

/// This method will add the common properties all VX130 classes share, namely:
/// Sta3n,OpCode,VistaEditDate,VistaCreateDate.
ClassMethod AddCommonPropeties(pClassDef As %Dictionary.ClassDefinition) As %Status
{
    Set tSC = $$$OK
    Try {
        for tPropertyName="Sta3n","OpCode","VistaCreateDate","VistaEditDate" {
            Set tProperty=##class(%Dictionary.PropertyDefinition).%New()
            set tProperty.Name=tPropertyName
            
            if tPropertyName="Sta3n" {
                set tProperty.Required=1
                set tProperty.Type="%Integer"
                set tProperty.Description="The 3 digit station number"
            } elseif tPropertyName["Date" {
                set tProperty.Type="%TimeStamp"
                set tProperty.Required=1
                if tPropertyName["Create" {
                    set tProperty.Description="The UTC Timestamp when the record was created."
                } else {
                    set tProperty.Description="The UTC Timestamp when the record last changed."
                }
            } else {
                set tProperty.Type="%String"
                set tProperty.Description="This property is null unless the Vista Record was deleted."
            }
            
            set tProperty.parent=pClassDef
            set tSC=tProperty.%Save()
            quit:'tSC
            set tSC=pClassDef.Properties.Insert(tProperty)
            quit:'tSC
            set tSC=pClassDef.%Save()
            quit:'tSC
        }
        
    }
    Catch ex {
        Set tSC=ex.AsStatus()
    }
    Return tSC
}

/// This method will add the VISTA File Description to the class that is
/// watching the data from that VISTA file.
ClassMethod AddClassDescription(pClassDef As %Dictionary.ClassDefinition) As %Status
{
    Set sc = $$$OK
    Try {
        set tClassName=pClassDef.Name
        &sql(SELECT %NOLOCK TOP 1 ID INTO :tId FROM CB.AttributeMap WHERE IRISClassName=:tClassName AND VistaField IS NOT NULL)
        if +$GET(tId)=0 {
            set tSC=$SYSTEM.Status.Error(5001, tClassName_" was not found in AttributeMap.")
            quit
        }
        set tFileDesciption=##class(CB.AttributeMap).%OpenId(tId).VistaField.VistaFile.VistaFileDescription
        set tGlobalsToWatch=..GlobalsToWatch(tClassName,.tSC)
        quit:'tSC
        set pClassDef.Description=tGlobalsToWatch_
            "History: "_$C(13,10)_
            "Class Built by ClassBuilder v1.0 on "_$ZDATETIME($ZTIMESTAMP,3)_$C(13,10,13,10)_
            tFileDesciption
        set tSC=pClassDef.%Save()
    }
    Catch ex {
        Set tSC=ex.AsStatus()
    }
    Return sc
}

/// When a numeric property is being defined this method will be
/// called to setup min and max values as defined by the 
/// CB.AttributeMap for that property. 
ClassMethod CalculateMinMax(pNumericScale As %String, ByRef tSC As %Status) As %String
{
    Set tSC = $$$OK
    Try {
        set tWholeDigits=$PIECE(pNumericScale,",",1)
        set tDecimalDigits=$PIECE(pNumericScale,",",2)
        set $PIECE(tWhole,"9",(tWholeDigits-tDecimalDigits+1))="."
        set $PIECE(tDecimal,"9",(tDecimalDigits+1))=""
    }
    Catch ex {
        Set tSC=ex.AsStatus()
    }
    Return tWhole_tDecimal
}

/// This method adds the MainIndex for the unique Sta3n and IENs so that the record
/// is quickly and easily found when a change is made on VISTA.  It also adds the
/// VistaEditDateIndex so that recently changed records are quickly and easily
/// determined.
ClassMethod AddIndex(pClassDef As %Dictionary.ClassDefinition) As %Status
{
    #Dim tIndex As %Dictionary.IndexDefinition
    Set tSC = $$$OK
    Try {
        set tClassName=pClassDef.Name
        set tSQL="SELECT %NOLOCK IRISPropertyName FROM CB.AttributeMap WHERE IRISClassName=? AND VistaFile IS NOT NULL ORDER BY VistaFile"
        set tRSet=##class(%SQL.Statement).%ExecDirect(.tStatement,tSQL,tClassName)
        set tProperties="Sta3n"
        while tRSet.%Next() {
            set tProperties=tProperties_","_tRSet.%Get("IRISPropertyName")
        }
        set tIndex=##class(%Dictionary.IndexDefinition).%New()
        set tIndex.parent=pClassDef
        set tIndex.Name="MainIndex"
        set tIndex.PrimaryKey=1
        set tIndex.IdKey=1
        set tIndex.Unique=1
        set tIndex.Properties=tProperties
        set tSC=tIndex.%Save()
        quit:'tSC
        do pClassDef.Indices.Insert(tIndex)
        set tSC=pClassDef.%Save()
        quit:'tSC

        set tIndex=##class(%Dictionary.IndexDefinition).%New()
        set tIndex.parent=pClassDef
        set tIndex.Name="VistaEditDateIndex"
        set tIndex.Properties="VistaEditDate"
        set tSC=tIndex.%Save()
        quit:'tSC
        do pClassDef.Indices.Insert(tIndex)
        set tSC=pClassDef.%Save()
        quit:'tSC
    }
    Catch ex {
        Set tSC=ex.AsStatus()
    }
    Return tSC
}

/// This method calls the BuildSiteCode method to generate the code
/// used to loop through the VISTA file for a site and then add that
/// code and method to the given class definition object.
ClassMethod AddBuildSite(pClassDef As %Dictionary.ClassDefinition) As %Status
{
    Set tSC = $$$OK
    Try {
        set tCodeStream=##class(%Stream.TmpCharacter).%New()
        do tCodeStream.Write(..BuildSiteCode(pClassDef.Name))
        set tMethod=##class(%Dictionary.MethodDefinition).%New()
        set tMethod.Name="BuildSite"
        set tMethod.parent=pClassDef
        set tMethod.ClassMethod=1
        set tMethod.Implementation=tCodeStream
        set tMethod.FormalSpec="pSta3n:%Integer,pStartIEN:%String=0"
        set tMethod.ReturnType="%Status"
        set tSC = tMethod.%Save()
        quit:'tSC
        set tSC = pClassDef.Methods.Insert(tMethod)
        quit:'tSC
        set tSC = pClassDef.%Save()
        quit:'tSC
    }
    Catch ex {
        Set tSC=ex.AsStatus()
    }
    Return tSC
}

/// This method uses the information in the CB.AttributeMap to determine which
/// VISTA file and global contains the data for the class and then builds the
/// code that will loop through that data so that an historical pull can be
/// performed on the class.
ClassMethod BuildSiteCode(pIRISClassName As %String, ByRef tSC As %Status) As %String
{
    Set tSC = $$$OK
    Try {
        set tCode=$C(9)_"set tSC = $$$OK"_$C(13,10,9)_
            "Try {"_$C(13,10,9,9)_
                "set tVistaSite = ##class(VX130.VistaSite).%OpenId(pSta3n)"_$C(13,10,9,9)_
                "set tNS = tVistaSite.Sta3a"_$C(13,10,9,9)_"kill tVistaSite"_$C(13,10,9,9)_
                "set tLastIEN = """""_$C(13,10)
        set tCodeEnd=""
        set tTab=$C(9,9)
        set tD=0
        set tPropertyNames=""
        set tSQL="SELECT %NOLOCK IRISPropertyName,VistaFile FROM CB.AttributeMap WHERE IRISClassName=? AND VistaFile IS NOT NULL ORDER BY VistaFile"
        set tRSet=##class(%SQL.Statement).%ExecDirect(.tStatement,tSQL,pIRISClassName)
        while tRSet.%Next() {
            
            set tPropertyName(tD)="t"_tRSet.%Get("IRISPropertyName")
            if tD=0 {
                set tLastIEN="set tLastIEN = "_tPropertyName(tD)
            } else {
                set tLastIEN=tLastIEN_"_"",""_"_tPropertyName(tD)
            }
            set tVistaFile=tRSet.%Get("VistaFile")
            &sql(SELECT GlobalNode INTO :tGlobalNode FROM Dim.VistaFieldv001 WHERE VistaFile=:tVistaFile AND VistaFieldNumber='.01')
            if $GET(tGlobalNode)']"" {
                set tSC=$SYSTEM.Status.Error(5001, "Missing Global Node in DataDictionary for "_tVisaFile_" .01 field")
                quit
            }
            set tGlobal=$PIECE($PIECE(tGlobalNode,"^",2),"D"_tD,1)_"D"_tD
            if tD=0 {
                set tCode=tCode_tTab_"set "_tPropertyName(tD)_" = $ORDER(^|tNS|"_$REPLACE(tGlobal,"D0","pStartIEN")_"))"_$C(13,10)
            } else {
                set tCode=tCode_tTab_"set "_tPropertyName(tD)_" = $ORDER(^|tNS|"_tGlobal_"))"_$C(13,10)
            }
            
            set tCode=tCode_tTab_"while +"_tPropertyName(tD)_" {"_$C(13,10)
            set tCodeEnd=tTab_$C(9)_"set "_tPropertyName(tD)_" = $ORDER(^|tNS|"_tGlobal_"))"_$C(13,10)_
                tTab_"}"_$C(13,10)_tCodeEnd
            set tD=tD+1
            set tTab=tTab_$C(9)
        }
        set tCode=tCode_tTab_tLastIEN_$C(13,10)_tTab_"set tSC=..UpdateObject(pSta3n,tLastIEN,1)"_$C(13,10)
        set tCode=tCode_tCodeEnd_$C(9)_"}"_$C(13,10,9)_"Catch ex {"_$C(13,10,9,9)_
            "Set tSC=ex.AsStatus()"_$C(13,10,9)_"}"_$C(13,10,9)_
            "return tSC"_$C(13,10)
        for tI=0:1:(tD-1) {
            set tCode=$REPLACE(tCode,"D"_tI,tPropertyName(tI))
        }
    }
    Catch ex {
        Set tSC=ex.AsStatus()
    }
    Return tCode
}

/// This method calls the UpdateObjectCode method to generate the code
/// used to locate a record in the VISTA file for a site and also locate
/// locate and update the corresponding VX130 record.  The method returns
/// a status object with the result of the update.  
/// 
ClassMethod AddUpdateObject(pClassDef As %Dictionary.ClassDefinition) As %Status
{
    Set tSC = $$$OK
    Try {
        set tCodeStream=##class(%Stream.TmpCharacter).%New()
        do tCodeStream.Write(..UpdateObjectCode(pClassDef.Name))
        set tMethod=##class(%Dictionary.MethodDefinition).%New()
        set tMethod.Name="UpdateObject"
        set tMethod.parent=pClassDef
        set tMethod.ClassMethod=1
        set tMethod.Implementation=tCodeStream
        set tMethod.FormalSpec="pSta3n:%Integer,pFMPK:%String,pHistoricalPull:%Boolean=0,pLogEdits:%Boolean=0"
        set tMethod.ReturnType="%Status"
        set tSC = tMethod.%Save()
        quit:'tSC
        set tSC = pClassDef.Methods.Insert(tMethod)
        quit:'tSC
        set tSC = pClassDef.%Save()
        quit:'tSC
    }
    Catch ex {
        Set tSC=ex.AsStatus()
    }
    Return tSC
}

/// This method generates the code for the UpdateObject method based
/// on data in the CB.AttributeMap for the given IRIS classname.  It 
/// writes code to find the record in the VISTA system and also find
/// the record on the VX130 system.  The code checks all of the properties
/// for changes and if any are discovered updates the VX130 record and
/// sets a new VistaEditDate and VistaCreateDate if needed.
ClassMethod UpdateObjectCode(pIRISClassName As %String, ByRef tSC As %Status) As %String
{
    Set tSC = $$$OK
    set tCode=$C(9)_
        "set tSC=$$$OK"_$C(13,10,9)_
        "Try {"_$C(13,10,9,9)_
            "set tVistaSite=##class(VX130.VistaSite).%OpenId(pSta3n)"_$C(13,10,9,9)_
	        "set tNS=tVistaSite.Sta3a"_$C(13,10,9,9)_
            "kill tVistaSite"_$C(13,10,9,9)_
	        "kill tBitFlag"_$C(13,10,13,10,9,9) 
    set tD=0  
    Try {
        set tId=$C(9,9)_"set tId = pSta3n"
        set tSQL="SELECT %NOLOCK IRISPropertyName,VistaFile FROM CB.AttributeMap WHERE IRISClassName=? AND VistaFile IS NOT NULL ORDER BY VistaFile"
        set tRSet=##class(%SQL.Statement).%ExecDirect(.tStatement,tSQL,pIRISClassName)
        while tRSet.%Next() {
            set tVistaFile=tRSet.%Get("VistaFile")
            &sql(SELECT GlobalNode INTO :tGlobalNode FROM Dim.VistaFieldv001 WHERE VistaFile=:tVistaFile AND VistaFieldNumber='.01')
            set tPropertyName(tD)="t"_tRSet.%Get("IRISPropertyName")
            set tId=tId_"_""||""_"_tPropertyName(tD)
            if tD=0 {
                set tMethodSig="t"_tRSet.%Get("IRISPropertyName")
            } else {
                set tMethodSig=tMethodSig_",t"_tRSet.%Get("IRISPropertyName")
            }

            set tCode=tCode_"set "_tPropertyName(tD)_" = $PIECE(pFMPK,"","","_(tD+1)_")"_$c(13,10,9,9)_
                "quit:(+"_tPropertyName(tD)_"'>0)"_$C(13,10,13,10,9,9)_
                "if ($GET(^|tNS|"_$PIECE(tGlobalNode,"^",2)_")="""") {"_$C(13,10,9,9,9)_
                    "set tSC = ..RemoveObject(pSta3n,pFMPK)"_$C(13,10,9,9,9)_
                    "quit"_$C(13,10,9,9)_"}"_$C(13,10,13,10,9,9)
            set tD=tD+1
        }
        kill tRSet,tSQL
        set tCode=tCode_tId_$C(13,10,9,9)_
            "set tObj = ..%OpenId(tId,4,.tSC)"_$C(13,10,13,10,9,9)_
            "if '$$$ISOK(tSC) {"_$C(13,10,9,9,9)_
                "if $System.Status.GetErrorCodes(tSC)'=5809 {"_$C(13,10,9,9,9,9)_
			    "// Error is not because the object does not exist.  Probably can't get lock."_$C(13,10,9,9,9,9)_
                "quit"_$C(13,10,9,9,9)_
                "}"_$C(13,10,9,9)_
            "} // Either got lock or object does not exist yet."_$C(13,10,13,10,9,9)_
            "if '$ISOBJECT(tObj) {"_$C(13,10,9,9,9)_
                "set tObj=..%New()"_$C(13,10,9,9,9)_
                "set tObj.Sta3n=pSta3n"_$C(13,10,9,9,9)
        
        for tI=0:1:(tD-1) {
            set tCode=tCode_
                "set tObj."_$EXTRACT(tPropertyName(tI),2,$LENGTH(tPropertyName(tI)))_" = "_tPropertyName(tI)_$C(13,10,9,9,9)
        }
		set tCode=tCode_
            "set tObj.VistaCreateDate=$Case(pHistoricalPull,1:""1900-01-01"",:$ZDATETIME($ZTIMESTAMP,3))"_$C(13,10,9,9,9)_
		    "set tObj.OpCode="""""_$C(13,10,9,9,9)_
            "set $BIT(tBitFlag,1)=1"_$C(13,10,9,9)_
            "}"_$C(13,10,13,10,9,9)
        
        set tSQL="SELECT IRISPropertyName FROM CB.AttributeMap WHERE IRISClassName=? AND VistaField IS NOT NULL"
        set tRSet=##class(%SQL.Statement).%ExecDirect(.tStatement,tSQL,pIRISClassName)
        set tI=2
        while tRSet.%Next() {
            set tCode=tCode_"set $BIT(tBitFlag,"_tI_")=tObj.set"_tRSet.%Get("IRISPropertyName")_"(tNS,"_tMethodSig_")"_$C(13,10,9,9)
            set tI=tI+1
        }
       
        set tCode=tCode_$C(13,10,9,9)_
            "if tObj.OpCode]"""" {"_$C(13,10,9,9,9)_
                "set tObj.OpCode="""""_$C(13,10,9,9,9)_
                "Set $BIT(tBitFlag,"_tI_")=1"_$C(13,10,9,9)_
            "}"_$C(13,10,9,9)_
            "if $BITFIND(tBitFlag,1)>0 {"_$C(13,10,9,9,9)_
                "// Something changed."_$C(13,10,9,9,9)_
                "if pLogEdits {"_$C(13,10,9,9,9,9)_
                    "write ..%ClassName(1),tId,"" """_$C(13,10,9,9,9,9)_
                    "for tzz=1:1:"_tI_" {"_$C(13,10,9,9,9,9,9)_
                        "write $BIT(tBitFlag,tzz)"_$C(13,10,9,9,9,9)_
                    "}"_$C(13,10,9,9,9,9)_
                    "write !"_$C(13,10,9,9,9,9)_
                    "///read tzzz"_$C(13,10,9,9,9)_
                    "}"_$C(13,10,9,9,9)_
                "set tObj.VistaEditDate=$ZDATETIME($ZTIMESTAMP,3)"_$C(13,10,9,9,9)_
                "set tSC=tObj.%Save()"_$C(13,10,9,9)_
            "}"_$C(13,10,9,9)_
            "quit"_$C(13,10,9)_
            "}"_$C(13,10,9)_
            "Catch ex {"_$C(13,10,9,9)_
                "set tSC=ex.AsStatus()"_$C(13,10,9)_
            "}"_$C(13,10,9)_
            "kill tObj"_$C(13,10,9)_
            "return tSC"_$C(13,10)
        for tI=0:1:(tD-1) {
            set tCode=$REPLACE(tCode,"D"_tI,tPropertyName(tI))
        }
    }
    Catch ex {
        Set tSC=ex.AsStatus()
    }
    Return tCode
}

/// This method queries the CB.AttributeMap for the class and for each
/// mapped property calls the AddSetMethod property to add an instance
/// method that has code that can compare the VISTA field value to the
/// VX130 property value. 
ClassMethod AddSetMethods(pClassDef As %Dictionary.ClassDefinition) As %Status
{
    Set tSC = $$$OK
    Try {
        set tIENList=##class(%ArrayOfDataTypes).%New()
        set tClassName=pClassDef.Name
        set tSQL="SELECT IRISPropertyName FROM CB.AttributeMap WHERE IRISClassName=? AND VistaFile IS NOT NULL ORDER BY VistaFile"
        set tRSet=##class(%SQL.Statement).%ExecDirect(.tStatement,tSQL,tClassName)
        set tI=0
        while tRSet.%Next() {
            do tIENList.SetAt(tRSet.%Get("IRISPropertyName"),tI)
            set tI=tI+1
        }

        kill tRSet,tSQL
        set tSQL="SELECT ID FROM CB.AttributeMap WHERE IRISClassName=? AND VistaField IS NOT NULL"
        set tRSet=##class(%SQL.Statement).%ExecDirect(.tStatement,tSQL,tClassName)
        while tRSet.%Next() {
            set tID=tRSet.%Get("ID")
            set tSC=..AddSetMethod(pClassDef,tID,tIENList)
            quit:'tSC
        }
    }
    Catch ex {
        Set tSC=ex.AsStatus()
    }
    Return tSC
}

/// This method uses the given class definition object, a CB.AttributeMap
/// object, and a list of IENs to make a call to SetMethodCode and create
/// an instance method that will compare a VISTA field to the corresponding
/// VX130 class property and return a boolean value that indicates if a change
/// was made to the property, (true) or if no change was made, (false).
ClassMethod AddSetMethod(pClassDef As %Dictionary.ClassDefinition, pAMapID As %Integer, pIENList As %ArrayOfDataTypes) As %Status
{
    Set tSC = $$$OK
    Try {
        set tFormalSpec="pNS:%Integer"
        set tCode=..SetMethodCode(pAMapID)
        set tkey=""
        for tI=1:1 {
            set tPropertyName=pIENList.GetNext(.tkey)
            quit:tkey=""
            set tFormalSpec=tFormalSpec_",p"_tPropertyName_":%String"
            set tCode=$REPLACE(tCode,("D"_tkey),"p"_tPropertyName)
        }
        set tAMap=##Class(CB.AttributeMap).%OpenId(pAMapID)

        set tPropertyName=tAMap.IRISPropertyName

        set tCodeStream=##class(%Stream.TmpCharacter).%New()
        do tCodeStream.Write(tCode)
        set tMethod=##class(%Dictionary.MethodDefinition).%New()
        set tMethod.Name="set"_tPropertyName
        set tMethod.parent=pClassDef
        set tMethod.ClassMethod=0
        set tMethod.Implementation=tCodeStream
        set tMethod.FormalSpec=tFormalSpec
        set tMethod.ReturnType="%Boolean"
        set tSC = tMethod.%Save()
        quit:'tSC
        set tSC = pClassDef.Methods.Insert(tMethod)
        quit:'tSC
        set tSC = pClassDef.%Save()
        quit:'tSC
    }
    Catch ex {
        Set tSC=ex.AsStatus()
    }
    Return tSC
}

/// This method creates the code for the instance property to
/// determine if the property is the same as the VISTA field
/// or if the property needs to be updated.
ClassMethod SetMethodCode(pAttributeID As %Integer, ByRef tSC As %Status) As %String
{
    Set tSC = $$$OK
    Try {
        Set tAMap=##class(CB.AttributeMap).%OpenId(pAttributeID)
        set tPropertyName=tAMap.IRISPropertyName
        set tField=tAMap.VistaField
        set tGlobal=tField.GlobalNode
        set tPiece=tField.Piece
        
              
        set tCode=$C(9)_
            "set tFlag=0"_$C(13,10,9)
            
        if tField.VistaFieldNumber=".001" {
            set tClassName=tAMap.IRISClassName
            &sql(SELECT TOP 1 IRISPropertyName INTO :tIEN FROM CB.AttributeMap WHERE IRISClassName=:tClassName AND VistaFile IS NOT NULL ORDER BY VistaFile DESC)
            set tCode=tCode_"set t"_tPropertyName_" = p"_tIEN_$C(13,10,9)
        } else {
            set tCode=tCode_"set t"_tPropertyName_" = $PIECE($GET(^|pNS|"_$PIECE(tGlobal,"^",2)_"),""^"","_tPiece_")"_$C(13,10,9)
        }
        
        if (tAMap.DataDomain="WordProcessing") {

        } elseif (tAMap.DataDomain="VariablePointerIEN") {

        } elseif (tAMap.DataDomain="VariablePointer") {

        } 

        if (tAMap.DataType="%String") {
            set tCode = tCode_
                "set t"_tPropertyName_" = $EXTRACT(t"_tPropertyName_",1,"_tAMap.MaxLength_")"_$C(13,10,9)

        } elseif (tAMap.DataType="%FilemanTimeStamp") {
            set tCode = tCode_
                "if ('##class(%FilemanTimeStamp).IsValid(t"_tPropertyName_")) {"_$C(13,10,9,9)_
                    "set t"_tPropertyName_" = ""1401231"""_$C(13,10,9,9)_
                    "kill %objlasterror"_$C(13,10,9)_
                "}"_$C(13,10,9)
        }
        set tCode=tCode_
            "if .."_tPropertyName_" '= t"_tPropertyName_" {"_$C(13,10,9,9)_
            "set .."_tPropertyName_" = t"_tPropertyName_$C(13,10,9,9)_
            "set tFlag = 1"_$C(13,10,9)_
            "}"_$C(13,10,9)_
            "kill t"_tPropertyName_$C(13,10,9)_
            "return tFlag"_$C(13,10)
    }
    Catch ex {
        Set tSC=ex.AsStatus()
    }
    kill tAMap,tField,tPropertyName,tGlobal,tPiece
    Return $GET(tCode)
}

/// This method uses the given class defintion to call the RemoveObJectCode
/// method to write the code that determines if a VX130 object/record needs
/// to have the OpCode property set, and add that method to the class definition.
ClassMethod AddRemoveObject(pClassDef As %Dictionary.ClassDefinition) As %Status
{
    Set tSC = $$$OK
    Try {
        set tCodeStream=##class(%Stream.TmpCharacter).%New()
        do tCodeStream.Write(..RemoveObjectCode(pClassDef.Name))
        set tMethod=##class(%Dictionary.MethodDefinition).%New()
        set tMethod.Name="RemoveObject"
        set tMethod.parent=pClassDef
        set tMethod.ClassMethod=1
        set tMethod.Implementation=tCodeStream
        set tMethod.FormalSpec="pSta3n:%Integer,pFMPK:%String"
        set tMethod.ReturnType="%Status"
        set tSC = tMethod.%Save()
        quit:'tSC
        set tSC = pClassDef.Methods.Insert(tMethod)
        quit:'tSC
        set tSC = pClassDef.%Save()
        quit:'tSC
    }
    Catch ex {
        Set tSC=ex.AsStatus()
    }
    Return tSC
}

/// This method uses the given IRIS classname to write the code that 
/// will check the VISTA system to see if the record is deleted. If the
/// record is not found on the VISTA system but is found in the VX130 the
/// method will set the OpCode property of the record and update the VistaEditDate.
ClassMethod RemoveObjectCode(pIRISClassName As %String, ByRef tSC As %Status) As %String
{
    Set tSC = $$$OK
    set tCode=$C(9)_
        "set tSC=$$$OK"_$C(13,10,9)_
        "Try {"_$C(13,10,9,9)_
            "set tVistaSite=##class(VX130.VistaSite).%OpenId(pSta3n)"_$C(13,10,9,9)_
	        "set tNS=tVistaSite.Sta3a"_$C(13,10,9,9)_
            "kill tVistaSite"_$C(13,10,13,10,9,9)
    set tD=0  
    Try {
        set tId=$C(9,9)_"set tId = pSta3n"
        set tSQL="SELECT %NOLOCK IRISPropertyName,VistaFile FROM CB.AttributeMap WHERE IRISClassName=? AND VistaFile IS NOT NULL ORDER BY VistaFile"
        set tRSet=##class(%SQL.Statement).%ExecDirect(.tStatement,tSQL,pIRISClassName)
        while tRSet.%Next() {
            set tVistaFile=tRSet.%Get("VistaFile")
            &sql(SELECT GlobalNode INTO :tGlobalNode FROM Dim.VistaFieldv001 WHERE VistaFile=:tVistaFile AND VistaFieldNumber='.01')
            set tPropertyName(tD)="t"_tRSet.%Get("IRISPropertyName")
            set tId=tId_"_""||""_"_tPropertyName(tD)

            set tCode=tCode_"set "_tPropertyName(tD)_" = $PIECE(pFMPK,"","","_(tD+1)_")"_$c(13,10,9,9)_
                "quit:(+"_tPropertyName(tD)_"'>0)"_$C(13,10,13,10,9,9)_
                "if ($GET(^|tNS|"_$PIECE(tGlobalNode,"^",2)_")='"""") {"_$C(13,10,9,9,9)_
                    "set tSC = ..UpdateObject(pSta3n,pFMPK)"_$C(13,10,9,9,9)_
                    "quit"_$C(13,10,9,9)_"}"_$C(13,10,13,10,9,9)
            set tD=tD+1
        }
        kill tRSet,tSQL
        set tCode=tCode_tId_$C(13,10,9,9)_
            "set tObj = ..%OpenId(tId,4,.tSC)"_$C(13,10,13,10,9,9)_
            "if '$$$ISOK(tSC) {"_$C(13,10,9,9,9)_
                "if $System.Status.GetErrorCodes(tSC)'=5809 {"_$C(13,10,9,9,9,9)_
			        "// Error is not because the object does not exist.  Probably can't get lock."_$C(13,10,9,9,9,9)_
                    "quit"_$C(13,10,9,9,9)_
                "} else {"_$C(13,10,9,9,9,9)_
                    "//Error is because the object does not exist so we don't have to delete it."_$C(13,10,9,9,9,9)_
                    "quit"_$C(13,10,9,9,9)_
                "}"_$C(13,10,9,9)_
            "} // Either got lock or object does not exist yet."_$C(13,10,13,10,9,9)_
            "if $ISOBJECT(tObj) {"_$C(13,10,9,9,9)_
                "set tObj.OpCode=""D"""_$C(13,10,9,9,9)_
                "set tObj.VistaEditDate=$ZDATETIME($ZTIMESTAMP,3)"_$C(13,10,9,9,9)_
                "set tSC=tObj.%Save()"_$C(13,10,9,9)_
            "}"_$C(13,10,9)_
            "quit"_$C(13,10,9)_
            "}"_$C(13,10,9)_
            "Catch ex {"_$C(13,10,9,9)_
                "set tSC=ex.AsStatus()"_$C(13,10,9)_
            "}"_$C(13,10,9)_
            "kill tObj"_$C(13,10,9)_
            "return tSC"_$C(13,10)
        for tI=0:1:(tD-1) {
            set tCode=$REPLACE(tCode,"D"_tI,tPropertyName(tI))
        }
    }
    Catch ex {
        Set tSC=ex.AsStatus()
    }
    Return tCode
}

/// Using the given IRIS classname and the primary keys from the CB.AttributeMap
/// write the GlobalsToWatch INSERT code for the class.
ClassMethod GlobalsToWatch(pIRISClassName As %String, ByRef tSC As %Status) As %String
{
    Set tSC = $$$OK
    set tInsert="INSERT INTO VX130.GlobalsToWatch(GlobalName,ClassName,NumberOfSubscripts,PrimaryKeys,FirstSubscript,SubscriptCompare) "_
        "VALUES (':GlobalName',':ClassName',:NumberOfSubscripts,':PrimaryKeys',':FirstSubscript',':SubscriptCompare')"_$C(13,10)
    set tCode=""
    Try {
        set tSQL="SELECT VistaFile FROM CB.AttributeMap WHERE IRISClassName=? AND VistaFile IS NOT NULL ORDER BY VistaFile"
        set tRSet=##class(%SQL.Statement).%ExecDirect(.tStatement,tSQL,pIRISClassName)
        while tRSet.%Next() {
            set tCode=tCode_tInsert
            set tID=tRSet.%Get("VistaFile")
            &sql(SELECT GlobalNode into :tGlobalNode FROM Dim.VistaFieldv001 WHERE VistaFile=:tID and VistaFieldNumber='.01')
            set tCode=$REPLACE(tCode,":GlobalName",$PIECE(tGlobalNode,"(",1))
            set tCode=$REPLACE(tCode,":ClassName",pIRISClassName)
            set tSubList=$LISTFROMSTRING($PIECE($PIECE(tGlobalNode,"(",2),")",1),",",0)
            set tNumberOfSubscripts=$LISTLENGTH(tSubList)
            set tCode=$REPLACE(tCode,":NumberOfSubscripts",tNumberOfSubscripts)
            set tCode=$REPLACE(tCode,":FirstSubscript",$LISTGET(tSubList,1))
            set tCode=$REPLACE(tCode,"'D0'","NULL")
            set tPrimaryKey=""
            for tI=1:1 {
                quit:$LISTGET(tSubList,tI)=""
                if ($LISTGET(tSubList,tI)?1"D"1N) {
                    set tPrimaryKey=tPrimaryKey_tI_","
                }
            } 
            set tPrimaryKey=$EXTRACT(tPrimaryKey,1,($LENGTH(tPrimaryKey)-1))
            set tCode=$REPLACE(tCode,":PrimaryKeys",tPrimaryKey)
            set tSubscriptCompare=""
            for tI=2:1:(tNumberOfSubscripts-1) {
                if '($LISTGET(tSubList,tI)?1"D"1N) {
                    set tSubscriptCompare=tSubscriptCompare_tI_":"
                    set tSub=$LISTGET(tSubList,tI)
                    if tSub["""" {
                        set tSubscriptCompare=tSubscriptCompare_tSub_","
                    } else {
                        set tSubscriptCompare=tSubscriptCompare_""""_tSub_""","
                    }
                }
            }
            if tSubscriptCompare="" {
                set tSubscriptCompare="NULL"
            } else {
                set tSubscriptCompare=$EXTRACT(tSubscriptCompare,1,($LENGTH(tSubscriptCompare)-1))
            }
            set tCode=$REPLACE(tCode,":SubscriptCompare",tSubscriptCompare)
            set tCode=$REPLACE(tCode,"'NULL'","NULL")
        }
    }
    Catch ex {
        Set tSC=ex.AsStatus()
    }
    Return tCode
}

}
