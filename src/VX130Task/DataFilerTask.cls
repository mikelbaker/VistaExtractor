Class VX130Task.DataFilerTask Extends %SYS.Task.Definition
{

/// Code to run when the task is started.
Method OnTask() As %Status
{
    set tsc = $$$OK
    set tsc=##class(VX130.DataFilerHistory).StartFilers()
    return tsc
}

/// Code to set a the task to run every minute.
ClassMethod ScheduleEveryMinute() As %Status
{
    #Dim tTask As %SYS.Task
    Set tsc = $$$OK
    Try {
        set tName="VX130-DataFiler"
        &sql(SELECT ID INTO :tID FROM %SYS.Task WHERE Name=:tName)
        if $GET(tID) {
            set tsc=$SYSTEM.Status.Error(5001, tName_" Task already defined.","Did not add another." )
            quit
        }
        set tTask=##class(%SYS.Task).%New()
        set tTask.Name=tName
        set tTask.TaskClass=..%ClassName(1)
        set tTask.NameSpace=$NAMESPACE
        set tTask.DailyFrequency=tTask.DailyFrequencyDisplayToLogical("Several")
        set tTask.DailyFrequencyTime=0 // minutes
        set tTask.DailyIncrement=1 // every hour or minutes depending i=on DailyFrequencyTime
        set tTask.DailyStartTime=0
        set tTask.Expires=0
        set tTask.MirrorStatus=2
        set tTask.StartDate=+$HOROLOG
        set tTask.RunAsUser="_SYSTEM"
        set tsc=tTask.%Save()
        quit
    }
    Catch ex {
        Set tsc=ex.AsStatus()
    }
    Return tsc
}

}
