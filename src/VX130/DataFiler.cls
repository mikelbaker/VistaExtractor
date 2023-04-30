Class VX130.DataFiler Extends %RegisteredObject
{

/// Description
ClassMethod FileRecords(pClassName As %String, pSta3n As %Integer) As %Status
{
    Set tSC = $$$OK
    Try {
        set tFilerHistory=##class(DataFilerHistory).%New()
        set tFilerHistory.ClassName=pClassName
        set tFilerHistory.Sta3n=pSta3n
        set tFilerHistory.StartDateTime=$ZDATETIME($ZTIMESTAMP,3)
        set tSC=tFilerHistory.%Save()
        quit:'tSC

        set (tFiled,tError)=0
        set tSQL="SELECT %NOLOCK ID FROM VX130.DataFilerQueue WHERE ClassName=? AND Sta3n=?"
        set tRSet=##class(%SQL.Statement).%ExecDirect(.tStatement,tSQL,pClassName,pSta3n)
        while tRSet.%Next() {
            set tID=tRSet.%Get("ID")
            set tDFQueue=##class(VX130.DataFilerQueue).%OpenId(tID,4,.tSC)
            quit:'tSC
            
            set tPrimaryKeys=tDFQueue.PrimaryKeys
            set tSC=$CLASSMETHOD(pClassName,"UpdateObject",pSta3n,tPrimaryKeys)
            if tSC {
                set tFiled=tFiled+1
                set tSC=##class(VX130.DataFilerQueue).%DeleteId(tID)
            } else {
                set tSC=$$$OK
                set tError=tError+1
            }
        }
        set tFilerHistory.EndDateTime=$ZDATETIME($ZTIMESTAMP,3)
        set tFilerHistory.NumberFiled=tFiled
        set tFilerHistory.NumberErrored=tError
        set tSC=tFilerHistory.%Save()
    }
    Catch ex {
        Set tSC=ex.AsStatus()
    }
    Return tSC
}

}
