docker exec -it v08 iris session iris -U VX130

Node: v08, Instance: IRIS

VX130>d ##class(CB.AttributeMap).New(376,"Dim.Race10v001")



SELECT 
ID, DataDomain, DataType, IRISClassName, IRISPropertyName, MaxLength, NumericScale, VistaField->VistaFieldNumber,VistaField->VistaFieldName, VistaFile->VistaFileNumber
FROM CB.AttributeMap


--UPDATE  CB.AttributeMap set IRISPropertyName='HL7Value' where ID=4
--UPDATE  CB.AttributeMap set IRISPropertyName='CDCValue' where ID=5
--UPDATE  CB.AttributeMap set IRISPropertyName='PTFValue' where ID=6

