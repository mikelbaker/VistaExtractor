/// This class contains the record of when and where the JournalReader
/// started, how many records were read and evaluated and when and where
/// the JournalReader stopped.
Class VX130.JournalReaderHistory Extends %Persistent
{

/// A link to the VX130.JournalFile object.
Property JournalFile As VX130.JournalFile;

/// The starting address for the JournalReader in the journal file.
Property StartOffset As %Integer;

/// The starting date and time for the JournalReader in the journal file.
Property StartDateTime As %TimeStamp;

/// The number of records read from the start offset to the ending offset.
Property NumberOfRecordsRead As %Integer;

/// The number of records that were found that are in GlobalsToWatch.
Property NumberOfRecordsFound As %Integer;

/// The ending address for the JournalReader in the journal file.
Property EndOffSet As %Integer;

/// The ending date and time for the JournalReader in the journal file.
Property EndDateTime As %TimeStamp;

/// A link to the VX130.VistaSite object for this journal file.
Property VistaSite As VX130.VistaSite;

Index JournalFileIndex On JournalFile;

/// For a given journal file find the last record read in the JournalFileHistory.
/// If no record is found return a zero to start at the beginning of the file.
ClassMethod GetStartOffset(pJournalFileName, ByRef tsc As %Status) As %Integer
{
    set tsc=$$$OK
    Try {
        &sql(SELECT %NOLOCK TOP 1 EndOffSet INTO :tStartOffset FROM VX130.JournalReaderHistory WHERE JournalFile->JournalFileName=:pJournalFileName ORDER BY StartDateTime DESC)
    }
    Catch ex {
        Set tsc=ex.AsStatus()
    }
    set tStartOffset=$SELECT($GET(tStartOffset)>0:tStartOffset,1:0)
    return tStartOffset
}

/// This method is called when a JournalReader is started to add an entry
/// to the JournalReaderHistory.
ClassMethod Add(pJournalFileName As %String, pSta3n As %Integer, pStartOffset As %Integer) As %Status
{
    Set tsc = $$$OK
    Try {
        &sql(SELECT ID INTO :tID FROM VX130.JournalReaderHistory WHERE JournalFile->JournalFileName=:pJournalFileName AND EndOffSet IS NULL)
        if $GET(tID) {
            set tsc=$SYSTEM.Status.Error(5001, "JournalReaderHistory at ID "_tID_" does not have an Ending Offset","New record NOT added" )
            quit
        }
        &sql(SELECT ID INTO :tID FROM VX130.JournalFile WHERE JournalFileName=:pJournalFileName)
        if '$GET(tID) {
            set tsc=$SYSTEM.Status.Error(5001, "JournalFile Not found with name: "_pJournalFileName,"New record NOT added" )
            quit
        }
        set tJRH=..%New()
        set tJRH.JournalFile=##class(VX130.JournalFile).%OpenId(tID)
        set tJRH.VistaSite=##class(VX130.VistaSite).%OpenId(pSta3n)
        set tJRH.StartDateTime=$ZDATETIME($ZTIMESTAMP,3)
        set tJRH.StartOffset=pStartOffset
        set tsc=tJRH.%Save()
        quit:$$$ISERR(tsc)
        set tsc=##class(VX130.JournalFile).SetCurrentlyReadingFile(pJournalFileName)
        quit:$$$ISERR(tsc)
    }
    Catch ex {
        Set tsc=ex.AsStatus()
    }
    Return tsc
}

/// This method is called when a JournalReader has finished reading a 
/// journal file to close out the history that the JournalReader started.
ClassMethod End(pJournalFileName As %String, pSta3n As %Integer, pEndOffset As %Integer, tRecordsRead As %Integer) As %Status
{
    Set tsc = $$$OK
    Try {
        &sql(SELECT ID INTO :tID FROM VX130.JournalReaderHistory WHERE JournalFile->JournalFileName=:pJournalFileName AND VistaSite=:pSta3n AND EndOffSet IS NULL)
        set tJRH=..%OpenId(tID)
        if '$ISOBJECT(tJRH) {
            set tsc=$SYSTEM.Status.Error(5001, "JournalFile Not found with name: "_pJournalFileName,"record with ID: "_tID_" NOT ended" )
            quit
        }
        set tJRH.EndOffSet=pEndOffset
        set tJRH.NumberOfRecordsRead=tRecordsRead
        set tJRH.EndDateTime=$ZDATETIME($ZTIMESTAMP,3)
        set tsc=tJRH.%Save()
        quit:$$$ISERR(tsc)
        set tsc=##class(VX130.JournalFile).RemoveCurrentlyReadingFile(pJournalFileName,pEndOffset)
        quit:$$$ISERR(tsc)
    }
    Catch ex {
        Set tsc=ex.AsStatus()
    }
    Return tsc
}

Storage Default
{
<Data name="JournalReaderHistoryDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>JournalFile</Value>
</Value>
<Value name="3">
<Value>StartOffset</Value>
</Value>
<Value name="4">
<Value>StartDateTime</Value>
</Value>
<Value name="5">
<Value>NumberOfRecordsRead</Value>
</Value>
<Value name="6">
<Value>NumberOfRecordsFound</Value>
</Value>
<Value name="7">
<Value>EndOffSet</Value>
</Value>
<Value name="8">
<Value>EndDateTime</Value>
</Value>
<Value name="9">
<Value>VistaSite</Value>
</Value>
</Data>
<DataLocation>^VX130.JournalReaderHistoryD</DataLocation>
<DefaultData>JournalReaderHistoryDefaultData</DefaultData>
<IdLocation>^VX130.JournalReaderHistoryD</IdLocation>
<IndexLocation>^VX130.JournalReaderHistoryI</IndexLocation>
<StreamLocation>^VX130.JournalReaderHistoryS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
