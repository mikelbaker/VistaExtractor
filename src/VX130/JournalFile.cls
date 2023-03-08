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

Index JournalFileNameIndex On JournalFileName [ Unique ];

Index MirrorSystemIndex On MirrorSystem;

/// Description
ClassMethod AddFiles(pMirror As %String) As %Status
{
    set tsc = $$$OK
    set tCnt=0
    try {
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
                set tsc=tRef.%Save()
            }
        }
    }
    catch ex {
        set tsc=ex.AsStatus()
    }
    return tsc
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
</Data>
<DataLocation>^VX130.JournalFileD</DataLocation>
<DefaultData>JournalFileDefaultData</DefaultData>
<IdLocation>^VX130.JournalFileD</IdLocation>
<IndexLocation>^VX130.JournalFileI</IndexLocation>
<StreamLocation>^VX130.JournalFileS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
