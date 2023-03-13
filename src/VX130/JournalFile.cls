/// This class holds all of the journal files
/// known throughut the system and the status
/// of that JournalFile.
Class VX130.JournalFile Extends %Persistent
{

/// The name of the Mirrored Journal file.
Property JournalFileName As %String;

/// The name of the mirror that created this journal file.
Property MirrorSystem As %String;

/// If true the mirror is no longer writing to this journal file.
Property JournalFileClosed As %Boolean;

/// The date and time the Journal file was created on the mirror.
Property JournalFileCreated As %TimeStamp;

/// Has the entire file been read by JournalReader?  If yes means the
/// journal file was closed and that every record has been read and
/// evaluated.
Property EntireFileRead As %Boolean;

Property CurrentlyReadingFile As %Boolean;

Property IRISInstance As VX130.IRISInstance;

Index JournalFileNameIndex On JournalFileName [ Unique ];

Index MirrorSystemIndex On MirrorSystem;

Index EntireFileReadIndex On (EntireFileRead, CurrentlyReadingFile, IRISInstance);

/// Get the Known journalfiles in reverse order.  If file is
/// not found add it to the class.  If it is found and it is not
/// the first file in the list then we know that file has been closed.
ClassMethod AddMirrorFiles(pMirror As %String) As %Status
{
    set tsc = $$$OK
    set tCnt=0
    try {
        set tInstanceID=##class(VX130.IRISInstance).GetInstanceID()
        set tRSet = ##class(%ResultSet).%New("%SYS.Journal.File:MirrorByTimeReverseOrder")
        set tsc=tRSet.%Execute("",pMirror)
        while tRSet.%Next() {
            set tCnt=tCnt+1
            //w !,tRSet.%Get("Name")_" "_tRSet.%Get("Size")_" "_tRSet.%Get("Creation Time")_" "_tRSet.%Get("Reason")_" "_tRSet.%Get("Data Size")
            set tJournalFileName=tRSet.%Get("Name")
            &sql(SELECT ID INTO :tID FROM VX130.JournalFile WHERE MirrorSystem=:pMirror AND JournalFileName=:tJournalFileName)
            if $GET(tID) {
                if tCnt>1 {
                    set tRef=..%OpenId(tID)
                    set tRef.JournalFileClosed=1
                    set tsc=tRef.%Save()
                }
} else {
                set tRef=..%New()
                set tRef.JournalFileName=tJournalFileName
                set tRef.MirrorSystem=pMirror
                if tCnt>1 {
                    set tRef.JournalFileClosed=1
                }
                set tRef.JournalFileCreated=tRSet.%Get("Creation Time")
                set tRef.IRISInstance=##class(VX130.IRISInstance).%OpenId(tInstanceID,0)
                set tsc=tRef.%Save()
            }
        }
    }
    catch ex {
        set tsc=ex.AsStatus()
    }
    return tsc
}

/// Get a list of all of the mirrors on this system and then for each
/// mirror name call AddMirrorFiles method passing the mirror name to 
/// add journalfiles to the table.
ClassMethod AddFiles() As %Status
{
    set tsc = $$$OK
    try {
        set tMirrorList=##class(%SYSTEM.Mirror).GetMirrorNames()
        for tCnt=1:1:$LISTLENGTH(tMirrorList) {
            set tMirror=$LIST(tMirrorList,tCnt)
            set tsc=..AddMirrorFiles(tMirror)
        }
    }
    catch ex {
        set tsc=ex.AsStatus()
    }
    return tsc
}

/// Using the given journal file name return the id of the record in
/// VX130.Journalfile.
ClassMethod GetID(pJournalFileName As %String) As %String
{
    &sql(SELECT ID INTO :tID FROM VX130.JournalFile WHERE JournalFileName=:pJournalFileName)
    Return $GET(tID)
}

/// Using the given journal file name set the CurrentlyReadingFile property
/// to true for the record in VX130.JournalFile.
ClassMethod SetCurrentlyReadingFile(pJournalFileName As %String) As %Status
{
    Set tsc = $$$OK
    Try {
        &sql(UPDATE VX130.JournalFile SET CurrentlyReadingFile=1 WHERE JournalFileName=:pJournalFileName)
    }
    Catch ex {
        Set tSC=ex.AsStatus()
    }
    Return tsc
}

/// Using the given journal file name set the CurrentlyReadingFile property
/// to null for the record in VX130.JournalFile
ClassMethod RemoveCurrentlyReadingFile(pJournalFileName As %String, pEndOffset As %Integer) As %Status
{
    Set tsc = $$$OK
    Try {
        &sql(UPDATE VX130.JournalFile SET CurrentlyReadingFile=NULL WHERE JournalFileName=:pJournalFileName)
        &sql(SELECT JournalFileClosed INTO :tClosed FROM VX130.JournalFile WHERE JournalFileName=:pJournalFileName)
        if $GET(tClosed) {
            set tJFile=##class(%SYS.Journal.File).%OpenId(pJournalFileName)
            if $ISOBJECT(tJFile) {
                set tLastOffset=tJFile.LastRecord.Address
                kill tJFile
            }
            if pEndOffset=tLastOffset {
                 &sql(UPDATE VX130.JournalFile SET EntireFileRead=1 WHERE JournalFileName=:pJournalFileName)
            }
        }
    }
    Catch ex {
        Set tSC=ex.AsStatus()
    }
    Return tsc
}

/// Using the given journal file name set the EntireFileRead property
/// to true for the record in VX130.JournalFile
ClassMethod SetEntireFileRead(pJournalFileName) As %Status
{
    Set tsc = $$$OK
    Try {
        &sql(UPDATE VX130.JournalFile SET EntireFileRead=1 WHERE JournalFileName=:pJournalFileName)
    }
    Catch ex {
        Set tSC=ex.AsStatus()
    }
    Return tsc
}

Storage Default
{
<Data name="JournalFileDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>JournalFileName</Value>
</Value>
<Value name="3">
<Value>MirrorSystem</Value>
</Value>
<Value name="4">
<Value>JournalFileClosed</Value>
</Value>
<Value name="5">
<Value>JournalFileCreated</Value>
</Value>
<Value name="6">
<Value>EntireFileRead</Value>
</Value>
<Value name="7">
<Value>CurrentlyReadingFile</Value>
</Value>
<Value name="8">
<Value>IRISInstance</Value>
</Value>
</Data>
<DataLocation>^VX130.JournalFileD</DataLocation>
<DefaultData>JournalFileDefaultData</DefaultData>
<IdLocation>^VX130.JournalFileD</IdLocation>
<IndexLocation>^VX130.JournalFileI</IndexLocation>
<StreamLocation>^VX130.JournalFileS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
