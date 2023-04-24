Class VX130.GlobalsToWatch Extends %Persistent
{

/// The name of the global that has data we are watching.
Property GlobalName As %String(COLLATION = "EXACT", MAXLEN = 500);

/// The FileMan file number if the first subscript is the file number.
Property FirstSubscript As %String(COLLATION = "EXACT", MAXLEN = 50);

/// The number of subcripts the FileMan file or subfile uses to store data.
Property NumberOfSubscripts As %Integer;

/// If the FileMan file is a subfile this contains the subscript number and constant.
Property SubscriptCompare As %String(COLLATION = "EXACT", MAXLEN = 200);

/// A comma seperated list of subsripts that have the IENs that make the record unique.
Property PrimaryKeys As %String(COLLATION = "EXACT", MAXLEN = 100);

/// THe ClassName associated with the global and file or subfile.
Property ClassName As %String(COLLATION = "EXACT", MAXLEN = 500);

Index GlobalNameIndex On GlobalName;

Index FirstSubscriptIndex On (GlobalName, FirstSubscript);

Index NumberOfSubscriptsIndex On (GlobalName, FirstSubscript, NumberOfSubscripts);

/// Add some entries to populate this class.
ClassMethod Init() As %Status
{
    Set tsc = $$$OK
    Try {
        do ..%KillExtent()
        &sql(INSERT INTO VX130.GlobalsToWatch(GlobalName,FirstSubscript,NumberOfSubscripts,SubscriptCompare,PrimaryKeys,ClassName) VALUES ('^DIC',NULL,2,NULL,'1','Dim.VistaFilev001'))
        &sql(INSERT INTO VX130.GlobalsToWatch(GlobalName,FirstSubscript,NumberOfSubscripts,SubscriptCompare,PrimaryKeys,ClassName) VALUES ('^DIC',NULL,4,'2:"%D"','1','Dim.VistaFilev001'))
        &sql(INSERT INTO VX130.GlobalsToWatch(GlobalName,FirstSubscript,NumberOfSubscripts,SubscriptCompare,PrimaryKeys,ClassName) VALUES ('^DD',NULL,2,NULL,'1','Dim.VistaFilev001'))
        &sql(INSERT INTO VX130.GlobalsToWatch(GlobalName,FirstSubscript,NumberOfSubscripts,SubscriptCompare,PrimaryKeys,ClassName) VALUES ('^DD',NULL,3,NULL,'1,2','Dim.VistaFieldv001'))
        &sql(INSERT INTO VX130.GlobalsToWatch(GlobalName,FirstSubscript,NumberOfSubscripts,SubscriptCompare,PrimaryKeys,ClassName) VALUES ('^DD',NULL,5,'3:"21"','1,2','Dim.VistaFieldv001'))
    }
    Catch ex {
        Set tsc=ex.AsStatus()
    }
    Return tsc
}

/// Description
ClassMethod Evaluate(pGlobalNode As %String, pType As %String, pSta3n As %Integer) As %Status
{
    Set tsc = $$$OK
    Try {
        set tGlobalName=$QSUBSCRIPT(pGlobalNode,0)
        quit:'$DATA(^VX130.GlobalsToWatchI("GlobalNameIndex",tGlobalName))
        set tFirstSubscript=$QSUBSCRIPT(pGlobalNode,1)
        if '$DATA(^VX130.GlobalsToWatchI("FirstSubscriptIndex",tGlobalName,tFirstSubscript)) {
            if $DATA(^VX130.GlobalsToWatchI("FirstSubscriptIndex",tGlobalName,-100000000000000)) {
                set tFirstSubscript=-100000000000000
            } else {
                quit
            }
        }
        set tNumberOfSubscipts=$QLENGTH(pGlobalNode)
        if '$DATA(^VX130.GlobalsToWatchI("NumberOfSubscriptsIndex",tGlobalName,tFirstSubscript,tNumberOfSubscipts)) {
            if pType="KILL" { set tNumberOfSubscipts=tNumberOfSubscipts+1 }
            if '$DATA(^VX130.GlobalsToWatchI("NumberOfSubscriptsIndex",tGlobalName,tFirstSubscript,tNumberOfSubscipts)) {
                write "Bad number of subs"
                quit
            }
        }
        set tID=$ORDER(^VX130.GlobalsToWatchI("NumberOfSubscriptsIndex",tGlobalName,tFirstSubscript,tNumberOfSubscipts,0))
        while tID {
            set tGTW=..%OpenId(tID,0)
            if '$ISOBJECT(tGTW) {
                w "No ID found"
                quit
            }
            set tSubscriptCompare=tGTW.SubscriptCompare
            if tSubscriptCompare]"" {
                //Check Subscripts quit if not found
            }
            set tClassName=tGTW.ClassName
            set tPK=tGTW.PrimaryKeys
            set tPrimaryKeys=..GetPrimaryKeys(pGlobalNode,tPK)
            do ##class(VX130.DataFilerQueue).Add(tClassName,pSta3n,tPrimaryKeys)
            set tID=$ORDER(^VX130.GlobalsToWatchI("NumberOfSubscriptsIndex",tGlobalName,tFirstSubscript,tNumberOfSubscipts,tID))
        }
    }
    Catch ex {
        Set tsc=ex.AsStatus()
    }
    Return tsc
}

/// Description
ClassMethod GetPrimaryKeys(pGlobalNode As %String, tPK As %String, ByRef tsc As %Status) As %String
{
    Set tsc = $$$OK
    set tPrimaryKeys=""
    for tPosition=1:1 {
        quit:$PIECE(tPK,",",tPosition)=""
        set tPrimaryKeys=tPrimaryKeys_$QSUBSCRIPT(pGlobalNode,$PIECE(tPK,",",tPosition))_","
    }
    Return tPrimaryKeys
}

Storage Default
{
<Data name="GlobalsToWatchDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>GlobalName</Value>
</Value>
<Value name="3">
<Value>FirstSubscript</Value>
</Value>
<Value name="4">
<Value>NumberOfSubscripts</Value>
</Value>
<Value name="5">
<Value>SubscriptCompare</Value>
</Value>
<Value name="6">
<Value>PrimaryKeys</Value>
</Value>
<Value name="7">
<Value>ClassName</Value>
</Value>
</Data>
<DataLocation>^VX130.GlobalsToWatchD</DataLocation>
<DefaultData>GlobalsToWatchDefaultData</DefaultData>
<IdLocation>^VX130.GlobalsToWatchD</IdLocation>
<IndexLocation>^VX130.GlobalsToWatchI</IndexLocation>
<StreamLocation>^VX130.GlobalsToWatchS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
