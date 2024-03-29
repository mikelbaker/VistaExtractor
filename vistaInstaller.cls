Include %occInclude

Class vista.Installer
{

XData vistaManifest [ XMLNamespace = INSTALLER ]
{
<Manifest>
   <SystemSetting Name="Config.config.MaxServers" Value="30" />
   <SystemSetting Name="Config.config.MaxServerConn" Value="30" />
   <SystemSetting Name="Config.Journal.CurrentDirectory" Value="/irisjrn/jrn" />
   <SystemSetting Name="Config.Journal.AlternateDirectory" Value="/irisjrn/alt" />
   <Namespace Name="VAH" Create="overwrite" Code="ROU" Data="ROU" Ensemble="0" >
     <Configuration>
       <Database Name="ROU" Dir="/irisdb/rou/" Create="overwrite" MountAtStartup="1" MountRequired="1" />
       <GlobalMapping Global="%Z*" From="ROU"/>
       <GlobalMapping Global="HLTMP" From="IRISTEMP"/>
       <GlobalMapping Global="TMP" From="IRISTEMP"/>
       <GlobalMapping Global="UTILITY" From="IRISTEMP"/>
       <GlobalMapping Global="XTMP" From="IRISTEMP"/>
       <GlobalMapping Global="XUTL" From="IRISTEMP"/>
       <RoutineMapping Routines="%DT*" Type="ALL" From="ROU" /> 
       <RoutineMapping Routines="%RCR" Type="ALL" From="ROU" /> 
       <RoutineMapping Routines="%XUCI" Type="ALL" From="ROU" /> 
       <RoutineMapping Routines="%Z*" Type="ALL" From="ROU" /> 
       <RoutineMapping Routines="%" Type="ALL" From="ROU" /> 
       <RoutineMapping Routines="%KIDS" Type="ALL" From="ROU" /> 
     </Configuration>
   </Namespace>
   <Namespace  Name="%SYS" Create="no" Code="IRISSYS" Data="IRISSYS"  >
     <Invoke Class="vista.Installer" Method="EnableMirrorService" CheckStatus="1" /> 
     <Invoke Class="vista.Installer" Method="CreateVISTAMirror" CheckStatus="1" /> 
   </Namespace>
</Manifest>
}

/// This is a method generator whose code is generated by XGL.
ClassMethod setup(ByRef pVars, pLogLevel As %Integer = 3, pInstaller As %Installer.Installer, pLogger As %Installer.AbstractLogger) As %Status [ CodeMode = objectgenerator, Internal ]
{
    #; Let our XGL document generate code for this method. 
    Quit ##class(%Installer.Manifest).%Generate(%compiledclass, %code, "vistaManifest")
}

/// Enable the Mirror Service for the VISTA system.
ClassMethod EnableMirrorService() As %Status
{
  set tsc = $$$OK
  try {
    set tService=##class(Security.Services).%OpenId("%service_mirror")
    if $ISOBJECT(tService) {
      set tService.Enabled=1
      set tsc=tService.%Save()
    }
  }
  catch ex {
    set tsc=ex.AsStatus()
  }
  return tsc
}

/// Create a Mirror for the VISTA System
ClassMethod CreateVISTAMirror() As %Status
{
  set tsc = $$$OK
  try {
    set tMirrorSetName=$SYSTEM.INetInfo.LocalHostName()
    set tMirrorSystemName=$REPLACE($SYSTEM,":","/")
    set tProperties("ArbiterNode")=""
    set tProperties("QOSTimeout")=8000
    set tProperties("UseSSL")=0
    set tProperties("VirtualAddress")=""
    set tProperties("CompressionForFailoverMembers")=0
    set tProperties("CompressionTypeForFailoverMembers")=0
    set tProperties("CompressionForAsyncMembers")=0
    set tProperties("CompressionTypeForAsyncMembers")=0
    set tProperties("AllowParallelDejournaling")=0
    set tProperties("MirrorAddress")=$SYSTEM.INetInfo.LocalHostName()
    set tProperties("AgentAddress")=$SYSTEM.INetInfo.LocalHostName()
    set tProperties("AgentPort")=2188
    
    set tsc=##class(SYS.Mirror).CreateNewMirrorSet(tMirrorSetName,tMirrorSystemName,.tProperties)
  }
  catch ex {
    set tsc=ex.AsStatus()
  }
  return tsc
}

}
