Class VX130.JournalReader Extends %RegisteredObject
{

/// Description
ClassMethod Start() As %Status
{
    Set tsc = $$$OK
    Try {
        set tInstanceID=##class(VX130.IRISInstance).GetInstanceID()
        set tRunFlag=##class(VX130.JournalReaderStatus).GetStatus()
        quit:'tRunFlag
        set tSQL="SELECT JournalFileName,MirrorSystem FROM VX130.JournalFile WHERE EntireFileRead IS NULL AND CurrentlyReadingFile IS NULL AND IRISInstance=?"
        set tRSet=##class(%SQL.Statement).%ExecDirect(.tStatement,tSQL,tInstanceID)
        while tRSet.%Next() {
            set tJournalFile=tRSet.%Get("JournalFileName")
            set tSta3a=tRSet.%Get("MirrorSystem")
            Job ..ReadFile(tJournalFile,tSta3a)
        }
        quit
    }
    Catch ex {
        Set tsc=ex.AsStatus()
    }
    Return tsc
}

/// Description
ClassMethod ReadFile(pJournalFileName As %String, pSta3a As %String) As %Status
{
    #Dim tJRec As %SYS.Journal.SetKillRecord
    #Dim tJFile As %SYS.Journal.File
    Set tsc = $$$OK
    Try {
        set tSta3n=##class(VX130.VistaSite).GetSta3n(pSta3a)
        if 'tSta3n {
            set tsc=$SYSTEM.Status.Error(5001, "Could not find a Sta3n with Sta3a ="_pSta3a,"Did not read file "_pJournalFileName )
            quit
        }
        set tJFile=##class(%SYS.Journal.File).%OpenId(pJournalFileName)
        if '$ISOBJECT(tJFile) {
            set tsc=$SYSTEM.Status.Error(5001, "Could not open journal file: "_pJournalFileName,"Did not read file "_pJournalFileName )
            quit
        }
        set tRunFlag=##class(VX130.JournalReaderStatus).GetStatus()
        set tStartOffset=##class(VX130.JournalReaderHistory).GetStartOffset(pJournalFileName)
        set tEndOffSet=tStartOffset
        set tRecordsRead=0
        set tJRec=tJFile.GetRecordAt(tStartOffset)
        if 'tJRec {
            set tJRec=tJFile.FirstRecord
            set tStartOffset=tJRec.Address
        }
        set tsc=##class(VX130.JournalReaderHistory).Add(pJournalFileName,tSta3n,tStartOffset)
        quit:'tsc
        while ($ISOBJECT(tJRec)&tRunFlag) {
            if "SET,KILL"[tJRec.TypeName {
                set tOffset=tJRec.Address
                set tType=tJRec.TypeName
                set tGlobal=tJRec.GlobalNode
                //Write !,pSta3a," ",tOffset," ",tType," ",tGlobal
                set tEndOffSet=tJRec.Address
                set tRecordsRead=tRecordsRead+1
            }
            set tJRec=tJRec.NextGet()
            set tRunFlag=##class(VX130.JournalReaderStatus).GetStatus()
        }
        Kill tJRec,tJFile
        set tsc=##class(VX130.JournalReaderHistory).End(pJournalFileName,tSta3n,tEndOffSet,tRecordsRead)
        quit
    }
    Catch ex {
        Set tsc=ex.AsStatus()
    }
    Return tsc
}

}
