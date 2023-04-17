/// FileNumber: 2  File Name: PATIENT
/// 
/// File Description:
/// The PATIENT file contains all the patients followed by the medical center/
/// Outpatient clinic.  At a minimum each patient entry must have a NAME, DATE
/// OF BIRTH and SOCIAL SECURITY NUMBER.  In order to add a new patient to the
/// PATIENT file the user must also indicate whether or not the patient is
/// requesting to receive care as a VETERAN of the U.S. Armed Forces and
/// specify the TYPE of patient being added to the system.  For the most
/// part the information contained in this file is demographic in nature,
/// i.e., address, employment, service history, etc., however data
/// concerning admissions, appointments,etc., is also stored in this file.
/// The ADMISSION sub-field is scheduled to be moved into the new PATIENT
/// MOVEMENT file by the end of calendar year 1989.  Care should be used
/// when removing a patient from the PATIENT file since virtually all
/// other DHCP modules do utilize data from this file.  Of the many fields
/// in the file you will note that many are preceeded by an asterisk.
/// Those fields are scheduled to be removed from the file due to either
/// lack of use or replacement by another field/file in the next release.
/// 
Class SPatient.SPatient2v123 Extends %Persistent [ ClassType = persistent, Not ProcedureBlock, SqlRowIdPrivate, SqlTableName = SPatient_2_v123 ]
{

/// File Number: 2 Field Number :.32102
/// File Name: PATIENT Field Name: AGENT ORANGE EXPOS. INDICATED?
/// Field Type: SetOfCodes
/// Field Description:
/// For this veteran applicant enter 'Y' if s/he was exposed to the chemical
/// agent orange, 'N' if not, or 'U' if unknown.  Exposure cannot be claimed
/// unless the Period of Service (field .323) is answered VIETNAM ERA, which
/// entails those serving in the Korean DMZ between January 1, 1968 and
/// December 31, 1969 or Vietnam.
///  
/// Once the service record has been verified only users who hold the
/// designated security key may enter/edit this field.
/// 
Property AgentOrangeExposureFlag As %String(MAXLEN = 50) [ SqlFieldName = AgentOrangeExposureFlag ];

/// File Number: 2 Field Number :.32102
/// File Name: PATIENT Field Name: AGENT ORANGE EXPOS. INDICATED?
/// Field Type: SetOfCodes
/// Field Description:
/// For this veteran applicant enter 'Y' if s/he was exposed to the chemical
/// agent orange, 'N' if not, or 'U' if unknown.  Exposure cannot be claimed
/// unless the Period of Service (field .323) is answered VIETNAM ERA, which
/// entails those serving in the Korean DMZ between January 1, 1968 and
/// December 31, 1969 or Vietnam.
///  
/// Once the service record has been verified only users who hold the
/// designated security key may enter/edit this field.
/// 
Property AgentOrangeExposureFlagCode As %String(MAXLEN = 50) [ SqlFieldName = AgentOrangeExposureFlagCode ];

/// File Number: 2 Field Number :.3213
/// File Name: PATIENT Field Name: AGENT ORANGE EXPOSURE LOCATION
/// Field Type: SetOfCodes
/// Field Description:
/// For this veteran applicant who was exposed to agent orange (EXPOSED TO
/// AGENT ORANGE prompt must be answered YES) enter the location where the
/// exposure occurred.  Once the service record has been verified only users
/// who hold the designated security key may enter/edit this field.  This
/// field cannot be deleted as long as agent orange exposure is indicated.
/// 
Property AgentOrangeLocationCode As %String(MAXLEN = 50) [ SqlFieldName = AgentOrangeLocationCode ];

/// File Number: 2 Field Number :.3213
/// File Name: PATIENT Field Name: AGENT ORANGE EXPOSURE LOCATION
/// Field Type: SetOfCodes
/// Field Description:
/// For this veteran applicant who was exposed to agent orange (EXPOSED TO
/// AGENT ORANGE prompt must be answered YES) enter the location where the
/// exposure occurred.  Once the service record has been verified only users
/// who hold the designated security key may enter/edit this field.  This
/// field cannot be deleted as long as agent orange exposure is indicated.
/// 
Property AgentOrangeLocationCodeCode As %String(MAXLEN = 50) [ SqlFieldName = AgentOrangeLocationCodeCode ];

/// File Number: 2 Field Number :.121
/// File Name: PATIENT Field Name: BAD ADDRESS INDICATOR
/// Field Type: SetOfCodes
/// Field Description:
/// The Bad Address Indicator field applies to the address at which the patient
/// resides.  This field should be set as follows (if applicable):
///  
///     "UNDELIVERABLE" - Bad Address based on returned mail.
///     "HOMELESS" - Patient is known to be homeless.
///     "OTHER" - Other Bad Address Reason
///  
/// Setting this field will prevent a Bad Address from being shared with HEC
/// and other VAMC facilities.
///  
///  
/// Once the Bad Address Indicator is set, incoming "newer" addresses will
/// automatically remove the Bad Address Indicator, and allow the "updated"
/// address to be transmitted to HEC and other VAMC facilities. To manually
/// remove the Bad Address Indicator enter the "@" symbol.
/// 
Property BadAddressIndicator As %String(MAXLEN = 50) [ SqlFieldName = BadAddressIndicator ];

/// File Number: 2 Field Number :.121
/// File Name: PATIENT Field Name: BAD ADDRESS INDICATOR
/// Field Type: SetOfCodes
/// Field Description:
/// The Bad Address Indicator field applies to the address at which the patient
/// resides.  This field should be set as follows (if applicable):
///  
///     "UNDELIVERABLE" - Bad Address based on returned mail.
///     "HOMELESS" - Patient is known to be homeless.
///     "OTHER" - Other Bad Address Reason
///  
/// Setting this field will prevent a Bad Address from being shared with HEC
/// and other VAMC facilities.
///  
///  
/// Once the Bad Address Indicator is set, incoming "newer" addresses will
/// automatically remove the Bad Address Indicator, and allow the "updated"
/// address to be transmitted to HEC and other VAMC facilities. To manually
/// remove the Bad Address Indicator enter the "@" symbol.
/// 
Property BadAddressIndicatorCode As %String(MAXLEN = 50) [ SqlFieldName = BadAddressIndicatorCode ];

/// File Number: 2 Field Number :.03
/// File Name: PATIENT Field Name: DATE OF BIRTH
/// Field Type: DateTime
/// Field Description:
/// Enter the patient's DATE OF BIRTH which must be later than 12/31/1870.  
/// DATE OF BIRTH cannot be a date after the beneficiary 'Ineligible Date' 
/// or a date after the 'Enrollment Application Date'.
/// 
Property BirthDateTime As %FilemanTimeStamp [ SqlFieldName = BirthDateTime ];

/// File Number: 2 Field Number :.03
/// File Name: PATIENT Field Name: DATE OF BIRTH
/// Field Type: DateTime
/// Field Description:
/// Enter the patient's DATE OF BIRTH which must be later than 12/31/1870.  
/// DATE OF BIRTH cannot be a date after the beneficiary 'Ineligible Date' 
/// or a date after the 'Enrollment Application Date'.
/// 
Property BirthFMDate As %String(MAXLEN = 50) [ SqlFieldName = BirthFMDate ];

/// File Number: 2 Field Number :.114
/// File Name: PATIENT Field Name: CITY
/// Field Type: FreeText
/// Field Description:
/// Enter the city in which this applicant resides [2-15 characters].
/// If the space provided is not sufficient please abbreviate the
/// city to the best of your ability.
/// 
Property City As %String(MAXLEN = 50) [ SqlFieldName = City ];

/// File Number: 2 Field Number :.3601
/// File Name: PATIENT Field Name: COLLATERAL SPONSOR'S NAME
/// Field Type: Pointer PointsToFileNumber: 2
/// Field Description:
/// If this patient is a collateral responsible for picking up medications
/// or information regarding another patient, that patient's name should be 
/// entered here.
///  
/// This sponsor must be a veteran and must exist in the patient file.
/// 
Property CollateralSponsorPatientIEN As %String(MAXLEN = 50) [ SqlFieldName = CollateralSponsorPatientIEN ];

/// File Number: 2 Field Number :.5295
/// File Name: PATIENT Field Name: COMBAT VETERAN END DATE
/// Field Type: DateTime
/// Field Description:
/// This field represents the last day for combat vet eligibility. This field 
/// will only be populated by cross-reference when the veteran's combat vet 
/// eligibility has been determined. This value will remain after the combat 
/// vet eligibility period has expired.
/// 
Property CombatEligibilityEndDate As %FilemanDate [ SqlFieldName = CombatEligibilityEndDate ];

/// File Number: 2 Field Number :.5295
/// File Name: PATIENT Field Name: COMBAT VETERAN END DATE
/// Field Type: DateTime
/// Field Description:
/// This field represents the last day for combat vet eligibility. This field 
/// will only be populated by cross-reference when the veteran's combat vet 
/// eligibility has been determined. This value will remain after the combat 
/// vet eligibility period has expired.
/// 
Property CombatEligibilityEndFMDate As %String(MAXLEN = 50) [ SqlFieldName = CombatEligibilityEndFMDate ];

/// File Number: 2 Field Number :.5291
/// File Name: PATIENT Field Name: COMBAT SERVICE INDICATED?
/// Field Type: SetOfCodes
/// Field Description:
/// For this veteran applicant enter 'Y' if s/he served in a combat
/// zone, or 'N' if not.  Once the service record is verified only
/// users who hold the designated security key may enter/edit this
/// field.
/// 
Property CombatFlag As %String(MAXLEN = 50) [ SqlFieldName = CombatFlag ];

/// File Number: 2 Field Number :.5291
/// File Name: PATIENT Field Name: COMBAT SERVICE INDICATED?
/// Field Type: SetOfCodes
/// Field Description:
/// For this veteran applicant enter 'Y' if s/he served in a combat
/// zone, or 'N' if not.  Once the service record is verified only
/// users who hold the designated security key may enter/edit this
/// field.
/// 
Property CombatFlagCode As %String(MAXLEN = 50) [ SqlFieldName = CombatFlagCode ];

/// File Number: 2 Field Number :.5293
/// File Name: PATIENT Field Name: COMBAT FROM DATE
/// Field Type: DateTime
/// Field Description:
/// For this veteran who served in a combat zone (IN COMBAT prompt
/// must be answered YES) enter the date on which combat service
/// commenced.  Once the service record is
/// verified only those users who hold the designated security key
/// may enter/edit this field.  This field cannot be deleted as long
/// as combat service is indicated.
/// 
Property CombatFromDate As %FilemanDate [ SqlFieldName = CombatFromDate ];

/// File Number: 2 Field Number :.5293
/// File Name: PATIENT Field Name: COMBAT FROM DATE
/// Field Type: DateTime
/// Field Description:
/// For this veteran who served in a combat zone (IN COMBAT prompt
/// must be answered YES) enter the date on which combat service
/// commenced.  Once the service record is
/// verified only those users who hold the designated security key
/// may enter/edit this field.  This field cannot be deleted as long
/// as combat service is indicated.
/// 
Property CombatFromFMDate As %String(MAXLEN = 50) [ SqlFieldName = CombatFromFMDate ];

/// File Number: 2 Field Number :.5294
/// File Name: PATIENT Field Name: COMBAT TO DATE
/// Field Type: DateTime
/// Field Description:
/// For this veteran who served in a combat zone (IN COMBAT prompt must
/// be answered YES) enter the date on which combat service ended.
/// Once the service record is verified
/// only those users who hold the designated security key may
/// enter/edit this field.  This field cannot be deleted as long as
/// combat service is indicated.
/// 
Property CombatToDate As %FilemanDate [ SqlFieldName = CombatToDate ];

/// File Number: 2 Field Number :.5294
/// File Name: PATIENT Field Name: COMBAT TO DATE
/// Field Type: DateTime
/// Field Description:
/// For this veteran who served in a combat zone (IN COMBAT prompt must
/// be answered YES) enter the date on which combat service ended.
/// Once the service record is verified
/// only those users who hold the designated security key may
/// enter/edit this field.  This field cannot be deleted as long as
/// combat service is indicated.
/// 
Property CombatToFMDate As %String(MAXLEN = 50) [ SqlFieldName = CombatToFMDate ];

/// File Number: 2 Field Number :27.01
/// File Name: PATIENT Field Name: CURRENT ENROLLMENT
/// Field Type: Pointer PointsToFileNumber: 27.11
/// Field Description:
/// The patient's current enrollment.
/// 
Property CurrentEnrollmentIEN As %String(MAXLEN = 50) [ SqlFieldName = CurrentEnrollmentIEN ];

/// File Number: 2 Field Number :.14
/// File Name: PATIENT Field Name: CURRENT MEANS TEST STATUS
/// Field Type: Pointer PointsToFileNumber: 408.32
/// Field Description:
/// This field is computed by the system.  It contains the current
/// means test status for a patient.
/// 
Property CurrentMeansTestStatusIEN As %String(MAXLEN = 50) [ SqlFieldName = CurrentMeansTestStatusIEN ];

/// File Number: 2 Field Number :.351
/// File Name: PATIENT Field Name: DATE OF DEATH
/// Field Type: DateTime
/// Field Description:
/// Enter the date the patient died.  Date needs to be a precise date, i.e. 
/// a day, month, and year MUST be included.
/// Date of Death can not be prior to
///         P&T Effective Date
///         Date Ruled Incompetent (Civil and VA)
///         Date of Birth
/// 
Property DeathDateTime As %FilemanTimeStamp [ SqlFieldName = DeathDateTime ];

/// File Number: 2 Field Number :.357
/// File Name: PATIENT Field Name: SUPPORTING DOCUMENT TYPE
/// Field Type: Pointer PointsToFileNumber: 47.75
/// Field Description:
/// The Supporting Document Type selected from the available list identifies 
/// the current method of how the site was notified of a patient's death.
/// 
Property DeathDocumentationType As %String(MAXLEN = 100) [ SqlFieldName = DeathDocumentationType ];

/// File Number: 2 Field Number :.352
/// File Name: PATIENT Field Name: DEATH ENTERED BY
/// Field Type: Pointer PointsToFileNumber: 200
/// Field Description:
/// This field records the date a patient's death was initially entered into
/// the DHCP system.  This field is created automatically by the MAS module
/// when a date of death is entered either through the 'Death Entry' option or
/// through the 'Discharge a Patient' option.
/// 
Property DeathEnteredByStaffIEN As %String(MAXLEN = 50) [ SqlFieldName = DeathEnteredByStaffIEN ];

/// File Number: 2 Field Number :.351
/// File Name: PATIENT Field Name: DATE OF DEATH
/// Field Type: DateTime
/// Field Description:
/// Enter the date the patient died.  Date needs to be a precise date, i.e. 
/// a day, month, and year MUST be included.
/// Date of Death can not be prior to
///         P&T Effective Date
///         Date Ruled Incompetent (Civil and VA)
///         Date of Birth
/// 
Property DeathFMDate As %String(MAXLEN = 50) [ SqlFieldName = DeathFMDate ];

/// File Number: 2 Field Number :.355
/// File Name: PATIENT Field Name: LAST EDITED BY
/// Field Type: Pointer PointsToFileNumber: 200
/// Field Description:
/// This is the local user ID of the person that last made a modification to 
/// the date of death (.351) field.
/// 
Property DeathLastUpdatedByStaffIEN As %String(MAXLEN = 50) [ SqlFieldName = DeathLastUpdatedByStaffIEN ];

/// File Number: 2 Field Number :.354
/// File Name: PATIENT Field Name: DATE OF DEATH LAST UPDATED
/// Field Type: DateTime
/// Field Description:
/// This is a date/time value that represents the date/time the date of death 
/// field (.351) was last modified/entered/deleted.
/// 
Property DeathModifiedDateTime As %FilemanTimeStamp [ SqlFieldName = DeathModifiedDateTime ];

/// File Number: 2 Field Number :.354
/// File Name: PATIENT Field Name: DATE OF DEATH LAST UPDATED
/// Field Type: DateTime
/// Field Description:
/// This is a date/time value that represents the date/time the date of death 
/// field (.351) was last modified/entered/deleted.
/// 
Property DeathModifiedFMDate As %String(MAXLEN = 50) [ SqlFieldName = DeathModifiedFMDate ];

/// File Number: 2 Field Number :.353
/// File Name: PATIENT Field Name: SOURCE OF NOTIFICATION
/// Field Type: Pointer PointsToFileNumber: 47.76
/// Field Description:
/// SOURCE OF NOTIFICATION represents who/what notified the VA of the 
/// patient's DATE OF DEATH.
/// 
Property DeathNotificationSource As %String(MAXLEN = 50) [ SqlFieldName = DeathNotificationSource ];

/// File Number: 2 Field Number :.082
/// File Name: PATIENT Field Name: PATIENT MERGED TO
/// Field Type: Pointer PointsToFileNumber: 2
/// Field Description:
/// This field is currently not being utilized.  It will be active when
/// Patient Merge/Purge options are available to the user.  Patient Merged
/// To: field will be defined at that time.
/// |
/// 
Property DestinationMergePatientIEN As %String(MAXLEN = 50) [ SqlFieldName = DestinationMergePatientIEN ];

/// File Number: 2 Field Number :.081
/// File Name: PATIENT Field Name: DUPLICATE STATUS
/// Field Type: SetOfCodes
/// Field Description:
/// This field is currently not being utilized.  It will be active when
/// Patient Merge/Purge options are available to the user.  Duplicate
/// Status field will be defined at that time.
/// |
/// 
Property DuplicateRecordStatus As %String(MAXLEN = 50) [ SqlFieldName = DuplicateRecordStatus ];

/// File Number: 2 Field Number :.081
/// File Name: PATIENT Field Name: DUPLICATE STATUS
/// Field Type: SetOfCodes
/// Field Description:
/// This field is currently not being utilized.  It will be active when
/// Patient Merge/Purge options are available to the user.  Duplicate
/// Status field will be defined at that time.
/// |
/// 
Property DuplicateRecordStatusCode As %String(MAXLEN = 50) [ SqlFieldName = DuplicateRecordStatusCode ];

/// File Number: 2 Field Number :.3616
/// File Name: PATIENT Field Name: ELIGIBILITY STATUS ENTERED BY
/// Field Type: Pointer PointsToFileNumber: 200
/// Field Description:
/// When eligibility is verified (ELIG STATUS="VERIFIED") the name of the
/// user who certified the verification.
/// 
Property EligibilityEnteredStaffIEN As %String(MAXLEN = 50) [ SqlFieldName = EligibilityEnteredStaffIEN ];

/// File Number: 2 Field Number :.361
/// File Name: PATIENT Field Name: PRIMARY ELIGIBILITY CODE
/// Field Type: Pointer PointsToFileNumber: 8
/// Field Description:
/// Select from the available listing the appropriate eligibility code for
/// this applicant.  For non-veteran applicants a wide variety of choices
/// are available.  For veteran applicants the choices are screened [in the
/// following order] dependent on the responses to other prompts:
///    
/// 1.  If the SERVICE CONNECTED prompt (field .301) is answered YES
///     only the following two choices are available:
///     
///     a.  If the SERVICE CONNECTED PERCENTAGE prompt (field .302) entered
///         is 50% or greater 'SERVICE CONNECTED 50% TO 100%' can be
///         selected.
///    
///     b.  Otherwise, the percentage is assumed to be less than 50% and
///         only 'SC, LESS THAN 50%' may be entered.
///    
/// 2.  If the response to the WERE YOU A PRISONER OF WAR field (# .525)
///     is YES and the veteran is not service connected, you must select 
///     PRISONER OF WAR as the eligibility code.
///    
/// 3.  If the response to the CURRENT PH INDICATOR field (#.531) 
///     is YES and the veteran is not service connected and is not a Prisoner
///     of War, you must select PURPLE HEART RECIPIENT as the eligibility code.
///  
/// 4.  If the veteran is receiving VA benefits, but does not meet the
///     criteria in items 1 and 2 above, then the following choices may
///     be presented for selection:
///  
///     If RECEIVING A&A BENEFITS is answered YES, the eligibility code
///     AID & ATTENDANCE may be selected.
///  
///     If the RECEIVING HOUSEBOUND BENEFITS is answered YES ,the eligibility
///     code HOUSEBOUND may be selected.
///  
///     If the above two prompts were answered NO, but the RECEIVING A VA
///     PENSION prompt was answered YES, only the NSC, VA PENSION prompt
///     may be selected.
///  
/// 5.  If none of the above pertain to this veteran, then the NSC eligibility
///     will be available for selection.
///  
/// **  Dependent on the birthdate of the applicant, the following two
///     eligibility codes may be displayed along with those shown in items
///     3 through 5 above:  WORLD WAR I and MEXICAN BORDER WAR.  These would
///     display for veterans not meeting the criteria in items 1 and 2, but
///     whose date of birth is prior to 1907.
/// 
Property EligibilityIEN As %String(MAXLEN = 50) [ SqlFieldName = EligibilityIEN ];

/// File Number: 2 Field Number :.3614
/// File Name: PATIENT Field Name: ELIGIBILITY INTERIM RESPONSE
/// Field Type: DateTime
/// Field Description:
/// If an interim response has been received concerning this applicant's
/// eligibility status enter the date received.  Only users who hold the
/// designated security key may enter/edit this field.
/// 
Property EligibilityInterimDateTime As %FilemanTimeStamp [ SqlFieldName = EligibilityInterimDateTime ];

/// File Number: 2 Field Number :.3614
/// File Name: PATIENT Field Name: ELIGIBILITY INTERIM RESPONSE
/// Field Type: DateTime
/// Field Description:
/// If an interim response has been received concerning this applicant's
/// eligibility status enter the date received.  Only users who hold the
/// designated security key may enter/edit this field.
/// 
Property EligibilityInterimFMDate As %String(MAXLEN = 50) [ SqlFieldName = EligibilityInterimFMDate ];

/// File Number: 2 Field Number :.3611
/// File Name: PATIENT Field Name: ELIGIBILITY STATUS
/// Field Type: SetOfCodes
/// Field Description:
/// Select from the available listing the appropriate eligibility status
/// for this applicant.  Only users who hold the designated security key
/// may enter/edit this field.
/// 
Property EligibilityStatus As %String(MAXLEN = 50) [ SqlFieldName = EligibilityStatus ];

/// File Number: 2 Field Number :.3611
/// File Name: PATIENT Field Name: ELIGIBILITY STATUS
/// Field Type: SetOfCodes
/// Field Description:
/// Select from the available listing the appropriate eligibility status
/// for this applicant.  Only users who hold the designated security key
/// may enter/edit this field.
/// 
Property EligibilityStatusCode As %String(MAXLEN = 50) [ SqlFieldName = EligibilityStatusCode ];

/// File Number: 2 Field Number :.3612
/// File Name: PATIENT Field Name: ELIGIBILITY STATUS DATE
/// Field Type: DateTime
/// Field Description:
/// Enter the effective date of the eligibility status (ELIG STATUS
/// prompt).  Only users who hold the designated security key may
/// enter/edit this field.
/// 
Property EligibilityStatusDateTime As %FilemanTimeStamp [ SqlFieldName = EligibilityStatusDateTime ];

/// File Number: 2 Field Number :.3612
/// File Name: PATIENT Field Name: ELIGIBILITY STATUS DATE
/// Field Type: DateTime
/// Field Description:
/// Enter the effective date of the eligibility status (ELIG STATUS
/// prompt).  Only users who hold the designated security key may
/// enter/edit this field.
/// 
Property EligibilityStatusFMDate As %String(MAXLEN = 50) [ SqlFieldName = EligibilityStatusFMDate ];

/// File Number: 2 Field Number :.361
/// File Name: PATIENT Field Name: PRIMARY ELIGIBILITY CODE
/// Field Type: Pointer PointsToFileNumber: 8
/// Field Description:
/// Select from the available listing the appropriate eligibility code for
/// this applicant.  For non-veteran applicants a wide variety of choices
/// are available.  For veteran applicants the choices are screened [in the
/// following order] dependent on the responses to other prompts:
///    
/// 1.  If the SERVICE CONNECTED prompt (field .301) is answered YES
///     only the following two choices are available:
///     
///     a.  If the SERVICE CONNECTED PERCENTAGE prompt (field .302) entered
///         is 50% or greater 'SERVICE CONNECTED 50% TO 100%' can be
///         selected.
///    
///     b.  Otherwise, the percentage is assumed to be less than 50% and
///         only 'SC, LESS THAN 50%' may be entered.
///    
/// 2.  If the response to the WERE YOU A PRISONER OF WAR field (# .525)
///     is YES and the veteran is not service connected, you must select 
///     PRISONER OF WAR as the eligibility code.
///    
/// 3.  If the response to the CURRENT PH INDICATOR field (#.531) 
///     is YES and the veteran is not service connected and is not a Prisoner
///     of War, you must select PURPLE HEART RECIPIENT as the eligibility code.
///  
/// 4.  If the veteran is receiving VA benefits, but does not meet the
///     criteria in items 1 and 2 above, then the following choices may
///     be presented for selection:
///  
///     If RECEIVING A&A BENEFITS is answered YES, the eligibility code
///     AID & ATTENDANCE may be selected.
///  
///     If the RECEIVING HOUSEBOUND BENEFITS is answered YES ,the eligibility
///     code HOUSEBOUND may be selected.
///  
///     If the above two prompts were answered NO, but the RECEIVING A VA
///     PENSION prompt was answered YES, only the NSC, VA PENSION prompt
///     may be selected.
///  
/// 5.  If none of the above pertain to this veteran, then the NSC eligibility
///     will be available for selection.
///  
/// **  Dependent on the birthdate of the applicant, the following two
///     eligibility codes may be displayed along with those shown in items
///     3 through 5 above:  WORLD WAR I and MEXICAN BORDER WAR.  These would
///     display for veterans not meeting the criteria in items 1 and 2, but
///     whose date of birth is prior to 1907.
/// 
Property EligibilityVACode As %String(MAXLEN = 50) [ SqlFieldName = EligibilityVACode ];

/// File Number: 2 Field Number :.3615
/// File Name: PATIENT Field Name: ELIGIBILITY VERIF. METHOD
/// Field Type: FreeText
/// Field Description:
/// Enter the method in which the eligibility for this applicant was verified
/// [between 2-50 characters].  Only users who hold the designated security
/// key may enter/edit this field.
/// 
Property EligibilityVerificationMethod As %String(MAXLEN = 50) [ SqlFieldName = EligibilityVerificationMethod ];

/// File Number: 2 Field Number :.3613
/// File Name: PATIENT Field Name: ELIGIBILITY VERIF. SOURCE
/// Field Type: SetOfCodes
/// Field Description:
/// This field is used to restrict site ability to edit certain data elements when
/// HEC has verified eligibility data.
/// 
Property EligibilityVerificationSource As %String(MAXLEN = 50) [ SqlFieldName = EligibilityVerificationSource ];

/// File Number: 2 Field Number :.3613
/// File Name: PATIENT Field Name: ELIGIBILITY VERIF. SOURCE
/// Field Type: SetOfCodes
/// Field Description:
/// This field is used to restrict site ability to edit certain data elements when
/// HEC has verified eligibility data.
/// 
Property EligibilityVerificationSourceCode As %String(MAXLEN = 50) [ SqlFieldName = EligibilityVerificationSourceCode ];

/// File Number: 2 Field Number :.181
/// File Name: PATIENT Field Name: EMERGENCY RESPONSE INDICATOR
/// Field Type: SetOfCodes
/// Field Description:
/// Enter the appropriate ER Indicator to identify patients from impacted
/// zip code areas designated by FEMA.
/// 
Property EmergencyResponseIndicator As %String(MAXLEN = 50) [ SqlFieldName = EmergencyResponseIndicator ];

/// File Number: 2 Field Number :.181
/// File Name: PATIENT Field Name: EMERGENCY RESPONSE INDICATOR
/// Field Type: SetOfCodes
/// Field Description:
/// Enter the appropriate ER Indicator to identify patients from impacted
/// zip code areas designated by FEMA.
/// 
Property EmergencyResponseIndicatorCode As %String(MAXLEN = 50) [ SqlFieldName = EmergencyResponseIndicatorCode ];

/// File Number: 2 Field Number :1100.03
/// File Name: PATIENT Field Name: FFF DATE ENTERED
/// Field Type: DateTime
/// Field Description:
/// Date/Time the FUGITIVE FELON FLAG field (#1100.01) was entered.  This 
/// field is automatically set when the FUGITIVE FELON FLAG field (#1100.01)
/// is set.
/// 
Property FFFEnteredDateTime As %FilemanTimeStamp [ SqlFieldName = FFFEnteredDateTime ];

/// File Number: 2 Field Number :1100.03
/// File Name: PATIENT Field Name: FFF DATE ENTERED
/// Field Type: DateTime
/// Field Description:
/// Date/Time the FUGITIVE FELON FLAG field (#1100.01) was entered.  This 
/// field is automatically set when the FUGITIVE FELON FLAG field (#1100.01)
/// is set.
/// 
Property FFFEnteredFMDate As %String(MAXLEN = 50) [ SqlFieldName = FFFEnteredFMDate ];

/// File Number: 2 Field Number :1100.02
/// File Name: PATIENT Field Name: FFF ENTERED BY
/// Field Type: Pointer PointsToFileNumber: 200
/// Field Description:
/// This field contains the user who entered the current Fugtitive Felon Flag
/// for this patient.  It is automatically entered when the FUGITIVE FELON
/// FLAG field (#1100.01) is entered.
/// 
Property FFFEnteredStaffIEN As %String(MAXLEN = 50) [ SqlFieldName = FFFEnteredStaffIEN ];

/// File Number: 2 Field Number :1100.05
/// File Name: PATIENT Field Name: FFF DATE REMOVED
/// Field Type: DateTime
/// Field Description:
/// Date/Time the FUGITIVE FELON FLAG Field (#1100.01) was removed.  This 
/// field is automatically set when the FUGITIVE FELON FLAG field (#1100.01)
/// is deleted.
/// 
Property FFFRemovedDateTime As %FilemanTimeStamp [ SqlFieldName = FFFRemovedDateTime ];

/// File Number: 2 Field Number :1100.05
/// File Name: PATIENT Field Name: FFF DATE REMOVED
/// Field Type: DateTime
/// Field Description:
/// Date/Time the FUGITIVE FELON FLAG Field (#1100.01) was removed.  This 
/// field is automatically set when the FUGITIVE FELON FLAG field (#1100.01)
/// is deleted.
/// 
Property FFFRemovedFMDate As %String(MAXLEN = 50) [ SqlFieldName = FFFRemovedFMDate ];

/// File Number: 2 Field Number :1100.09
/// File Name: PATIENT Field Name: FFF REMOVAL REMARKS
/// Field Type: FreeText
/// Field Description:
/// If the FFF flag has been cleared for this patient, this field contains a short reason as to why the flag was cleared.  This is a free text field which allows up to 80 characters to be entered.
/// 
Property FFFRemovedReason As %String(MAXLEN = 100) [ SqlFieldName = FFFRemovedReason ];

/// File Number: 2 Field Number :1100.04
/// File Name: PATIENT Field Name: FFF REMOVED BY
/// Field Type: Pointer PointsToFileNumber: 200
/// Field Description:
/// This field contains the user who removed the current Fugitive Felon Flag
/// for this patient.  It is automatically entered when the FUGITIVE FELON FLAG
/// field (#1100.01) is deleted.
/// 
Property FFFRemovedStaffIEN As %String(MAXLEN = 50) [ SqlFieldName = FFFRemovedStaffIEN ];

/// File Number: 2 Field Number :.309
/// File Name: PATIENT Field Name: AGENCY/ALLIED COUNTRY
/// Field Type: Pointer PointsToFileNumber: 35
/// Field Description:
/// For this applicant whose eligibility code is either 'OTHER FEDERAL
/// AGENCY' or 'ALLIED VETERAN' select from the available listing
/// the federal agency or allied country, as appropriate, which best
/// classifies this applicant.
/// 
Property FederalAgencyIEN As %String(MAXLEN = 50) [ SqlFieldName = FederalAgencyIEN ];

/// File Number: 2 Field Number :.3214
/// File Name: PATIENT Field Name: FILIPINO VETERAN PROOF
/// Field Type: SetOfCodes
/// Field Description:
/// Enter in this field the documentation that was provided in order to
/// establish US citizenship, lawful permanent US residency, and/or VA
/// Compensation at full-dollar rate for a Filipino Veteran (i.e., a 
/// veteran whose Branch of Service is F. Commonwealth, F. Guerilla, or F.
/// Scouts New)
/// 
Property FilipinoVeteranCode As %String(MAXLEN = 50) [ SqlFieldName = FilipinoVeteranCode ];

/// File Number: 2 Field Number :.3214
/// File Name: PATIENT Field Name: FILIPINO VETERAN PROOF
/// Field Type: SetOfCodes
/// Field Description:
/// Enter in this field the documentation that was provided in order to
/// establish US citizenship, lawful permanent US residency, and/or VA
/// Compensation at full-dollar rate for a Filipino Veteran (i.e., a 
/// veteran whose Branch of Service is F. Commonwealth, F. Guerilla, or F.
/// Scouts New)
/// 
Property FilipinoVeteranCodeCode As %String(MAXLEN = 50) [ SqlFieldName = FilipinoVeteranCodeCode ];

/// File Number: 2 Field Number :1100.01
/// File Name: PATIENT Field Name: FUGITIVE FELON FLAG
/// Field Type: SetOfCodes
/// Field Description:
/// This field is in support of Pub. L. 107-103, section 505, and is used to 
/// flag a patient who has a fugitive felon warrant outstanding.  This 
/// information will be provided to the appropriate personnel to enter.  
/// Access to this field requires the DGFFP ACCESS key.  This field should 
/// not be updated directly, but should be entered through the appropriate 
/// Fugitive Felon Program options.
/// 
Property FugitiveFelonFlag As %String(MAXLEN = 50) [ SqlFieldName = FugitiveFelonFlag ];

/// File Number: 2 Field Number :1100.01
/// File Name: PATIENT Field Name: FUGITIVE FELON FLAG
/// Field Type: SetOfCodes
/// Field Description:
/// This field is in support of Pub. L. 107-103, section 505, and is used to 
/// flag a patient who has a fugitive felon warrant outstanding.  This 
/// information will be provided to the appropriate personnel to enter.  
/// Access to this field requires the DGFFP ACCESS key.  This field should 
/// not be updated directly, but should be entered through the appropriate 
/// Fugitive Felon Program options.
/// 
Property FugitiveFelonFlagCode As %String(MAXLEN = 50) [ SqlFieldName = FugitiveFelonFlagCode ];

/// File Number: 2 Field Number :.02
/// File Name: PATIENT Field Name: SEX
/// Field Type: SetOfCodes
/// Field Description:
/// Enter 'M' if this applicant is a male, or 'F' if female.
/// 
Property Gender As %String(MAXLEN = 50) [ SqlFieldName = Gender ];

/// File Number: 2 Field Number :.02
/// File Name: PATIENT Field Name: SEX
/// Field Type: SetOfCodes
/// Field Description:
/// Enter 'M' if this applicant is a male, or 'F' if female.
/// 
Property GenderCode As %String(MAXLEN = 50) [ SqlFieldName = GenderCode ];

/// File Number: 2 Field Number :.3112
/// File Name: PATIENT Field Name: GOVERNMENT AGENCY
/// Field Type: SetOfCodes
/// Field Description:
/// If this patient is currently employed by a government agency, respond yes
/// to this question.  If the patient is employed by the private sector or
/// currently is unemployed, respond no.
/// 
Property GovernmentEmployeeFlag As %String(MAXLEN = 50) [ SqlFieldName = GovernmentEmployeeFlag ];

/// File Number: 2 Field Number :.3112
/// File Name: PATIENT Field Name: GOVERNMENT AGENCY
/// Field Type: SetOfCodes
/// Field Description:
/// If this patient is currently employed by a government agency, respond yes
/// to this question.  If the patient is employed by the private sector or
/// currently is unemployed, respond no.
/// 
Property GovernmentEmployeeFlagCode As %String(MAXLEN = 50) [ SqlFieldName = GovernmentEmployeeFlagCode ];

/// File Number: 2 Field Number :.1653
/// File Name: PATIENT Field Name: INELIGIBLE TWX CITY
/// Field Type: FreeText
/// Field Description:
/// Enter the city from which the TWX which informed you this applicant
/// was ineligible for treatment originated [3-30 characters].  An ineligible
/// date must be specified in order to enter/edit this field and the user
/// must hold the designated security key.  This field may not be deleted
/// as long as an ineligible date is on file.
/// 
Property IneligibleCity As %String(MAXLEN = 50) [ SqlFieldName = IneligibleCity ];

/// File Number: 2 Field Number :.152
/// File Name: PATIENT Field Name: INELIGIBLE DATE
/// Field Type: DateTime
/// Field Description:
/// If this applicant is ineligible for treatment enter the effective date.
/// Only users who hold the designated security key may enter/edit this
/// field.  The Ineligible Date cannot be prior to the beneficiary Date of 
/// Birth.
/// 
Property IneligibleDateTime As %FilemanTimeStamp [ SqlFieldName = IneligibleDateTime ];

/// File Number: 2 Field Number :.152
/// File Name: PATIENT Field Name: INELIGIBLE DATE
/// Field Type: DateTime
/// Field Description:
/// If this applicant is ineligible for treatment enter the effective date.
/// Only users who hold the designated security key may enter/edit this
/// field.  The Ineligible Date cannot be prior to the beneficiary Date of 
/// Birth.
/// 
Property IneligibleFMDate As %String(MAXLEN = 50) [ SqlFieldName = IneligibleFMDate ];

/// File Number: 2 Field Number :.307
/// File Name: PATIENT Field Name: INELIGIBLE REASON
/// Field Type: FreeText
/// Field Description:
/// If this applicant is ineligible for treatment enter the reason
/// [not to exceed 40 characters].  An ineligible date must be specified
/// in order to enter/edit this field and the user must hold the
/// designated security key.  This field may not be deleted as long as
/// an ineligible date is on file.
/// 
Property IneligibleReason As %String(MAXLEN = 50) [ SqlFieldName = IneligibleReason ];

/// File Number: 2 Field Number :.1651
/// File Name: PATIENT Field Name: INELIGIBLE TWX SOURCE
/// Field Type: SetOfCodes
/// Field Description:
/// Choose from the available listing the source of the TWX which
/// informed you that this applicant was ineligible for treatment.
/// An ineligible date must be specified in order to enter/edit this
/// field and the user must hold the designated security key.  This
/// field may not be deleted as long as an ineligible date is on file.
/// 
Property IneligibleSource As %String(MAXLEN = 50) [ SqlFieldName = IneligibleSource ];

/// File Number: 2 Field Number :.1651
/// File Name: PATIENT Field Name: INELIGIBLE TWX SOURCE
/// Field Type: SetOfCodes
/// Field Description:
/// Choose from the available listing the source of the TWX which
/// informed you that this applicant was ineligible for treatment.
/// An ineligible date must be specified in order to enter/edit this
/// field and the user must hold the designated security key.  This
/// field may not be deleted as long as an ineligible date is on file.
/// 
Property IneligibleSourceCode As %String(MAXLEN = 50) [ SqlFieldName = IneligibleSourceCode ];

/// File Number: 2 Field Number :.1654
/// File Name: PATIENT Field Name: INELIGIBLE TWX STATE
/// Field Type: Pointer PointsToFileNumber: 5
/// Field Description:
/// Enter the state from which the TWX which informed you this applicant
/// was ineligible for treatment originated.  An ineligible date must be
/// specified in order to enter/edit this field and the user must hold
/// the designated security key.  This field may not be deleted as long
/// as an ineligible date is on file.
/// 
Property IneligibleStateIEN As %String(MAXLEN = 50) [ SqlFieldName = IneligibleStateIEN ];

/// File Number: 2 Field Number :.1656
/// File Name: PATIENT Field Name: INELIGIBLE VARO DECISION
/// Field Type: FreeText
/// Field Description:
/// Enter the VARO decision concerning this applicant's ineligibility
/// [between 3-75 characters].  An ineligible date must be specified in
/// order to enter/edit this field and the user must hold the designated
/// security key.  This field may not be deleted as long as an ineligible
/// date is on file.
/// 
Property IneligibleVAROReason As %String(MAXLEN = 100) [ SqlFieldName = IneligibleVAROReason ];

/// File Number: 2 Field Number :.3192
/// File Name: PATIENT Field Name: COVERED BY HEALTH INSURANCE?
/// Field Type: SetOfCodes
/// Field Description:
/// Enter 'Y' if this applicant is covered by a health insurance policy
/// regardless of who holds policy (applicant, spouse, employer, etc.),
/// 'N' if s/he isn't covered by any policy, or 'U' if unknown.
/// 
Property InsuranceCoverageFlag As %String(MAXLEN = 50) [ SqlFieldName = InsuranceCoverageFlag ];

/// File Number: 2 Field Number :.3192
/// File Name: PATIENT Field Name: COVERED BY HEALTH INSURANCE?
/// Field Type: SetOfCodes
/// Field Description:
/// Enter 'Y' if this applicant is covered by a health insurance policy
/// regardless of who holds policy (applicant, spouse, employer, etc.),
/// 'N' if s/he isn't covered by any policy, or 'U' if unknown.
/// 
Property InsuranceCoverageFlagCode As %String(MAXLEN = 50) [ SqlFieldName = InsuranceCoverageFlagCode ];

/// File Number: 2 Field Number :.32103
/// File Name: PATIENT Field Name: RADIATION EXPOSURE INDICATED?
/// Field Type: SetOfCodes
/// Field Description:
/// Enter 'Y' if the veteran was exposed to ionizing radiation 1) at a
/// nuclear device testing site (e.g. the Pacific Islands, NM or NV) or
/// 2) as a POW or while serving in Hiroshima and/or Nagasaki, Japan
/// from August 6, 1945 through July 1, 1946, or 3) served at
/// Department of Energy plants at Paducah, KY, Portsmouth, OH or
/// the K25 area at Oak Ridge, TN for at least 250 days before
/// February 1, 1992 or 4) served at Longshot, Milrow, or
/// Cannikin underground nuclear tests at Amchitka Island, AK
/// prior to January 1, 1974.  
///  
/// Veterans exposed by method #3 or #4 are not eligible for 
/// copay exemption or enrollment in priority 6 based on their IR exposure.
///  
/// Enter 'N' if not exposed or 'U' if unknown.
///  
/// Once the record has been verified only HEC users 
/// may enter/edit this field.
/// 
Property IonizingRadiationExposureFlag As %String(MAXLEN = 50) [ SqlFieldName = IonizingRadiationExposureFlag ];

/// File Number: 2 Field Number :.32103
/// File Name: PATIENT Field Name: RADIATION EXPOSURE INDICATED?
/// Field Type: SetOfCodes
/// Field Description:
/// Enter 'Y' if the veteran was exposed to ionizing radiation 1) at a
/// nuclear device testing site (e.g. the Pacific Islands, NM or NV) or
/// 2) as a POW or while serving in Hiroshima and/or Nagasaki, Japan
/// from August 6, 1945 through July 1, 1946, or 3) served at
/// Department of Energy plants at Paducah, KY, Portsmouth, OH or
/// the K25 area at Oak Ridge, TN for at least 250 days before
/// February 1, 1992 or 4) served at Longshot, Milrow, or
/// Cannikin underground nuclear tests at Amchitka Island, AK
/// prior to January 1, 1974.  
///  
/// Veterans exposed by method #3 or #4 are not eligible for 
/// copay exemption or enrollment in priority 6 based on their IR exposure.
///  
/// Enter 'N' if not exposed or 'U' if unknown.
///  
/// Once the record has been verified only HEC users 
/// may enter/edit this field.
/// 
Property IonizingRadiationExposureFlagCode As %String(MAXLEN = 50) [ SqlFieldName = IonizingRadiationExposureFlagCode ];

/// File Number: 2 Field Number :.05
/// File Name: PATIENT Field Name: MARITAL STATUS
/// Field Type: Pointer PointsToFileNumber: 11
/// Field Description:
/// Select from the available listing this applicant's current
/// marital status.
/// 
Property MaritalStatusIEN As %String(MAXLEN = 50) [ SqlFieldName = MaritalStatusIEN ];

/// File Number: 2 Field Number :.381
/// File Name: PATIENT Field Name: ELIGIBLE FOR MEDICAID?
/// Field Type: SetOfCodes
/// Field Description:
/// Enter yes if this patient is eligible to receive medicaid coverage.
/// Otherwise, answer no.
/// 
Property MedicaidEligibleFlag As %String(MAXLEN = 50) [ SqlFieldName = MedicaidEligibleFlag ];

/// File Number: 2 Field Number :.381
/// File Name: PATIENT Field Name: ELIGIBLE FOR MEDICAID?
/// Field Type: SetOfCodes
/// Field Description:
/// Enter yes if this patient is eligible to receive medicaid coverage.
/// Otherwise, answer no.
/// 
Property MedicaidEligibleFlagCode As %String(MAXLEN = 50) [ SqlFieldName = MedicaidEligibleFlagCode ];

/// File Number: 2 Field Number :.382
/// File Name: PATIENT Field Name: DATE MEDICAID LAST ASKED
/// Field Type: DateTime
/// Field Description:
/// Enter the date/time the 'ELIGIBLE FOR MEDICAID' question was last asked of
/// this veteran.  This data must be asked on a yearly basis as it affects the
/// requirement for a means test (a negative response results in a means test
/// not being required).
///  
/// This field will be stored automatically by the MAS module when editing
/// data on registration or load/edit screen 7.  It will not appear for editing.
/// 
Property MedicaidInquireDateTime As %FilemanTimeStamp [ SqlFieldName = MedicaidInquireDateTime ];

/// File Number: 2 Field Number :.382
/// File Name: PATIENT Field Name: DATE MEDICAID LAST ASKED
/// Field Type: DateTime
/// Field Description:
/// Enter the date/time the 'ELIGIBLE FOR MEDICAID' question was last asked of
/// this veteran.  This data must be asked on a yearly basis as it affects the
/// requirement for a means test (a negative response results in a means test
/// not being required).
///  
/// This field will be stored automatically by the MAS module when editing
/// data on registration or load/edit screen 7.  It will not appear for editing.
/// 
Property MedicaidInquireFMDate As %String(MAXLEN = 50) [ SqlFieldName = MedicaidInquireFMDate ];

/// File Number: 2 Field Number :.383
/// File Name: PATIENT Field Name: MEDICAID NUMBER
/// Field Type: FreeText
/// Field Description:
/// This is the patient's assigned MEDICAID number.
/// 
Property MedicaidNumber As %String(MAXLEN = 50) [ SqlFieldName = MedicaidNumber ];

/// File Number: 2 Field Number :11500.03
/// File Name: PATIENT Field Name: RANK
/// Field Type: Pointer PointsToFileNumber: 25002.1
/// Field Description:
/// Enter the grade/rank of this operation desert shield patient.
/// 
Property ODSRankType As %String(MAXLEN = 50) [ SqlFieldName = ODSRankType ];

/// File Number: 2 Field Number :11500.02
/// File Name: PATIENT Field Name: RECALLED TO ACTIVE DUTY
/// Field Type: SetOfCodes
/// Field Description:
/// Was this operation desert shield patient recalled to active duty?  If so
/// select from national guard or reserves.  If not, answer no.
/// 
Property ODSRecalledCode As %String(MAXLEN = 50) [ SqlFieldName = ODSRecalledCode ];

/// File Number: 2 Field Number :11500.02
/// File Name: PATIENT Field Name: RECALLED TO ACTIVE DUTY
/// Field Type: SetOfCodes
/// Field Description:
/// Was this operation desert shield patient recalled to active duty?  If so
/// select from national guard or reserves.  If not, answer no.
/// 
Property ODSRecalledCodeCode As %String(MAXLEN = 50) [ SqlFieldName = ODSRecalledCodeCode ];

/// File Number: 2 Field Number :11500.01
/// File Name: PATIENT Field Name: INITIAL ODS TREATMENT RECEIVED
/// Field Type: DateTime
/// Field Description:
/// Enter the date/time this patient was initially entered as ODS.  This field
/// will automatically be created when ODS is selected as the PERIOD OF SERVICE
/// for this patient.
/// 
Property ODSTreatmentDateTime As %FilemanTimeStamp [ SqlFieldName = ODSTreatmentDateTime ];

/// File Number: 2 Field Number :11500.01
/// File Name: PATIENT Field Name: INITIAL ODS TREATMENT RECEIVED
/// Field Type: DateTime
/// Field Description:
/// Enter the date/time this patient was initially entered as ODS.  This field
/// will automatically be created when ODS is selected as the PERIOD OF SERVICE
/// for this patient.
/// 
Property ODSTreatmentFMDate As %String(MAXLEN = 50) [ SqlFieldName = ODSTreatmentFMDate ];

/// If OpCode IS NOT NULL then the record is deleted on Vista.
Property OpCode As %String(MAXLEN = 1);

/// File Number: 2 Field Number :11500.03
/// File Name: PATIENT Field Name: RANK
/// Field Type: Pointer PointsToFileNumber: 25002.1
/// Field Description:
/// Enter the grade/rank of this operation desert shield patient.
/// 
Property OperationDesertShieldRank As %String(MAXLEN = 50) [ SqlFieldName = OperationDesertShieldRank ];

/// File Number: 2 Field Number :.525
/// File Name: PATIENT Field Name: POW STATUS INDICATED?
/// Field Type: SetOfCodes
/// Field Description:
/// For this veteran applicant enter 'Y' if s/he was confined as a prisoner
/// of war, 'N' if not, or 'U' if unknown.  Once the POW Status is verified 
/// by the HEC, it is no longer editable.
/// 
Property POWFlag As %String(MAXLEN = 50) [ SqlFieldName = POWFlag ];

/// File Number: 2 Field Number :.525
/// File Name: PATIENT Field Name: POW STATUS INDICATED?
/// Field Type: SetOfCodes
/// Field Description:
/// For this veteran applicant enter 'Y' if s/he was confined as a prisoner
/// of war, 'N' if not, or 'U' if unknown.  Once the POW Status is verified 
/// by the HEC, it is no longer editable.
/// 
Property POWFlagCode As %String(MAXLEN = 50) [ SqlFieldName = POWFlagCode ];

/// File Number: 2 Field Number :.526
/// File Name: PATIENT Field Name: POW CONFINEMENT LOCATION
/// Field Type: Pointer PointsToFileNumber: 22
/// Field Description:
/// For this veteran applicant who was confined as a prisoner of war
/// (WERE YOU A PRISONER OF WAR prompt must be answered YES) enter the
/// war during which confined.  Once the service record is verified only
/// those users who hold the designated security key may enter/edit this
/// field.  This field cannot be deleted as long as applicant is
/// identified as a former POW.
/// 
Property POWLocationIEN As %String(MAXLEN = 50) [ SqlFieldName = POWLocationIEN ];

/// File Number: 2 Field Number :.096
/// File Name: PATIENT Field Name: WHO ENTERED PATIENT
/// Field Type: Pointer PointsToFileNumber: 200
/// Field Description:
/// The name of the user who first entered this applicant into the patient
/// file.
/// 
Property PatientEnteredByStaffIEN As %String(MAXLEN = 50) [ SqlFieldName = PatientEnteredByStaffIEN ];

/// File Number: 2 Field Number :.098
/// File Name: PATIENT Field Name: HOW WAS PATIENT ENTERED?
/// Field Type: SetOfCodes
/// Field Description:
/// How was the patient entered into the system.
/// 
Property PatientEnteredCode As %String(MAXLEN = 50) [ SqlFieldName = PatientEnteredCode ];

/// File Number: 2 Field Number :.098
/// File Name: PATIENT Field Name: HOW WAS PATIENT ENTERED?
/// Field Type: SetOfCodes
/// Field Description:
/// How was the patient entered into the system.
/// 
Property PatientEnteredCodeCode As %String(MAXLEN = 50) [ SqlFieldName = PatientEnteredCodeCode ];

/// File Number: 2 Field Number :.097
/// File Name: PATIENT Field Name: DATE ENTERED INTO FILE
/// Field Type: DateTime
/// Field Description:
/// This field stores the date this patient was initially stored into the
/// PATIENT file.  This is filled in automatically once a patient is
/// successfully added to the database.
/// 
Property PatientEnteredDateTime As %FilemanTimeStamp [ SqlFieldName = PatientEnteredDateTime ];

/// File Number: 2 Field Number :.097
/// File Name: PATIENT Field Name: DATE ENTERED INTO FILE
/// Field Type: DateTime
/// Field Description:
/// This field stores the date this patient was initially stored into the
/// PATIENT file.  This is filled in automatically once a patient is
/// successfully added to the database.
/// 
Property PatientEnteredFMDate As %String(MAXLEN = 50) [ SqlFieldName = PatientEnteredFMDate ];

/// File Number: 2 Field Number :.091
/// File Name: PATIENT Field Name: REMARKS
/// Field Type: FreeText
/// Field Description:
/// If so desired, you may enter a short remark about this applicant between
/// 3-60 characters.  The remark entered should be significant and tact should
/// be exercised since this field is viewable to virtually all other users who
/// have the ability to 'call up' a patient for any purpose.
/// 
Property PatientEnteredRemark As %String(MAXLEN = 100) [ SqlFieldName = PatientEnteredRemark ];

/// File Number: 2 Field Number :.01
/// File Name: PATIENT Field Name: NAME
/// Field Type: FreeText
/// Field Description:
/// Enter the patient's name in 'LAST,FIRST MIDDLE SUFFIX' format.
/// This value must be 3-30 characters in length and may contain only uppercase
/// alpha characters, spaces, apostrophes, hyphens and one comma.  All other
/// characters and parenthetical text will be removed.
/// 
Property PatientFirstName As %String(MAXLEN = 50) [ SqlFieldName = PatientFirstName ];

/// File Number: 2 Field Number :991.01
/// File Name: PATIENT Field Name: INTEGRATION CONTROL NUMBER
/// Field Type: Numeric
/// Field Description:
/// Machine to machine identifier for a patient.
/// 
Property PatientICN As %String(MAXLEN = 50) [ SqlFieldName = PatientICN ];

Property PatientIEN As %String [ Required ];

/// File Number: 2 Field Number :.01
/// File Name: PATIENT Field Name: NAME
/// Field Type: FreeText
/// Field Description:
/// Enter the patient's name in 'LAST,FIRST MIDDLE SUFFIX' format.
/// This value must be 3-30 characters in length and may contain only uppercase
/// alpha characters, spaces, apostrophes, hyphens and one comma.  All other
/// characters and parenthetical text will be removed.
/// 
Property PatientLastName As %String(MAXLEN = 50) [ SqlFieldName = PatientLastName ];

/// File Number: 2 Field Number :.1658
/// File Name: PATIENT Field Name: MISSING PERSON TWX CITY
/// Field Type: FreeText
/// Field Description:
/// If this patient is missing, enter the city where the TWX reporting the
/// patient as missing was originated.
/// 
Property PatientMissingCity As %String(MAXLEN = 50) [ SqlFieldName = PatientMissingCity ];

/// File Number: 2 Field Number :.153
/// File Name: PATIENT Field Name: MISSING PERSON DATE
/// Field Type: DateTime
/// Field Description:
/// This field contains the date this patient was initially listed as missing.
/// 
Property PatientMissingDateTime As %FilemanTimeStamp [ SqlFieldName = PatientMissingDateTime ];

/// File Number: 2 Field Number :.153
/// File Name: PATIENT Field Name: MISSING PERSON DATE
/// Field Type: DateTime
/// Field Description:
/// This field contains the date this patient was initially listed as missing.
/// 
Property PatientMissingFMDate As %String(MAXLEN = 50) [ SqlFieldName = PatientMissingFMDate ];

/// File Number: 2 Field Number :.1657
/// File Name: PATIENT Field Name: MISSING PERSON TWX SOURCE
/// Field Type: SetOfCodes
/// Field Description:
/// If this patient is missing, enter the source of the TWX that originally
/// listed the patient as missing.
/// 
Property PatientMissingSource As %String(MAXLEN = 50) [ SqlFieldName = PatientMissingSource ];

/// File Number: 2 Field Number :.1657
/// File Name: PATIENT Field Name: MISSING PERSON TWX SOURCE
/// Field Type: SetOfCodes
/// Field Description:
/// If this patient is missing, enter the source of the TWX that originally
/// listed the patient as missing.
/// 
Property PatientMissingSourceCode As %String(MAXLEN = 50) [ SqlFieldName = PatientMissingSourceCode ];

/// File Number: 2 Field Number :.1659
/// File Name: PATIENT Field Name: MISSING PERSON TWX STATE
/// Field Type: Pointer PointsToFileNumber: 5
/// Field Description:
/// If this patient is missing, enter the state where the TWX reporting the
/// patient as missing was originated.
/// 
Property PatientMissingStateIEN As %String(MAXLEN = 50) [ SqlFieldName = PatientMissingStateIEN ];

/// File Number: 2 Field Number :.01
/// File Name: PATIENT Field Name: NAME
/// Field Type: FreeText
/// Field Description:
/// Enter the patient's name in 'LAST,FIRST MIDDLE SUFFIX' format.
/// This value must be 3-30 characters in length and may contain only uppercase
/// alpha characters, spaces, apostrophes, hyphens and one comma.  All other
/// characters and parenthetical text will be removed.
/// 
Property PatientName As %String(MAXLEN = 100) [ SqlFieldName = PatientName ];

/// File Number: 2 Field Number :.09
/// File Name: PATIENT Field Name: SOCIAL SECURITY NUMBER
/// Field Type: FreeText
/// Field Description:
/// Answer with the individual's social security number.  Answer must be 9 
/// numbers in length. The SSN will be sent to the SSA for verification.  
/// This will be displayed next to the SSN.  Once an SSN has received a
/// status of Verified, it is locked from user updating and a "VERIFIED"
/// will be displayed by the SSN field.  Only the Identity Management Data
/// QUality Team are able to change a beneficiary's (veteran/non veteran)
/// SSN.  If an Invalid per SSA status is received for the SSN, then an
/// "INVALID" will appear next to the invalid SSN of the individual.
/// Facilities should make every effort to obtain the accurate SSN from the
/// individual for any invalid or pseudo SSN entry.
///  
/// If a valid SSN is not known, then a "P" will be entered at the SSN
/// prompt for the system to automatically assign a Pseudo-SSN.  If a
/// Pseudo SSN is entered, a Reason for entering it will be required.
/// 
Property PatientSSN As %String(MAXLEN = 50) [ SqlFieldName = PatientSSN ];

/// File Number: 2 Field Number :391
/// File Name: PATIENT Field Name: TYPE
/// Field Type: Pointer PointsToFileNumber: 391
/// Field Description:
/// Enter the patient type for this patient.  This is selectable from the
/// distributed entries in the TYPE OF PATIENT file.  The type selected should
/// be the primary one selectable.  For example, if the patient is both an
/// NSC veteran and an employee, the patient type should be NSC VETERAN, not
/// employee.
///  
/// This field is used by the registration screen processor to determine which
/// screens will be editable for this patient.  The selection of which screens
/// can be viewed for which types of patients can be made through the 'Patient
/// Type Update' option.
/// 
Property PatientTypeIEN As %String(MAXLEN = 50) [ SqlFieldName = PatientTypeIEN ];

/// File Number: 2 Field Number :.302
/// File Name: PATIENT Field Name: SERVICE CONNECTED PERCENTAGE
/// Field Type: Numeric
/// Field Description:
/// If this applicant is service connected (SERVICE CONNECTED prompt must
/// be answered YES) enter the service connected percentage [a number
/// between 0-100].  Once eligibility has been verified only users who hold
/// the designated security key may enter/edit this field.  Field may not be
/// deleted as long as service connection is indicated.
/// 
Property PercentServiceConnect As %Integer [ SqlFieldName = PercentServiceConnect ];

/// File Number: 2 Field Number :.323
/// File Name: PATIENT Field Name: PERIOD OF SERVICE
/// Field Type: Pointer PointsToFileNumber: 21
/// Field Description:
/// From the available listing select the period of service which best
/// classifies this applicant.  The selections displayed are limited
/// based on the eligibility code which must have been entered in order
/// to select a period of service.  Once the service record is verified
/// only those users who hold the designated security key may enter/edit
/// this field.
/// 
Property PeriodOfServiceIEN As %String(MAXLEN = 50) [ SqlFieldName = PeriodOfServiceIEN ];

/// File Number: 2 Field Number :27.02
/// File Name: PATIENT Field Name: PREFERRED FACILITY
/// Field Type: Pointer PointsToFileNumber: 4
/// Field Description:
/// The facility that the patient chooses to designate as his preferred
/// location for care.
/// The facility must have one of the following facility types:
///       CBOC         (Community Based Outpatient Clinic)
///       HCS          (Health Care System)
///       HEALTHCARE   (VA Boston Health Care System)
///       M&ROC        (Medical and Regional Office Center)
///       MOC          (Mobile Outpatient Clinic)
///       MORC         (Mobile Outreach Clinic)
///       NETWORK      (VA Healthcare Network Upstate NY)
///       NHC          (Nursing Home Care)
///       OC           (Outpatient Clinic - Independent)
///       OCMC         (Outpatient Clinic - Subordinate)
///       OCS          (Outpatient Clinic Substation)
///       OPC          (Out Patient Clinic)
///       ORC          (Outreach Clinic)
///       RO-OC        (Regional Office - Outpatient Clinic)
///       SATELLITE    (Satellite Outpatient Clinic)
///       SOC          (Satellite Outpatient Clinic)
///       VAMC         (VA Medical Center)
///       VANPH        (Neural Psychiatric Hospital)
///       VA ROSEBERG  (VA Roseburg Health Care System)
/// 
Property PreferredInstitutionIEN As %String(MAXLEN = 50) [ SqlFieldName = PreferredInstitutionIEN ];

/// File Number: 2 Field Number :27.03
/// File Name: PATIENT Field Name: SOURCE DESIGNATION
/// Field Type: SetOfCodes
/// Field Description:
/// Source designation contains the value of the place the Preferred Facility 
/// field (#27.02) was assigned for the patient.  Source designation is 
/// automatically assigned by the system.  The VistA system can only assign 
/// a Preferred Facility if the current Source Designation is VistA or 
/// Primary Care Provider (PCP) Inactive.
/// 
Property PreferredInstitutionSource As %String(MAXLEN = 50) [ SqlFieldName = PreferredInstitutionSource ];

/// File Number: 2 Field Number :27.03
/// File Name: PATIENT Field Name: SOURCE DESIGNATION
/// Field Type: SetOfCodes
/// Field Description:
/// Source designation contains the value of the place the Preferred Facility 
/// field (#27.02) was assigned for the patient.  Source designation is 
/// automatically assigned by the system.  The VistA system can only assign 
/// a Preferred Facility if the current Source Designation is VistA or 
/// Primary Care Provider (PCP) Inactive.
/// 
Property PreferredInstitutionSourceCode As %String(MAXLEN = 50) [ SqlFieldName = PreferredInstitutionSourceCode ];

/// File Number: 2 Field Number :.0906
/// File Name: PATIENT Field Name: PSEUDO SSN REASON
/// Field Type: SetOfCodes
/// Field Description:
/// This field is used to document the reason the individual was assigned a 
/// pseudo SSN.  Based on your selection, the Pseudo SSN Report (Patient) 
/// option located in the Registration Menu can provide you a current 
/// report of the reasons entered at this prompt.  The following reasons
/// are available for selection:
///  
/// Refused to Provide - use this reason when the individual was asked for 
/// his/her SSN and refused to provide the number.
///  
/// SSN Unknown/Follow-up required - use this reason when the individual
/// is not available to ask/answer the request for SSN.  The facility
/// should initiate Follow-up activity to obtain the SSN.
///  
/// No SSN Assigned - use this reason when the individual has not been
/// assigned an SSN. This generally applies to spouse or dependents of
/// veterans who are not US citizens and infrequently, non-citizen
/// beneficiaries.
/// 
Property PseudoSSNReason As %String(MAXLEN = 50) [ SqlFieldName = PseudoSSNReason ];

/// File Number: 2 Field Number :.0906
/// File Name: PATIENT Field Name: PSEUDO SSN REASON
/// Field Type: SetOfCodes
/// Field Description:
/// This field is used to document the reason the individual was assigned a 
/// pseudo SSN.  Based on your selection, the Pseudo SSN Report (Patient) 
/// option located in the Registration Menu can provide you a current 
/// report of the reasons entered at this prompt.  The following reasons
/// are available for selection:
///  
/// Refused to Provide - use this reason when the individual was asked for 
/// his/her SSN and refused to provide the number.
///  
/// SSN Unknown/Follow-up required - use this reason when the individual
/// is not available to ask/answer the request for SSN.  The facility
/// should initiate Follow-up activity to obtain the SSN.
///  
/// No SSN Assigned - use this reason when the individual has not been
/// assigned an SSN. This generally applies to spouse or dependents of
/// veterans who are not US citizens and infrequently, non-citizen
/// beneficiaries.
/// 
Property PseudoSSNReasonCode As %String(MAXLEN = 50) [ SqlFieldName = PseudoSSNReasonCode ];

/// File Number: 2 Field Number :.3212
/// File Name: PATIENT Field Name: RADIATION EXPOSURE METHOD
/// Field Type: SetOfCodes
/// Field Description:
/// This field represents the method by which the
/// exposure to ionizing radiation occurred.
/// 
Property RadiationExposureCode As %String(MAXLEN = 50) [ SqlFieldName = RadiationExposureCode ];

/// File Number: 2 Field Number :.3212
/// File Name: PATIENT Field Name: RADIATION EXPOSURE METHOD
/// Field Type: SetOfCodes
/// Field Description:
/// This field represents the method by which the
/// exposure to ionizing radiation occurred.
/// 
Property RadiationExposureCodeCode As %String(MAXLEN = 50) [ SqlFieldName = RadiationExposureCodeCode ];

/// File Number: 2 Field Number :.08
/// File Name: PATIENT Field Name: RELIGIOUS PREFERENCE
/// Field Type: Pointer PointsToFileNumber: 13
/// Field Description:
/// Select from the available listing the religious preference of this
/// applicant.
/// 
Property ReligionIEN As %String(MAXLEN = 50) [ SqlFieldName = ReligionIEN ];

/// File Number: 2 Field Number :.32115
/// File Name: PATIENT Field Name: PROJ 112/SHAD
/// Field Type: SetOfCodes
/// Field Description:
/// 
Property SHADFlag As %String(MAXLEN = 50) [ SqlFieldName = SHADFlag ];

/// File Number: 2 Field Number :.32115
/// File Name: PATIENT Field Name: PROJ 112/SHAD
/// Field Type: SetOfCodes
/// Field Description:
/// 
Property SHADFlagCode As %String(MAXLEN = 50) [ SqlFieldName = SHADFlagCode ];

/// File Number: 2 Field Number :.0907
/// File Name: PATIENT Field Name: SSN VERIFICATION STATUS
/// Field Type: SetOfCodes
/// Field Description:
/// This field designates whether or not the SSN has been verified. This field
/// will be received in the HL7 record.  It is not editable by the user.  Once
/// the SSN is verified by the SSA, it is no longer editable. 
/// 
Property SSNVerificationStatus As %String(MAXLEN = 50) [ SqlFieldName = SSNVerificationStatus ];

/// File Number: 2 Field Number :.0907
/// File Name: PATIENT Field Name: SSN VERIFICATION STATUS
/// Field Type: SetOfCodes
/// Field Description:
/// This field designates whether or not the SSN has been verified. This field
/// will be received in the HL7 record.  It is not editable by the user.  Once
/// the SSN is verified by the SSA, it is no longer editable. 
/// 
Property SSNVerificationStatusCode As %String(MAXLEN = 50) [ SqlFieldName = SSNVerificationStatusCode ];

/// File Number: 2 Field Number :.09
/// File Name: PATIENT Field Name: SOCIAL SECURITY NUMBER
/// Field Type: FreeText
/// Field Description:
/// Answer with the individual's social security number.  Answer must be 9 
/// numbers in length. The SSN will be sent to the SSA for verification.  
/// This will be displayed next to the SSN.  Once an SSN has received a
/// status of Verified, it is locked from user updating and a "VERIFIED"
/// will be displayed by the SSN field.  Only the Identity Management Data
/// QUality Team are able to change a beneficiary's (veteran/non veteran)
/// SSN.  If an Invalid per SSA status is received for the SSN, then an
/// "INVALID" will appear next to the invalid SSN of the individual.
/// Facilities should make every effort to obtain the accurate SSN from the
/// individual for any invalid or pseudo SSN entry.
///  
/// If a valid SSN is not known, then a "P" will be entered at the SSN
/// prompt for the system to automatically assign a Pseudo-SSN.  If a
/// Pseudo SSN is entered, a Reason for entering it will be required.
/// 
Property ScrSSN As %String(MAXLEN = 50) [ SqlFieldName = ScrSSN ];

/// File Number: 2 Field Number :.024
/// File Name: PATIENT Field Name: SELF IDENTIFIED GENDER
/// Field Type: SetOfCodes
/// Field Description:
/// This SELF IDENTIFIED GENDER value indicates the patient's view of their 
/// gender identity, if they choose to provide it.
/// 
Property SelfIdentifiedGender As %String(MAXLEN = 50) [ SqlFieldName = SelfIdentifiedGender ];

/// File Number: 2 Field Number :.024
/// File Name: PATIENT Field Name: SELF IDENTIFIED GENDER
/// Field Type: SetOfCodes
/// Field Description:
/// This SELF IDENTIFIED GENDER value indicates the patient's view of their 
/// gender identity, if they choose to provide it.
/// 
Property SelfIdentifiedGenderCode As %String(MAXLEN = 50) [ SqlFieldName = SelfIdentifiedGenderCode ];

/// File Number: 38.1 Field Number :2
/// File Name: DG SECURITY LOG Field Name: SECURITY LEVEL
/// Field Type: SetOfCodes
/// Field Description:
/// This field contains a 1 if the patient record is presently listed as
/// sensitive or a 0 if the patient's record is not currently sensitive.
/// 
Property SensitiveFlag As %String(MAXLEN = 50) [ SqlFieldName = SensitiveFlag ];

/// File Number: 38.1 Field Number :2
/// File Name: DG SECURITY LOG Field Name: SECURITY LEVEL
/// Field Type: SetOfCodes
/// Field Description:
/// This field contains a 1 if the patient record is presently listed as
/// sensitive or a 0 if the patient's record is not currently sensitive.
/// 
Property SensitiveFlagCode As %String(MAXLEN = 50) [ SqlFieldName = SensitiveFlagCode ];

/// File Number: 2 Field Number :.301
/// File Name: PATIENT Field Name: SERVICE CONNECTED?
/// Field Type: SetOfCodes
/// Field Description:
/// Enter 'Y' if this applicant is service connected, 'N' if not.
/// Applicants identified as being non-veterans cannot be entered
/// as service connected.  Once eligibility has been verified only
/// users holding the designated security key may enter/edit this
/// field.
/// 
Property ServiceConnectedFlag As %String(MAXLEN = 50) [ SqlFieldName = ServiceConnectedFlag ];

/// File Number: 2 Field Number :.301
/// File Name: PATIENT Field Name: SERVICE CONNECTED?
/// Field Type: SetOfCodes
/// Field Description:
/// Enter 'Y' if this applicant is service connected, 'N' if not.
/// Applicants identified as being non-veterans cannot be entered
/// as service connected.  Once eligibility has been verified only
/// users holding the designated security key may enter/edit this
/// field.
/// 
Property ServiceConnectedFlagCode As %String(MAXLEN = 50) [ SqlFieldName = ServiceConnectedFlagCode ];

/// File Number: 2 Field Number :.322013
/// File Name: PATIENT Field Name: SOUTHWEST ASIA CONDITIONS?
/// Field Type: SetOfCodes
/// Field Description:
/// Enter "Y" if veteran claims need for care of conditions related to
/// service in SW Asia. Enter "N" if veteran did not serve in SW Asia or
/// does not claim need for care of conditions related to service in SW
/// Asia. Enter "U" when veteran served in SW Asia, but is unsure of
/// whether conditions may be related to that service. SW Asia Theater
/// of operations is defined as: Iraq, Kuwait, Saudi Arabia, the neutral
/// zone between Iraq and Saudi Arabia, Bahrain, Qatar, the United Arab
/// Emirates, Oman, the Gulf of Aden, the Gulf of Oman, the Persian Gulf,
/// the Arabian Sea, the Red Sea, and the airspace above these locations.
/// 
Property SouthwestAsiaCondition As %String(MAXLEN = 50) [ SqlFieldName = SouthwestAsiaCondition ];

/// File Number: 2 Field Number :.322013
/// File Name: PATIENT Field Name: SOUTHWEST ASIA CONDITIONS?
/// Field Type: SetOfCodes
/// Field Description:
/// Enter "Y" if veteran claims need for care of conditions related to
/// service in SW Asia. Enter "N" if veteran did not serve in SW Asia or
/// does not claim need for care of conditions related to service in SW
/// Asia. Enter "U" when veteran served in SW Asia, but is unsure of
/// whether conditions may be related to that service. SW Asia Theater
/// of operations is defined as: Iraq, Kuwait, Saudi Arabia, the neutral
/// zone between Iraq and Saudi Arabia, Bahrain, Qatar, the United Arab
/// Emirates, Oman, the Gulf of Aden, the Gulf of Oman, the Persian Gulf,
/// the Arabian Sea, the Red Sea, and the airspace above these locations.
/// 
Property SouthwestAsiaConditionCode As %String(MAXLEN = 50) [ SqlFieldName = SouthwestAsiaConditionCode ];

/// The three digit station number for the record.
Property Sta3n As %SmallInt [ Required ];

/// File Number: 2 Field Number :.117
/// File Name: PATIENT Field Name: COUNTY
/// Field Type: Numeric
/// Field Description:
/// If a state of residence is entered select from the available
/// listing the county in which this applicant resides.  If no
/// state (or a non-state) is entered no selection is possible.
/// 
Property StateCountyIEN As %String(MAXLEN = 50) [ SqlFieldName = StateCountyIEN ];

/// File Number: 2 Field Number :.115
/// File Name: PATIENT Field Name: STATE
/// Field Type: Pointer PointsToFileNumber: 5
/// Field Description:
/// From the available listing choose the state in which this applicant
/// resides.
/// 
Property StateIEN As %String(MAXLEN = 50) [ SqlFieldName = StateIEN ];

/// File Number: 2 Field Number :.111
/// File Name: PATIENT Field Name: STREET ADDRESS [LINE 1]
/// Field Type: FreeText
/// Field Description:
/// Enter the first line of this applicant's residence street address
/// [3-35 characters].
/// 
Property StreetAddress1 As %String(MAXLEN = 50) [ SqlFieldName = StreetAddress1 ];

/// File Number: 2 Field Number :.112
/// File Name: PATIENT Field Name: STREET ADDRESS [LINE 2]
/// Field Type: FreeText
/// Field Description:
/// Enter the second line of this applicant's residence street address
/// [3-30 characters] if the space provided in 'street address' was
/// not sufficient.
/// 
Property StreetAddress2 As %String(MAXLEN = 50) [ SqlFieldName = StreetAddress2 ];

/// File Number: 2 Field Number :.6
/// File Name: PATIENT Field Name: TEST PATIENT INDICATOR
/// Field Type: SetOfCodes
/// Field Description:
/// This field is set by the 'ATP' cross reference on the Social Security Number 
/// field (.09) when an SSN containing five leading zeros is entered.
/// 
Property TestPatientFlag As %String(MAXLEN = 50) [ SqlFieldName = TestPatientFlag ];

/// File Number: 2 Field Number :.6
/// File Name: PATIENT Field Name: TEST PATIENT INDICATOR
/// Field Type: SetOfCodes
/// Field Description:
/// This field is set by the 'ATP' cross reference on the Social Security Number 
/// field (.09) when an SSN containing five leading zeros is entered.
/// 
Property TestPatientFlagCode As %String(MAXLEN = 50) [ SqlFieldName = TestPatientFlagCode ];

/// File Number: 2 Field Number :1901
/// File Name: PATIENT Field Name: VETERAN (Y/N)?
/// Field Type: SetOfCodes
/// Field Description:
/// Enter 'Y' if this applicant is over 17 years of age and is a veteran,
/// 'N' if not.  If applicant is under 17 years of age and is a veteran
/// only those users holding the designated security may identify him/her
/// as a veteran.  Once eligibility is verified only those users who
/// hold the designated security key may enter/edit this field.
/// 
Property VeteranFlag As %String(MAXLEN = 50) [ SqlFieldName = VeteranFlag ];

/// File Number: 2 Field Number :1901
/// File Name: PATIENT Field Name: VETERAN (Y/N)?
/// Field Type: SetOfCodes
/// Field Description:
/// Enter 'Y' if this applicant is over 17 years of age and is a veteran,
/// 'N' if not.  If applicant is under 17 years of age and is a veteran
/// only those users holding the designated security may identify him/her
/// as a veteran.  Once eligibility is verified only those users who
/// hold the designated security key may enter/edit this field.
/// 
Property VeteranFlagCode As %String(MAXLEN = 50) [ SqlFieldName = VeteranFlagCode ];

/// File Number: 2 Field Number :3000
/// File Name: PATIENT Field Name: VTS PATIENT FLAG
/// Field Type: SetOfCodes
/// Field Description:
///  This field indicates whether or not the patient is or wants to be part of the Veteran 
/// Transportation Service (VTS).
/// 
Property VeteranTransportationProgramFlag As %String(MAXLEN = 50) [ SqlFieldName = VeteranTransportationProgramFlag ];

/// File Number: 2 Field Number :3000
/// File Name: PATIENT Field Name: VTS PATIENT FLAG
/// Field Type: SetOfCodes
/// Field Description:
///  This field indicates whether or not the patient is or wants to be part of the Veteran 
/// Transportation Service (VTS).
/// 
Property VeteranTransportationProgramFlagCode As %String(MAXLEN = 50) [ SqlFieldName = VeteranTransportationProgramFlagCode ];

/// File Number: 2 Field Number :.32101
/// File Name: PATIENT Field Name: VIETNAM SERVICE INDICATED?
/// Field Type: SetOfCodes
/// Field Description:
/// For this veteran applicant enter 'Y' if s/he actually served in the
/// Republic of Vietnam, 'N' if not, or 'U' if unknown.  Once the service
/// record has been verified only users who hold the designated security
/// key may enter/edit this field.
/// 
Property VietnamServiceFlag As %String(MAXLEN = 50) [ SqlFieldName = VietnamServiceFlag ];

/// File Number: 2 Field Number :.32101
/// File Name: PATIENT Field Name: VIETNAM SERVICE INDICATED?
/// Field Type: SetOfCodes
/// Field Description:
/// For this veteran applicant enter 'Y' if s/he actually served in the
/// Republic of Vietnam, 'N' if not, or 'U' if unknown.  Once the service
/// record has been verified only users who hold the designated security
/// key may enter/edit this field.
/// 
Property VietnamServiceFlagCode As %String(MAXLEN = 50) [ SqlFieldName = VietnamServiceFlagCode ];

/// If 1900-01-01 then created by Historical Pull.
/// Otherwise the date (UTC date/time) the record was added.
Property VistaCreateDate As %TimeStamp;

/// The last time (UTC date/time) the record was updated.
Property VistaEditDate As %TimeStamp [ Required ];

/// File Number: 2 Field Number :.116
/// File Name: PATIENT Field Name: ZIP CODE
/// Field Type: FreeText
/// Field Description:
/// Enter the zip code [5 numerics] for the city in which this applicant
/// resides.
/// 
Property Zip As %String(MAXLEN = 50) [ SqlFieldName = Zip ];

/// File Number: 2 Field Number :.1112
/// File Name: PATIENT Field Name: ZIP+4
/// Field Type: FreeText
/// Field Description:
/// Answer with either the 5 digit format (e.g. 12345) or the nine digit
/// format (e.g. 12345-6789 or 123456789).
/// 
Property Zip4 As %String(MAXLEN = 50) [ SqlFieldName = Zip4 ];

Index MainIndex On (Sta3n, PatientIEN) [ IdKey, PrimaryKey, Unique ];

Index PatientICNIndex On (Sta3n, PatientIEN);

Index PatientICNOnlyIndex On PatientICN;

Index PatientSSNIndex On PatientSSN;

Index PatientEnteredByStaffIENIndex On PatientEnteredByStaffIEN;

Index VistaEditDateIndex On VistaEditDate;

ClassMethod BuildSite(Sta3n As %Integer, StartIEN As %String = 0) As %Integer
{
	NEW Count, LastIEN,NS,PatientIEN, VistaSite
	Write Sta3n,!,$ZDateTime($H,3),!
	Set VistaSite=##class(VX130.VistaSite).%OpenId(Sta3n)
	Set NS=VistaSite.Sta3a
	Set LastIEN=""
	Set Count=0
	Set PatientIEN=$Order(^|NS|DPT(StartIEN))
	While (+PatientIEN) {
		Set LastIEN=PatientIEN
		Set Count=Count+1
		Set Status=..UpdateObject(Sta3n,PatientIEN,0,1)
		//Do:'(+Status) ##class(VX130.FilingErrors).AddError(VistaSite,..%ClassName(1),LastIEN,Status)
		//If '(Count#10000) Do ##class(VX130.HistoricalPullHistory).UpdateHPStatus(..%ClassName(1),Sta3n,LastIEN)
		Set PatientIEN=$Order(^|NS|DPT(PatientIEN))
	}
	//Do ##class(VX130.HistoricalPullHistory).FinishHP(..%ClassName(1),Sta3n,LastIEN)
	Quit
}

ClassMethod CheckVISTAToVX130(Sta3n As %Integer, StartIEN As %String = 0, EndIEN As %Integer = "") As %Integer
{
	Write Sta3n,!,$ZDateTime($H,3),!
	NEW NS, PatientIEN, LastIEN, VistaSite
	Set VistaSite=##class(VX130.VistaSite).%OpenId(Sta3n)
	Set NS=VistaSite.VistaSiteNamespace
	Set LastIEN=""
	Set Count=0
	Set PatientIEN=$Order(^|NS|DPT(StartIEN))
	While (+PatientIEN) {
		Quit:$Select(EndIEN]"":(+PatientIEN>(EndIEN+1)),1:0)
		Set LastIEN=PatientIEN
		Set Count=Count+1
		Set Status=..UpdateObject(Sta3n,PatientIEN,1,0)
		//Do:'(+Status) ##class(VX130.FilingErrors).AddError(VistaSite,..%ClassName(1),LastIEN,Status)
		//If '(Count#10000) Do ##class(QC.QualityCheckHistory).UpdateDQStatus("VISTA",Sta3n,..%ClassName(1),LastIEN)
		Set PatientIEN=$Order(^|NS|DPT(PatientIEN))
	}
	//Do ##class(QC.QualityCheckHistory).UpdateDQStatus("VISTA",Sta3n,..%ClassName(1),LastIEN)
	//Do ##class(QC.QualityCheckHistory).EndQualityCheck("VISTA",Sta3n,..%ClassName(1))
	Quit
}

ClassMethod FlatFileHeader() As %String
{
	Quit "Sta3n^PatientIEN^PatientFirstName^PatientLastName^PatientName^Gender^GenderCode^BirthDateTime^BirthFMDate^MaritalStatusIEN^ReligionIEN^DuplicateRecordStatus^DuplicateRecordStatusCode^DestinationMergePatientIEN^PatientSSN^ScrSSN^PseudoSSNReason^PseudoSSNReasonCode^SSNVerificationStatus^SSNVerificationStatusCode^PatientEnteredRemark^PatientEnteredByStaffIEN^PatientEnteredDateTime^PatientEnteredFMDate^PatientEnteredCode^PatientEnteredCodeCode^StreetAddress1^Zip4^StreetAddress2^City^StateIEN^Zip^StateCountyIEN^BadAddressIndicator^BadAddressIndicatorCode^CurrentMeansTestStatusIEN^IneligibleDateTime^IneligibleFMDate^PatientMissingDateTime^PatientMissingFMDate^IneligibleSource^IneligibleSourceCode^IneligibleCity^IneligibleStateIEN^IneligibleVAROReason^PatientMissingSource^PatientMissingSourceCode^PatientMissingCity^PatientMissingStateIEN^EmergencyResponseIndicator^EmergencyResponseIndicatorCode^ServiceConnectedFlag^ServiceConnectedFlagCode^PercentServiceConnect^IneligibleReason^FederalAgencyIEN^GovernmentEmployeeFlag^GovernmentEmployeeFlagCode^InsuranceCoverageFlag^InsuranceCoverageFlagCode^VietnamServiceFlag^VietnamServiceFlagCode^AgentOrangeExposureFlag^AgentOrangeExposureFlagCode^IonizingRadiationExposureFlag^IonizingRadiationExposureFlagCode^SHADFlag^SHADFlagCode^RadiationExposureCode^RadiationExposureCodeCode^AgentOrangeLocationCode^AgentOrangeLocationCodeCode^FilipinoVeteranCode^FilipinoVeteranCodeCode^SouthwestAsiaCondition^SouthwestAsiaConditionCode^PeriodOfServiceIEN^DeathDateTime^DeathFMDate^DeathEnteredByStaffIEN^DeathNotificationSource^DeathModifiedDateTime^DeathModifiedFMDate^DeathLastUpdatedByStaffIEN^CollateralSponsorPatientIEN^EligibilityIEN^EligibilityVACode^EligibilityStatus^EligibilityStatusCode^EligibilityStatusDateTime^EligibilityStatusFMDate^EligibilityVerificationSource^EligibilityVerificationSourceCode^EligibilityInterimDateTime^EligibilityInterimFMDate^EligibilityVerificationMethod^EligibilityEnteredStaffIEN^MedicaidEligibleFlag^MedicaidEligibleFlagCode^MedicaidInquireDateTime^MedicaidInquireFMDate^MedicaidNumber^POWFlag^POWFlagCode^POWLocationIEN^CombatFlag^CombatFlagCode^CombatFromDate^CombatFromFMDate^CombatToDate^CombatToFMDate^CombatEligibilityEndDate^CombatEligibilityEndFMDate^TestPatientFlag^TestPatientFlagCode^CurrentEnrollmentIEN^PreferredInstitutionIEN^PatientTypeIEN^PatientICN^FugitiveFelonFlag^FugitiveFelonFlagCode^FFFEnteredStaffIEN^FFFEnteredDateTime^FFFEnteredFMDate^FFFRemovedStaffIEN^FFFRemovedDateTime^FFFRemovedFMDate^FFFRemovedReason^VeteranFlag^VeteranFlagCode^ODSTreatmentDateTime^ODSTreatmentFMDate^ODSRecalledCode^ODSRecalledCodeCode^ODSRankType^OperationDesertShieldRank^SensitiveFlag^SensitiveFlagCode^PreferredInstitutionSource^PreferredInstitutionSourceCode^VeteranTransportationProgramFlag^VeteranTransportationProgramFlagCode^SelfIdentifiedGender^SelfIdentifiedGenderCode^DeathDocumentationType^OpCode^VistaCreateDate^VistaEditDate"
}

ClassMethod RemoveObject(Sta3n As %Integer, FMPK As %String) As %Integer
{
	Set Status=1
	Set VistaSite=##class(VX130.VistaSite).%OpenId(Sta3n)
	Set NS=VistaSite.VistaSiteNamespace
	Set PatientIEN=$Piece(FMPK,",",1)
	Quit:(+PatientIEN'>0) "1^PatientIEN Not Numeric"

	// mlb: 209-07-23: Replaced Old code to call UpdateObject when Patient record is not deleted.
	//Quit:$Get(^|NS|DPT(PatientIEN,0))'="" "1" // Record is not deleted.
	Quit:$Get(^|NS|DPT(PatientIEN,0))'="" ..UpdateObject(Sta3n,FMPK) // Record is not deleted.
	Set id=Sta3n_"||"_PatientIEN
	Set oref=..%OpenId(id,4,.Status)
	If '$$$ISOK(Status) {
		If $System.Status.GetErrorCodes(Status)'=5809 {
			// Error is not because the object does not exist.  Probably can't get lock.
			do ..CleanUp()
			Quit Status
		} Else {
			Quit 1 // Error is because record does not exist so don't have to delete.
		}
	} // Either got lock or object does not exist.
	If $IsObject(oref) {
		Set oref.OpCode="D"
		Set oref.VistaEditDate=$ZDateTime($ZTIMESTAMP,3)
		Set Status=oref.%Save()
	}
	do ..CleanUp()
	Quit Status
}

ClassMethod ToFlatFileRecord(id As %String) As %String
{
	Set oref=..%OpenId(id,4,.sc)
	Set OutputRecord=""
	If $IsObject(oref) {
		Set OutputRecord=oref.Sta3n_
		"^"_oref.PatientIEN_
		"^"_oref.PatientFirstName_
		"^"_oref.PatientLastName_
		"^"_oref.PatientName_
		"^"_oref.Gender_
		"^"_oref.GenderCode_
		"^"_oref.BirthDateTime_
		"^"_oref.BirthFMDate_
		"^"_oref.MaritalStatusIEN_
		"^"_oref.ReligionIEN_
		"^"_oref.DuplicateRecordStatus_
		"^"_oref.DuplicateRecordStatusCode_
		"^"_oref.DestinationMergePatientIEN_
		"^"_oref.PatientSSN_
		"^"_oref.ScrSSN_
		"^"_oref.PseudoSSNReason_
		"^"_oref.PseudoSSNReasonCode_
		"^"_oref.SSNVerificationStatus_
		"^"_oref.SSNVerificationStatusCode_
		"^"_oref.PatientEnteredRemark_
		"^"_oref.PatientEnteredByStaffIEN_
		"^"_oref.PatientEnteredDateTime_
		"^"_oref.PatientEnteredFMDate_
		"^"_oref.PatientEnteredCode_
		"^"_oref.PatientEnteredCodeCode_
		"^"_oref.StreetAddress1_
		"^"_oref.Zip4_
		"^"_oref.StreetAddress2_
		"^"_oref.City_
		"^"_oref.StateIEN_
		"^"_oref.Zip_
		"^"_oref.StateCountyIEN_
		"^"_oref.BadAddressIndicator_
		"^"_oref.BadAddressIndicatorCode_
		"^"_oref.CurrentMeansTestStatusIEN_
		"^"_oref.IneligibleDateTime_
		"^"_oref.IneligibleFMDate_
		"^"_oref.PatientMissingDateTime_
		"^"_oref.PatientMissingFMDate_
		"^"_oref.IneligibleSource_
		"^"_oref.IneligibleSourceCode_
		"^"_oref.IneligibleCity_
		"^"_oref.IneligibleStateIEN_
		"^"_oref.IneligibleVAROReason_
		"^"_oref.PatientMissingSource_
		"^"_oref.PatientMissingSourceCode_
		"^"_oref.PatientMissingCity_
		"^"_oref.PatientMissingStateIEN_
		"^"_oref.EmergencyResponseIndicator_
		"^"_oref.EmergencyResponseIndicatorCode_
		"^"_oref.ServiceConnectedFlag_
		"^"_oref.ServiceConnectedFlagCode_
		"^"_oref.PercentServiceConnect_
		"^"_oref.IneligibleReason_
		"^"_oref.FederalAgencyIEN_
		"^"_oref.GovernmentEmployeeFlag_
		"^"_oref.GovernmentEmployeeFlagCode_
		"^"_oref.InsuranceCoverageFlag_
		"^"_oref.InsuranceCoverageFlagCode_
		"^"_oref.VietnamServiceFlag_
		"^"_oref.VietnamServiceFlagCode_
		"^"_oref.AgentOrangeExposureFlag_
		"^"_oref.AgentOrangeExposureFlagCode_
		"^"_oref.IonizingRadiationExposureFlag_
		"^"_oref.IonizingRadiationExposureFlagCode_
		"^"_oref.SHADFlag_
		"^"_oref.SHADFlagCode_
		"^"_oref.RadiationExposureCode_
		"^"_oref.RadiationExposureCodeCode_
		"^"_oref.AgentOrangeLocationCode_
		"^"_oref.AgentOrangeLocationCodeCode_
		"^"_oref.FilipinoVeteranCode_
		"^"_oref.FilipinoVeteranCodeCode_
		"^"_oref.SouthwestAsiaCondition_
		"^"_oref.SouthwestAsiaConditionCode_
		"^"_oref.PeriodOfServiceIEN_
		"^"_oref.DeathDateTime_
		"^"_oref.DeathFMDate_
		"^"_oref.DeathEnteredByStaffIEN_
		"^"_oref.DeathNotificationSource_
		"^"_oref.DeathModifiedDateTime_
		"^"_oref.DeathModifiedFMDate_
		"^"_oref.DeathLastUpdatedByStaffIEN_
		"^"_oref.CollateralSponsorPatientIEN_
		"^"_oref.EligibilityIEN_
		"^"_oref.EligibilityVACode_
		"^"_oref.EligibilityStatus_
		"^"_oref.EligibilityStatusCode_
		"^"_oref.EligibilityStatusDateTime_
		"^"_oref.EligibilityStatusFMDate_
		"^"_oref.EligibilityVerificationSource_
		"^"_oref.EligibilityVerificationSourceCode_
		"^"_oref.EligibilityInterimDateTime_
		"^"_oref.EligibilityInterimFMDate_
		"^"_oref.EligibilityVerificationMethod_
		"^"_oref.EligibilityEnteredStaffIEN_
		"^"_oref.MedicaidEligibleFlag_
		"^"_oref.MedicaidEligibleFlagCode_
		"^"_oref.MedicaidInquireDateTime_
		"^"_oref.MedicaidInquireFMDate_
		"^"_oref.MedicaidNumber_
		"^"_oref.POWFlag_
		"^"_oref.POWFlagCode_
		"^"_oref.POWLocationIEN_
		"^"_oref.CombatFlag_
		"^"_oref.CombatFlagCode_
		"^"_oref.CombatFromDate_
		"^"_oref.CombatFromFMDate_
		"^"_oref.CombatToDate_
		"^"_oref.CombatToFMDate_
		"^"_oref.CombatEligibilityEndDate_
		"^"_oref.CombatEligibilityEndFMDate_
		"^"_oref.TestPatientFlag_
		"^"_oref.TestPatientFlagCode_
		"^"_oref.CurrentEnrollmentIEN_
		"^"_oref.PreferredInstitutionIEN_
		"^"_oref.PatientTypeIEN_
		"^"_oref.PatientICN_
		"^"_oref.FugitiveFelonFlag_
		"^"_oref.FugitiveFelonFlagCode_
		"^"_oref.FFFEnteredStaffIEN_
		"^"_oref.FFFEnteredDateTime_
		"^"_oref.FFFEnteredFMDate_
		"^"_oref.FFFRemovedStaffIEN_
		"^"_oref.FFFRemovedDateTime_
		"^"_oref.FFFRemovedFMDate_
		"^"_oref.FFFRemovedReason_
		"^"_oref.VeteranFlag_
		"^"_oref.VeteranFlagCode_
		"^"_oref.ODSTreatmentDateTime_
		"^"_oref.ODSTreatmentFMDate_
		"^"_oref.ODSRecalledCode_
		"^"_oref.ODSRecalledCodeCode_
		"^"_oref.ODSRankType_
		"^"_oref.OperationDesertShieldRank_
		"^"_oref.SensitiveFlag_
		"^"_oref.SensitiveFlagCode_
		"^"_oref.PreferredInstitutionSource_
		"^"_oref.PreferredInstitutionSourceCode_
		"^"_oref.VeteranTransportationProgramFlag_
		"^"_oref.VeteranTransportationProgramFlagCode_
		"^"_oref.SelfIdentifiedGender_
		"^"_oref.SelfIdentifiedGenderCode_
		"^"_oref.DeathDocumentationType_
		"^"_oref.OpCode_
		"^"_oref.VistaCreateDate_
		"^"_oref.VistaEditDate
	}
	Quit OutputRecord
}

ClassMethod UpdateObject(Sta3n As %Integer, FMPK As %String, DataQuality As %Boolean = 0, HistoricalPull As %Boolean = 0, ReCheck As %Boolean = 0) As %Integer
{
	Set Status=1
	Set VistaSite=##class(VX130.VistaSite).%OpenId(Sta3n)
	Set NS=VistaSite.Sta3a
	Set LogEdits=0
	Kill BitFlag

	Set PatientIEN=$Piece(FMPK,",",1)
	Quit:(+PatientIEN'>0) "1^PatientIEN Not found in FMPK"

	If ($Get(^|NS|DPT(PatientIEN,0))="")
	{
		// Record with these iens not found In VISTA.  Check to see if we need to set OpCode.
		Do ..RemoveObject(Sta3n,FMPK)
		Quit "1^Zero Node Not Found in VISTA"
	}
	Set id=Sta3n_"||"_PatientIEN
	Set oref=..%OpenId(id,4,.Status)

	If '$$$ISOK(Status) {
		If $System.Status.GetErrorCodes(Status)'=5809 {
			// Error is not because the object does not exist.  Probably can't get lock.
			do ..CleanUp()
			Quit Status
		}
	} // Either got lock or object does not exist yet.

	If '$IsObject(oref) {
		Set oref=..%New()
		Set oref.Sta3n=Sta3n
		Set oref.PatientIEN=PatientIEN
		Set oref.VistaCreateDate=$Case(HistoricalPull,1:"1900-01-01",:$ZDateTime($ZTIMESTAMP,3))
		Set oref.OpCode=""
		Set $Bit(BitFlag,1)=1
	}
	Set $Bit(BitFlag,2)=oref.setPatientFirstName(NS,PatientIEN)
	Set $Bit(BitFlag,3)=oref.setPatientLastName(NS,PatientIEN)
	Set $Bit(BitFlag,4)=oref.setPatientName(NS,PatientIEN)
	Set $Bit(BitFlag,5)=oref.setGender(NS,PatientIEN)
	Set $Bit(BitFlag,6)=oref.setGenderCode(NS,PatientIEN)
	Set $Bit(BitFlag,7)=oref.setBirthDateTime(NS,PatientIEN)
	Set $Bit(BitFlag,8)=oref.setBirthFMDate(NS,PatientIEN)
	Set $Bit(BitFlag,9)=oref.setMaritalStatusIEN(NS,PatientIEN)
	Set $Bit(BitFlag,10)=oref.setReligionIEN(NS,PatientIEN)
	Set $Bit(BitFlag,11)=oref.setDuplicateRecordStatus(NS,PatientIEN)
	Set $Bit(BitFlag,12)=oref.setDuplicateRecordStatusCode(NS,PatientIEN)
	Set $Bit(BitFlag,13)=oref.setDestinationMergePatientIEN(NS,PatientIEN)
	Set $Bit(BitFlag,14)=oref.setPatientSSN(NS,PatientIEN)
	Set $Bit(BitFlag,15)=oref.setScrSSN(NS,PatientIEN)
	Set $Bit(BitFlag,16)=oref.setPseudoSSNReason(NS,PatientIEN)
	Set $Bit(BitFlag,17)=oref.setPseudoSSNReasonCode(NS,PatientIEN)
	Set $Bit(BitFlag,18)=oref.setSSNVerificationStatus(NS,PatientIEN)
	Set $Bit(BitFlag,19)=oref.setSSNVerificationStatusCode(NS,PatientIEN)
	Set $Bit(BitFlag,20)=oref.setPatientEnteredRemark(NS,PatientIEN)
	Set $Bit(BitFlag,21)=oref.setPatientEnteredByStaffIEN(NS,PatientIEN)
	Set $Bit(BitFlag,22)=oref.setPatientEnteredDateTime(NS,PatientIEN)
	Set $Bit(BitFlag,23)=oref.setPatientEnteredFMDate(NS,PatientIEN)
	Set $Bit(BitFlag,24)=oref.setPatientEnteredCode(NS,PatientIEN)
	Set $Bit(BitFlag,25)=oref.setPatientEnteredCodeCode(NS,PatientIEN)
	Set $Bit(BitFlag,26)=oref.setStreetAddress1(NS,PatientIEN)
	Set $Bit(BitFlag,27)=oref.setZip4(NS,PatientIEN)
	Set $Bit(BitFlag,28)=oref.setStreetAddress2(NS,PatientIEN)
	Set $Bit(BitFlag,29)=oref.setCity(NS,PatientIEN)
	Set $Bit(BitFlag,30)=oref.setStateIEN(NS,PatientIEN)
	Set $Bit(BitFlag,31)=oref.setZip(NS,PatientIEN)
	Set $Bit(BitFlag,32)=oref.setStateCountyIEN(NS,PatientIEN)
	Set $Bit(BitFlag,33)=oref.setBadAddressIndicator(NS,PatientIEN)
	Set $Bit(BitFlag,34)=oref.setBadAddressIndicatorCode(NS,PatientIEN)
	Set $Bit(BitFlag,35)=oref.setCurrentMeansTestStatusIEN(NS,PatientIEN)
	Set $Bit(BitFlag,36)=oref.setIneligibleDateTime(NS,PatientIEN)
	Set $Bit(BitFlag,37)=oref.setIneligibleFMDate(NS,PatientIEN)
	Set $Bit(BitFlag,38)=oref.setPatientMissingDateTime(NS,PatientIEN)
	Set $Bit(BitFlag,39)=oref.setPatientMissingFMDate(NS,PatientIEN)
	Set $Bit(BitFlag,40)=oref.setIneligibleSource(NS,PatientIEN)
	Set $Bit(BitFlag,41)=oref.setIneligibleSourceCode(NS,PatientIEN)
	Set $Bit(BitFlag,42)=oref.setIneligibleCity(NS,PatientIEN)
	Set $Bit(BitFlag,43)=oref.setIneligibleStateIEN(NS,PatientIEN)
	Set $Bit(BitFlag,44)=oref.setIneligibleVAROReason(NS,PatientIEN)
	Set $Bit(BitFlag,45)=oref.setPatientMissingSource(NS,PatientIEN)
	Set $Bit(BitFlag,46)=oref.setPatientMissingSourceCode(NS,PatientIEN)
	Set $Bit(BitFlag,47)=oref.setPatientMissingCity(NS,PatientIEN)
	Set $Bit(BitFlag,48)=oref.setPatientMissingStateIEN(NS,PatientIEN)
	Set $Bit(BitFlag,49)=oref.setEmergencyResponseIndicator(NS,PatientIEN)
	Set $Bit(BitFlag,50)=oref.setEmergencyResponseIndicatorCode(NS,PatientIEN)
	Set $Bit(BitFlag,51)=oref.setServiceConnectedFlag(NS,PatientIEN)
	Set $Bit(BitFlag,52)=oref.setServiceConnectedFlagCode(NS,PatientIEN)
	Set $Bit(BitFlag,53)=oref.setPercentServiceConnect(NS,PatientIEN)
	Set $Bit(BitFlag,54)=oref.setIneligibleReason(NS,PatientIEN)
	Set $Bit(BitFlag,55)=oref.setFederalAgencyIEN(NS,PatientIEN)
	Set $Bit(BitFlag,56)=oref.setGovernmentEmployeeFlag(NS,PatientIEN)
	Set $Bit(BitFlag,57)=oref.setGovernmentEmployeeFlagCode(NS,PatientIEN)
	Set $Bit(BitFlag,58)=oref.setInsuranceCoverageFlag(NS,PatientIEN)
	Set $Bit(BitFlag,59)=oref.setInsuranceCoverageFlagCode(NS,PatientIEN)
	Set $Bit(BitFlag,60)=oref.setVietnamServiceFlag(NS,PatientIEN)
	Set $Bit(BitFlag,61)=oref.setVietnamServiceFlagCode(NS,PatientIEN)
	Set $Bit(BitFlag,62)=oref.setAgentOrangeExposureFlag(NS,PatientIEN)
	Set $Bit(BitFlag,63)=oref.setAgentOrangeExposureFlagCode(NS,PatientIEN)
	Set $Bit(BitFlag,64)=oref.setIonizingRadiationExposureFlag(NS,PatientIEN)
	Set $Bit(BitFlag,65)=oref.setIonizingRadiationExposureFlagCode(NS,PatientIEN)
	Set $Bit(BitFlag,66)=oref.setSHADFlag(NS,PatientIEN)
	Set $Bit(BitFlag,67)=oref.setSHADFlagCode(NS,PatientIEN)
	Set $Bit(BitFlag,68)=oref.setRadiationExposureCode(NS,PatientIEN)
	Set $Bit(BitFlag,69)=oref.setRadiationExposureCodeCode(NS,PatientIEN)
	Set $Bit(BitFlag,70)=oref.setAgentOrangeLocationCode(NS,PatientIEN)
	Set $Bit(BitFlag,71)=oref.setAgentOrangeLocationCodeCode(NS,PatientIEN)
	Set $Bit(BitFlag,72)=oref.setFilipinoVeteranCode(NS,PatientIEN)
	Set $Bit(BitFlag,73)=oref.setFilipinoVeteranCodeCode(NS,PatientIEN)
	Set $Bit(BitFlag,74)=oref.setSouthwestAsiaCondition(NS,PatientIEN)
	Set $Bit(BitFlag,75)=oref.setSouthwestAsiaConditionCode(NS,PatientIEN)
	Set $Bit(BitFlag,76)=oref.setPeriodOfServiceIEN(NS,PatientIEN)
	Set $Bit(BitFlag,77)=oref.setDeathDateTime(NS,PatientIEN)
	Set $Bit(BitFlag,78)=oref.setDeathFMDate(NS,PatientIEN)
	Set $Bit(BitFlag,79)=oref.setDeathEnteredByStaffIEN(NS,PatientIEN)
	Set $Bit(BitFlag,80)=oref.setDeathNotificationSource(NS,PatientIEN)
	Set $Bit(BitFlag,81)=oref.setDeathModifiedDateTime(NS,PatientIEN)
	Set $Bit(BitFlag,82)=oref.setDeathModifiedFMDate(NS,PatientIEN)
	Set $Bit(BitFlag,83)=oref.setDeathLastUpdatedByStaffIEN(NS,PatientIEN)
	Set $Bit(BitFlag,84)=oref.setCollateralSponsorPatientIEN(NS,PatientIEN)
	Set $Bit(BitFlag,85)=oref.setEligibilityIEN(NS,PatientIEN)
	Set $Bit(BitFlag,86)=oref.setEligibilityVACode(NS,PatientIEN)
	Set $Bit(BitFlag,87)=oref.setEligibilityStatus(NS,PatientIEN)
	Set $Bit(BitFlag,88)=oref.setEligibilityStatusCode(NS,PatientIEN)
	Set $Bit(BitFlag,89)=oref.setEligibilityStatusDateTime(NS,PatientIEN)
	Set $Bit(BitFlag,90)=oref.setEligibilityStatusFMDate(NS,PatientIEN)
	Set $Bit(BitFlag,91)=oref.setEligibilityVerificationSource(NS,PatientIEN)
	Set $Bit(BitFlag,92)=oref.setEligibilityVerificationSourceCode(NS,PatientIEN)
	Set $Bit(BitFlag,93)=oref.setEligibilityInterimDateTime(NS,PatientIEN)
	Set $Bit(BitFlag,94)=oref.setEligibilityInterimFMDate(NS,PatientIEN)
	Set $Bit(BitFlag,95)=oref.setEligibilityVerificationMethod(NS,PatientIEN)
	Set $Bit(BitFlag,96)=oref.setEligibilityEnteredStaffIEN(NS,PatientIEN)
	Set $Bit(BitFlag,97)=oref.setMedicaidEligibleFlag(NS,PatientIEN)
	Set $Bit(BitFlag,98)=oref.setMedicaidEligibleFlagCode(NS,PatientIEN)
	Set $Bit(BitFlag,99)=oref.setMedicaidInquireDateTime(NS,PatientIEN)
	Set $Bit(BitFlag,100)=oref.setMedicaidInquireFMDate(NS,PatientIEN)
	Set $Bit(BitFlag,101)=oref.setMedicaidNumber(NS,PatientIEN)
	Set $Bit(BitFlag,102)=oref.setPOWFlag(NS,PatientIEN)
	Set $Bit(BitFlag,103)=oref.setPOWFlagCode(NS,PatientIEN)
	Set $Bit(BitFlag,104)=oref.setPOWLocationIEN(NS,PatientIEN)
	Set $Bit(BitFlag,105)=oref.setCombatFlag(NS,PatientIEN)
	Set $Bit(BitFlag,106)=oref.setCombatFlagCode(NS,PatientIEN)
	Set $Bit(BitFlag,107)=oref.setCombatFromDate(NS,PatientIEN)
	Set $Bit(BitFlag,108)=oref.setCombatFromFMDate(NS,PatientIEN)
	Set $Bit(BitFlag,109)=oref.setCombatToDate(NS,PatientIEN)
	Set $Bit(BitFlag,110)=oref.setCombatToFMDate(NS,PatientIEN)
	Set $Bit(BitFlag,111)=oref.setCombatEligibilityEndDate(NS,PatientIEN)
	Set $Bit(BitFlag,112)=oref.setCombatEligibilityEndFMDate(NS,PatientIEN)
	Set $Bit(BitFlag,113)=oref.setTestPatientFlag(NS,PatientIEN)
	Set $Bit(BitFlag,114)=oref.setTestPatientFlagCode(NS,PatientIEN)
	Set $Bit(BitFlag,115)=oref.setCurrentEnrollmentIEN(NS,PatientIEN)
	Set $Bit(BitFlag,116)=oref.setPreferredInstitutionIEN(NS,PatientIEN)
	Set $Bit(BitFlag,117)=oref.setPatientTypeIEN(NS,PatientIEN)
	Set $Bit(BitFlag,118)=oref.setPatientICN(NS,PatientIEN)
	Set $Bit(BitFlag,119)=oref.setFugitiveFelonFlag(NS,PatientIEN)
	Set $Bit(BitFlag,120)=oref.setFugitiveFelonFlagCode(NS,PatientIEN)
	Set $Bit(BitFlag,121)=oref.setFFFEnteredStaffIEN(NS,PatientIEN)
	Set $Bit(BitFlag,122)=oref.setFFFEnteredDateTime(NS,PatientIEN)
	Set $Bit(BitFlag,123)=oref.setFFFEnteredFMDate(NS,PatientIEN)
	Set $Bit(BitFlag,124)=oref.setFFFRemovedStaffIEN(NS,PatientIEN)
	Set $Bit(BitFlag,125)=oref.setFFFRemovedDateTime(NS,PatientIEN)
	Set $Bit(BitFlag,126)=oref.setFFFRemovedFMDate(NS,PatientIEN)
	Set $Bit(BitFlag,127)=oref.setFFFRemovedReason(NS,PatientIEN)
	Set $Bit(BitFlag,128)=oref.setVeteranFlag(NS,PatientIEN)
	Set $Bit(BitFlag,129)=oref.setVeteranFlagCode(NS,PatientIEN)
	Set $Bit(BitFlag,130)=oref.setODSTreatmentDateTime(NS,PatientIEN)
	Set $Bit(BitFlag,131)=oref.setODSTreatmentFMDate(NS,PatientIEN)
	Set $Bit(BitFlag,132)=oref.setODSRecalledCode(NS,PatientIEN)
	Set $Bit(BitFlag,133)=oref.setODSRecalledCodeCode(NS,PatientIEN)
	Set $Bit(BitFlag,134)=oref.setODSRankType(NS,PatientIEN)
	Set $Bit(BitFlag,135)=oref.setOperationDesertShieldRank(NS,PatientIEN)
	Set $Bit(BitFlag,136)=oref.setSensitiveFlag(NS,PatientIEN)
	Set $Bit(BitFlag,137)=oref.setSensitiveFlagCode(NS,PatientIEN)
	Set $Bit(BitFlag,138)=oref.setPreferredInstitutionSource(NS,PatientIEN)
	Set $Bit(BitFlag,139)=oref.setPreferredInstitutionSourceCode(NS,PatientIEN)
	Set $Bit(BitFlag,140)=oref.setVeteranTransportationProgramFlag(NS,PatientIEN)
	Set $Bit(BitFlag,141)=oref.setVeteranTransportationProgramFlagCode(NS,PatientIEN)
	Set $Bit(BitFlag,142)=oref.setSelfIdentifiedGender(NS,PatientIEN)
	Set $Bit(BitFlag,143)=oref.setSelfIdentifiedGenderCode(NS,PatientIEN)
	Set $Bit(BitFlag,144)=oref.setDeathDocumentationType(NS,PatientIEN)
	If oref.OpCode]"" {
		Set oref.OpCode=""
		Set $Bit(BitFlag,145)=1
	}
	If $BitFind(BitFlag,1)>0 {
		// Something changed.
		If LogEdits {
			Write ..%ClassName(1),id," "
			For zz=1:1:144 {
				Write $Bit(BitFlag,zz)
			}
			Write !
			//Read zzz
		}
		If $Get(DataQuality) {
			//Give the process time to find the update in the journal files.
			//Add difference to QC.Detail but don't save object.
			//Set qcid =##class(QC.QualityCheckHistory).GetID("VISTA",Sta3n,..%ClassName(1))
			//Do ##class(QC.Detail).AddEntry(qcid,Sta3n_"||"_PatientIEN,BitFlag)
			Quit:'ReCheck 1
		}
		Set oref.VistaEditDate=$ZDateTime($ZTIMESTAMP,3)
		Set Status=oref.%Save()
	}
	Do ..CleanUp()
	Quit Status
}

Method setAgentOrangeExposureFlag(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set AgentOrangeExposureFlag=$Piece($Get(^|NS|DPT(PatientIEN,.321)),"^",2)
	Set AgentOrangeExposureFlag=$Case(AgentOrangeExposureFlag,"Y":"Y","N":"N","U":"U",:$Extract(AgentOrangeExposureFlag,1))
	Set AgentOrangeExposureFlag=$Extract(AgentOrangeExposureFlag,1,1)
	If ..AgentOrangeExposureFlag'=AgentOrangeExposureFlag {
		Set ..AgentOrangeExposureFlag=AgentOrangeExposureFlag
		Set Flag=1
	}
	Kill AgentOrangeExposureFlag
	Quit Flag
}

Method setAgentOrangeExposureFlagCode(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set AgentOrangeExposureFlagCode=$Piece($Get(^|NS|DPT(PatientIEN,.321)),"^",2)
	Set AgentOrangeExposureFlagCode=$Extract(AgentOrangeExposureFlagCode,1,50)
	If ..AgentOrangeExposureFlagCode'=AgentOrangeExposureFlagCode {
		Set ..AgentOrangeExposureFlagCode=AgentOrangeExposureFlagCode
		Set Flag=1
	}
	Kill AgentOrangeExposureFlagCode
	Quit Flag
}

Method setAgentOrangeLocationCode(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set AgentOrangeLocationCode=$Piece($Get(^|NS|DPT(PatientIEN,.321)),"^",13)
	If AgentOrangeLocationCode]"" {
		Set Codes=$Piece($Get(^|NS|DD(2,.3213,0)),"^",3)
		Set zz=1
		While ($Piece(Codes,";",zz)]"") {
			Set Code=$Piece($Piece(Codes,";",zz),":",1)
			If (Code=AgentOrangeLocationCode) {
				Set AgentOrangeLocationCode=$Piece($Piece(Codes,";",zz),":",2)
			}
			Set zz=zz+1
		}
		Kill zz,Codes,Code
		}
	Set AgentOrangeLocationCode=$Extract(AgentOrangeLocationCode,1,50)
	If ..AgentOrangeLocationCode'=AgentOrangeLocationCode {
		Set ..AgentOrangeLocationCode=AgentOrangeLocationCode
		Set Flag=1
	}
	Kill AgentOrangeLocationCode
	Quit Flag
}

Method setAgentOrangeLocationCodeCode(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set AgentOrangeLocationCodeCode=$Piece($Get(^|NS|DPT(PatientIEN,.321)),"^",13)
	Set AgentOrangeLocationCodeCode=$Extract(AgentOrangeLocationCodeCode,1,50)
	If ..AgentOrangeLocationCodeCode'=AgentOrangeLocationCodeCode {
		Set ..AgentOrangeLocationCodeCode=AgentOrangeLocationCodeCode
		Set Flag=1
	}
	Kill AgentOrangeLocationCodeCode
	Quit Flag
}

Method setBadAddressIndicator(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set BadAddressIndicator=$Piece($Get(^|NS|DPT(PatientIEN,.11)),"^",16)
	If BadAddressIndicator]"" {
		Set Codes=$Piece($Get(^|NS|DD(2,.121,0)),"^",3)
		Set zz=1
		While ($Piece(Codes,";",zz)]"") {
			Set Code=$Piece($Piece(Codes,";",zz),":",1)
			If (Code=BadAddressIndicator) {
				Set BadAddressIndicator=$Piece($Piece(Codes,";",zz),":",2)
			}
			Set zz=zz+1
		}
		Kill zz,Codes,Code
		}
	Set BadAddressIndicator=$Extract(BadAddressIndicator,1,50)
	If ..BadAddressIndicator'=BadAddressIndicator {
		Set ..BadAddressIndicator=BadAddressIndicator
		Set Flag=1
	}
	Kill BadAddressIndicator
	Quit Flag
}

Method setBadAddressIndicatorCode(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set BadAddressIndicatorCode=$Piece($Get(^|NS|DPT(PatientIEN,.11)),"^",16)
	Set BadAddressIndicatorCode=$Extract(BadAddressIndicatorCode,1,50)
	If ..BadAddressIndicatorCode'=BadAddressIndicatorCode {
		Set ..BadAddressIndicatorCode=BadAddressIndicatorCode
		Set Flag=1
	}
	Kill BadAddressIndicatorCode
	Quit Flag
}

Method setBirthDateTime(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set BirthDateTime=$Piece($Get(^|NS|DPT(PatientIEN,0)),"^",3)
	If ('##class(%FilemanTimeStamp).IsValid(BirthDateTime)) {
		Set BirthDateTime=""
	}
	If ..BirthDateTime'=BirthDateTime {
		Set ..BirthDateTime=BirthDateTime
		Set Flag=1
	}
	Kill BirthDateTime
	Quit Flag
}

Method setBirthFMDate(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set BirthFMDate=$Piece($Get(^|NS|DPT(PatientIEN,0)),"^",3)
	Set BirthFMDate=$Extract(BirthFMDate,1,50)
	If ..BirthFMDate'=BirthFMDate {
		Set ..BirthFMDate=BirthFMDate
		Set Flag=1
	}
	Quit Flag
}

Method setCity(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set City=$Piece($Get(^|NS|DPT(PatientIEN,.11)),"^",4)
	Set City=$Extract(City,1,50)
	If ..City'=City {
		Set ..City=City
		Set Flag=1
	}
	Quit Flag
}

Method setCollateralSponsorPatientIEN(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set CollateralSponsorPatientIEN=$Piece($Get(^|NS|DPT(PatientIEN,.36)),"^",11)
	Set CollateralSponsorPatientIEN=$Extract(CollateralSponsorPatientIEN,1,50)
	If ..CollateralSponsorPatientIEN'=CollateralSponsorPatientIEN {
		Set ..CollateralSponsorPatientIEN=CollateralSponsorPatientIEN
		Set Flag=1
	}
	Quit Flag
}

Method setCombatEligibilityEndDate(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set CombatEligibilityEndDate=$Piece($Get(^|NS|DPT(PatientIEN,.52)),"^",15)
	If ('##class(%FilemanDate).IsValid(CombatEligibilityEndDate)) {
		Set CombatEligibilityEndDate=""
	}
	If ..CombatEligibilityEndDate'=CombatEligibilityEndDate {
		Set ..CombatEligibilityEndDate=CombatEligibilityEndDate
		Set Flag=1
	}
	Quit Flag
}

Method setCombatEligibilityEndFMDate(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set CombatEligibilityEndFMDate=$Piece($Get(^|NS|DPT(PatientIEN,.52)),"^",15)
	Set CombatEligibilityEndFMDate=$Extract(CombatEligibilityEndFMDate,1,50)
	If ..CombatEligibilityEndFMDate'=CombatEligibilityEndFMDate {
		Set ..CombatEligibilityEndFMDate=CombatEligibilityEndFMDate
		Set Flag=1
	}
	Quit Flag
}

Method setCombatFlag(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set CombatFlag=$Piece($Get(^|NS|DPT(PatientIEN,.52)),"^",11)
	Set CombatFlag=$Case(CombatFlag,"Y":"Y","N":"N",:$Extract(CombatFlag,1))
	Set CombatFlag=$Extract(CombatFlag,1,1)
	If ..CombatFlag'=CombatFlag {
		Set ..CombatFlag=CombatFlag
		Set Flag=1
	}
	Quit Flag
}

Method setCombatFlagCode(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set CombatFlagCode=$Piece($Get(^|NS|DPT(PatientIEN,.52)),"^",11)
	Set CombatFlagCode=$Extract(CombatFlagCode,1,50)
	If ..CombatFlagCode'=CombatFlagCode {
		Set ..CombatFlagCode=CombatFlagCode
		Set Flag=1
	}
	Quit Flag
}

Method setCombatFromDate(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set CombatFromDate=$Piece($Get(^|NS|DPT(PatientIEN,.52)),"^",13)
	If ('##class(%FilemanDate).IsValid(CombatFromDate)) {
		Set CombatFromDate=""
	}
	If ..CombatFromDate'=CombatFromDate {
		Set ..CombatFromDate=CombatFromDate
		Set Flag=1
	}
	Quit Flag
}

Method setCombatFromFMDate(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set CombatFromFMDate=$Piece($Get(^|NS|DPT(PatientIEN,.52)),"^",13)
	Set CombatFromFMDate=$Extract(CombatFromFMDate,1,50)
	If ..CombatFromFMDate'=CombatFromFMDate {
		Set ..CombatFromFMDate=CombatFromFMDate
		Set Flag=1
	}
	Quit Flag
}

Method setCombatToDate(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set CombatToDate=$Piece($Get(^|NS|DPT(PatientIEN,.52)),"^",14)
	If ('##class(%FilemanDate).IsValid(CombatToDate)) {
		Set CombatToDate=""
	}
	If ..CombatToDate'=CombatToDate {
		Set ..CombatToDate=CombatToDate
		Set Flag=1
	}
	Quit Flag
}

Method setCombatToFMDate(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set CombatToFMDate=$Piece($Get(^|NS|DPT(PatientIEN,.52)),"^",14)
	Set CombatToFMDate=$Extract(CombatToFMDate,1,50)
	If ..CombatToFMDate'=CombatToFMDate {
		Set ..CombatToFMDate=CombatToFMDate
		Set Flag=1
	}
	Quit Flag
}

Method setCurrentEnrollmentIEN(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set CurrentEnrollmentIEN=$Piece($Get(^|NS|DPT(PatientIEN,"ENR")),"^",1)
	Set CurrentEnrollmentIEN=$Extract(CurrentEnrollmentIEN,1,50)
	If ..CurrentEnrollmentIEN'=CurrentEnrollmentIEN {
		Set ..CurrentEnrollmentIEN=CurrentEnrollmentIEN
		Set Flag=1
	}
	Quit Flag
}

Method setCurrentMeansTestStatusIEN(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set CurrentMeansTestStatusIEN=$Piece($Get(^|NS|DPT(PatientIEN,0)),"^",14)
	Set CurrentMeansTestStatusIEN=$Extract(CurrentMeansTestStatusIEN,1,50)
	If ..CurrentMeansTestStatusIEN'=CurrentMeansTestStatusIEN {
		Set ..CurrentMeansTestStatusIEN=CurrentMeansTestStatusIEN
		Set Flag=1
	}
	Quit Flag
}

Method setDeathDateTime(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set DeathDateTime=$Piece($Get(^|NS|DPT(PatientIEN,.35)),"^",1)
	If ('##class(%FilemanTimeStamp).IsValid(DeathDateTime)) {
		Set DeathDateTime=""
	}
	If ..DeathDateTime'=DeathDateTime {
		Set ..DeathDateTime=DeathDateTime
		Set Flag=1
	}
	Quit Flag
}

Method setDeathDocumentationType(NS As %String, PatientIEN As %String) As %Integer
{
	//OK 07/13/18: Special Handling Flag Set. - done/checked mlb 1/30/2018
	//From the Documentation file 47.75
	Set Flag=0
	Set DeathDocumentationType=$Piece($Get(^|NS|DPT(PatientIEN,.35)),"^",7)
	//Data is located in another FileMan File.
	//OK 07/13/18: Needs a childTableUpdate method and an update trigger created.
	//mlb - This is unlikely to change, and doesn't really have an effect..
	If (+DeathDocumentationType) {
		Set DeathDocumentationType=$Piece($Get(^|NS|DG(47.75,DeathDocumentationType,0)),"^",1)
	}
	Set DeathDocumentationType=$Extract(DeathDocumentationType,1,100)
	If ..DeathDocumentationType'=DeathDocumentationType {
		Set ..DeathDocumentationType=DeathDocumentationType
		Set Flag=1
	}
	Quit Flag
}

Method setDeathEnteredByStaffIEN(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set DeathEnteredByStaffIEN=$Piece($Get(^|NS|DPT(PatientIEN,.35)),"^",2)
	Set DeathEnteredByStaffIEN=$Extract(DeathEnteredByStaffIEN,1,50)
	If ..DeathEnteredByStaffIEN'=DeathEnteredByStaffIEN {
		Set ..DeathEnteredByStaffIEN=DeathEnteredByStaffIEN
		Set Flag=1
	}
	Quit Flag
}

Method setDeathFMDate(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set DeathFMDate=$Piece($Get(^|NS|DPT(PatientIEN,.35)),"^",1)
	Set DeathFMDate=$Extract(DeathFMDate,1,50)
	If ..DeathFMDate'=DeathFMDate {
		Set ..DeathFMDate=DeathFMDate
		Set Flag=1
	}
	Quit Flag
}

Method setDeathLastUpdatedByStaffIEN(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set DeathLastUpdatedByStaffIEN=$Piece($Get(^|NS|DPT(PatientIEN,.35)),"^",5)
	Set DeathLastUpdatedByStaffIEN=$Extract(DeathLastUpdatedByStaffIEN,1,50)
	If ..DeathLastUpdatedByStaffIEN'=DeathLastUpdatedByStaffIEN {
		Set ..DeathLastUpdatedByStaffIEN=DeathLastUpdatedByStaffIEN
		Set Flag=1
	}
	Quit Flag
}

Method setDeathModifiedDateTime(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set DeathModifiedDateTime=$Piece($Get(^|NS|DPT(PatientIEN,.35)),"^",4)
	If ('##class(%FilemanTimeStamp).IsValid(DeathModifiedDateTime)) {
		Set DeathModifiedDateTime=""
	}
	If ..DeathModifiedDateTime'=DeathModifiedDateTime {
		Set ..DeathModifiedDateTime=DeathModifiedDateTime
		Set Flag=1
	}
	Quit Flag
}

Method setDeathModifiedFMDate(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set DeathModifiedFMDate=$Piece($Get(^|NS|DPT(PatientIEN,.35)),"^",4)
	Set DeathModifiedFMDate=$Extract(DeathModifiedFMDate,1,50)
	If ..DeathModifiedFMDate'=DeathModifiedFMDate {
		Set ..DeathModifiedFMDate=DeathModifiedFMDate
		Set Flag=1
	}
	Quit Flag
}

Method setDeathNotificationSource(NS As %String, PatientIEN As %String) As %Integer
{
	//OK 07/13/18: Special Handling Flag Set. - done/checked mlb 1/30/2018
	//resolved value
	Set Flag=0
	Set DeathNotificationSource=$Piece($Get(^|NS|DPT(PatientIEN,.35)),"^",3)
	//Data is located in another FileMan File.
	//OK 07/13/18: Needs a childTableUpdate method and an update trigger created.
	//mlb - This is unlikely to change, and doesn't really have an effect.
	If (+DeathNotificationSource) {
		Set DeathNotificationSource=$Piece($Get(^|NS|DG(47.76,DeathNotificationSource,0)),"^",1)
	}
	Set DeathNotificationSource=$Extract(DeathNotificationSource,1,50)
	If ..DeathNotificationSource'=DeathNotificationSource {
		Set ..DeathNotificationSource=DeathNotificationSource
		Set Flag=1
	}
	Quit Flag
}

Method setDestinationMergePatientIEN(NS As %String, PatientIEN As %String) As %Integer
{
	//DONE 01/30/18: Special Handling Flag Set. - done/checked mlb 1/30/2018
	//This needs to be mapped to the hidden -9 to get the ToPatientIEN merge.  
	//This node represents the new destination record for a Patient when it is merged.
	Set Flag=0
	Set DestinationMergePatientIEN=$Piece($Get(^|NS|DPT(PatientIEN,-9)),"^",1)
	Set DestinationMergePatientIEN=$Extract(DestinationMergePatientIEN,1,50)
	If ..DestinationMergePatientIEN'=DestinationMergePatientIEN {
		Set ..DestinationMergePatientIEN=DestinationMergePatientIEN
		Set Flag=1
	}
	Quit Flag
}

Method setDuplicateRecordStatus(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set DuplicateRecordStatus=$Piece($Get(^|NS|DPT(PatientIEN,0)),"^",18)
	If DuplicateRecordStatus]"" {
		Set Codes=$Piece($Get(^|NS|DD(2,.081,0)),"^",3)
		Set zz=1
		While ($Piece(Codes,";",zz)]"") {
			Set Code=$Piece($Piece(Codes,";",zz),":",1)
			If (Code=DuplicateRecordStatus) {
				Set DuplicateRecordStatus=$Piece($Piece(Codes,";",zz),":",2)
			}
			Set zz=zz+1
		}
		Kill zz,Codes,Code
		}
	Set DuplicateRecordStatus=$Extract(DuplicateRecordStatus,1,50)
	If ..DuplicateRecordStatus'=DuplicateRecordStatus {
		Set ..DuplicateRecordStatus=DuplicateRecordStatus
		Set Flag=1
	}
	Quit Flag
}

Method setDuplicateRecordStatusCode(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set DuplicateRecordStatusCode=$Piece($Get(^|NS|DPT(PatientIEN,0)),"^",18)
	Set DuplicateRecordStatusCode=$Extract(DuplicateRecordStatusCode,1,50)
	If ..DuplicateRecordStatusCode'=DuplicateRecordStatusCode {
		Set ..DuplicateRecordStatusCode=DuplicateRecordStatusCode
		Set Flag=1
	}
	Quit Flag
}

Method setEligibilityEnteredStaffIEN(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set EligibilityEnteredStaffIEN=$Piece($Get(^|NS|DPT(PatientIEN,.361)),"^",6)
	Set EligibilityEnteredStaffIEN=$Extract(EligibilityEnteredStaffIEN,1,50)
	If ..EligibilityEnteredStaffIEN'=EligibilityEnteredStaffIEN {
		Set ..EligibilityEnteredStaffIEN=EligibilityEnteredStaffIEN
		Set Flag=1
	}
	Quit Flag
}

Method setEligibilityIEN(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set EligibilityIEN=$Piece($Get(^|NS|DPT(PatientIEN,.36)),"^",1)
	Set EligibilityIEN=$Extract(EligibilityIEN,1,50)
	If ..EligibilityIEN'=EligibilityIEN {
		Set ..EligibilityIEN=EligibilityIEN
		Set Flag=1
	}
	Quit Flag
}

Method setEligibilityInterimDateTime(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set EligibilityInterimDateTime=$Piece($Get(^|NS|DPT(PatientIEN,.361)),"^",4)
	If ('##class(%FilemanTimeStamp).IsValid(EligibilityInterimDateTime)) {
		Set EligibilityInterimDateTime=""
	}
	If ..EligibilityInterimDateTime'=EligibilityInterimDateTime {
		Set ..EligibilityInterimDateTime=EligibilityInterimDateTime
		Set Flag=1
	}
	Quit Flag
}

Method setEligibilityInterimFMDate(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set EligibilityInterimFMDate=$Piece($Get(^|NS|DPT(PatientIEN,.361)),"^",4)
	Set EligibilityInterimFMDate=$Extract(EligibilityInterimFMDate,1,50)
	If ..EligibilityInterimFMDate'=EligibilityInterimFMDate {
		Set ..EligibilityInterimFMDate=EligibilityInterimFMDate
		Set Flag=1
	}
	Quit Flag
}

Method setEligibilityStatus(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set EligibilityStatus=$Piece($Get(^|NS|DPT(PatientIEN,.361)),"^",1)
	If EligibilityStatus]"" {
		Set Codes=$Piece($Get(^|NS|DD(2,.3611,0)),"^",3)
		Set zz=1
		While ($Piece(Codes,";",zz)]"") {
			Set Code=$Piece($Piece(Codes,";",zz),":",1)
			If (Code=EligibilityStatus) {
				Set EligibilityStatus=$Piece($Piece(Codes,";",zz),":",2)
			}
			Set zz=zz+1
		}
		Kill zz,Codes,Code
		}
	Set EligibilityStatus=$Extract(EligibilityStatus,1,50)
	If ..EligibilityStatus'=EligibilityStatus {
		Set ..EligibilityStatus=EligibilityStatus
		Set Flag=1
	}
	Quit Flag
}

Method setEligibilityStatusCode(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set EligibilityStatusCode=$Piece($Get(^|NS|DPT(PatientIEN,.361)),"^",1)
	Set EligibilityStatusCode=$Extract(EligibilityStatusCode,1,50)
	If ..EligibilityStatusCode'=EligibilityStatusCode {
		Set ..EligibilityStatusCode=EligibilityStatusCode
		Set Flag=1
	}
	Quit Flag
}

Method setEligibilityStatusDateTime(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set EligibilityStatusDateTime=$Piece($Get(^|NS|DPT(PatientIEN,.361)),"^",2)
	If ('##class(%FilemanTimeStamp).IsValid(EligibilityStatusDateTime)) {
		Set EligibilityStatusDateTime=""
	}
	If ..EligibilityStatusDateTime'=EligibilityStatusDateTime {
		Set ..EligibilityStatusDateTime=EligibilityStatusDateTime
		Set Flag=1
	}
	Quit Flag
}

Method setEligibilityStatusFMDate(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set EligibilityStatusFMDate=$Piece($Get(^|NS|DPT(PatientIEN,.361)),"^",2)
	Set EligibilityStatusFMDate=$Extract(EligibilityStatusFMDate,1,50)
	If ..EligibilityStatusFMDate'=EligibilityStatusFMDate {
		Set ..EligibilityStatusFMDate=EligibilityStatusFMDate
		Set Flag=1
	}
	Quit Flag
}

Method setEligibilityVACode(NS As %String, PatientIEN As %String) As %Integer
{
	//OK 07/13/18: Special Handling Flag Set. - done/checked mlb 1/30/2018
	//maps to Eligibility Code (#8) field 3
	Set Flag=0
	Set EligibilityVACode=$Piece($Get(^|NS|DPT(PatientIEN,.36)),"^",1)
	//Data is located in another FileMan File.
	//OK 07/13/18: Needs a childTableUpdate method and an update trigger created.
	//mlb - This is unlikely to change, and doesn't really have an effect.
	If (+EligibilityVACode) {
		Set EligibilityVACode=$Piece($Get(^|NS|DIC(8,EligibilityVACode,0)),"^",4)
	}
	Set EligibilityVACode=$Extract(EligibilityVACode,1,50)
	If ..EligibilityVACode'=EligibilityVACode {
		Set ..EligibilityVACode=EligibilityVACode
		Set Flag=1
	}
	Quit Flag
}

Method setEligibilityVerificationMethod(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set EligibilityVerificationMethod=$Piece($Get(^|NS|DPT(PatientIEN,.361)),"^",5)
	Set EligibilityVerificationMethod=$Extract(EligibilityVerificationMethod,1,50)
	If ..EligibilityVerificationMethod'=EligibilityVerificationMethod {
		Set ..EligibilityVerificationMethod=EligibilityVerificationMethod
		Set Flag=1
	}
	Quit Flag
}

Method setEligibilityVerificationSource(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set EligibilityVerificationSource=$Piece($Get(^|NS|DPT(PatientIEN,.361)),"^",3)
	If EligibilityVerificationSource]"" {
		Set Codes=$Piece($Get(^|NS|DD(2,.3613,0)),"^",3)
		Set zz=1
		While ($Piece(Codes,";",zz)]"") {
			Set Code=$Piece($Piece(Codes,";",zz),":",1)
			If (Code=EligibilityVerificationSource) {
				Set EligibilityVerificationSource=$Piece($Piece(Codes,";",zz),":",2)
			}
			Set zz=zz+1
		}
		Kill zz,Codes,Code
		}
	Set EligibilityVerificationSource=$Extract(EligibilityVerificationSource,1,50)
	If ..EligibilityVerificationSource'=EligibilityVerificationSource {
		Set ..EligibilityVerificationSource=EligibilityVerificationSource
		Set Flag=1
	}
	Quit Flag
}

Method setEligibilityVerificationSourceCode(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set EligibilityVerificationSourceCode=$Piece($Get(^|NS|DPT(PatientIEN,.361)),"^",3)
	Set EligibilityVerificationSourceCode=$Extract(EligibilityVerificationSourceCode,1,50)
	If ..EligibilityVerificationSourceCode'=EligibilityVerificationSourceCode {
		Set ..EligibilityVerificationSourceCode=EligibilityVerificationSourceCode
		Set Flag=1
	}
	Quit Flag
}

Method setEmergencyResponseIndicator(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set EmergencyResponseIndicator=$Piece($Get(^|NS|DPT(PatientIEN,.18)),"^",1)
	If EmergencyResponseIndicator]"" {
		Set Codes=$Piece($Get(^|NS|DD(2,.181,0)),"^",3)
		Set zz=1
		While ($Piece(Codes,";",zz)]"") {
			Set Code=$Piece($Piece(Codes,";",zz),":",1)
			If (Code=EmergencyResponseIndicator) {
				Set EmergencyResponseIndicator=$Piece($Piece(Codes,";",zz),":",2)
			}
			Set zz=zz+1
		}
		Kill zz,Codes,Code
		}
	Set EmergencyResponseIndicator=$Extract(EmergencyResponseIndicator,1,50)
	If ..EmergencyResponseIndicator'=EmergencyResponseIndicator {
		Set ..EmergencyResponseIndicator=EmergencyResponseIndicator
		Set Flag=1
	}
	Quit Flag
}

Method setEmergencyResponseIndicatorCode(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set EmergencyResponseIndicatorCode=$Piece($Get(^|NS|DPT(PatientIEN,.18)),"^",1)
	Set EmergencyResponseIndicatorCode=$Extract(EmergencyResponseIndicatorCode,1,50)
	If ..EmergencyResponseIndicatorCode'=EmergencyResponseIndicatorCode {
		Set ..EmergencyResponseIndicatorCode=EmergencyResponseIndicatorCode
		Set Flag=1
	}
	Quit Flag
}

Method setFFFEnteredDateTime(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set FFFEnteredDateTime=$Piece($Get(^|NS|DPT(PatientIEN,"FFP")),"^",3)
	If ('##class(%FilemanTimeStamp).IsValid(FFFEnteredDateTime)) {
		Set FFFEnteredDateTime=""
	}
	If ..FFFEnteredDateTime'=FFFEnteredDateTime {
		Set ..FFFEnteredDateTime=FFFEnteredDateTime
		Set Flag=1
	}
	Quit Flag
}

Method setFFFEnteredFMDate(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set FFFEnteredFMDate=$Piece($Get(^|NS|DPT(PatientIEN,"FFP")),"^",3)
	Set FFFEnteredFMDate=$Extract(FFFEnteredFMDate,1,50)
	If ..FFFEnteredFMDate'=FFFEnteredFMDate {
		Set ..FFFEnteredFMDate=FFFEnteredFMDate
		Set Flag=1
	}
	Quit Flag
}

Method setFFFEnteredStaffIEN(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set FFFEnteredStaffIEN=$Piece($Get(^|NS|DPT(PatientIEN,"FFP")),"^",2)
	Set FFFEnteredStaffIEN=$Extract(FFFEnteredStaffIEN,1,50)
	If ..FFFEnteredStaffIEN'=FFFEnteredStaffIEN {
		Set ..FFFEnteredStaffIEN=FFFEnteredStaffIEN
		Set Flag=1
	}
	Quit Flag
}

Method setFFFRemovedDateTime(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set FFFRemovedDateTime=$Piece($Get(^|NS|DPT(PatientIEN,"FFP")),"^",5)
	If ('##class(%FilemanTimeStamp).IsValid(FFFRemovedDateTime)) {
		Set FFFRemovedDateTime=""
	}
	If ..FFFRemovedDateTime'=FFFRemovedDateTime {
		Set ..FFFRemovedDateTime=FFFRemovedDateTime
		Set Flag=1
	}
	Quit Flag
}

Method setFFFRemovedFMDate(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set FFFRemovedFMDate=$Piece($Get(^|NS|DPT(PatientIEN,"FFP")),"^",5)
	Set FFFRemovedFMDate=$Extract(FFFRemovedFMDate,1,50)
	If ..FFFRemovedFMDate'=FFFRemovedFMDate {
		Set ..FFFRemovedFMDate=FFFRemovedFMDate
		Set Flag=1
	}
	Quit Flag
}

Method setFFFRemovedReason(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set FFFRemovedReason=$Piece($Get(^|NS|DPT(PatientIEN,"FFP")),"^",9)
	Set FFFRemovedReason=$Extract(FFFRemovedReason,1,100)
	If ..FFFRemovedReason'=FFFRemovedReason {
		Set ..FFFRemovedReason=FFFRemovedReason
		Set Flag=1
	}
	Quit Flag
}

Method setFFFRemovedStaffIEN(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set FFFRemovedStaffIEN=$Piece($Get(^|NS|DPT(PatientIEN,"FFP")),"^",4)
	Set FFFRemovedStaffIEN=$Extract(FFFRemovedStaffIEN,1,50)
	If ..FFFRemovedStaffIEN'=FFFRemovedStaffIEN {
		Set ..FFFRemovedStaffIEN=FFFRemovedStaffIEN
		Set Flag=1
	}
	Quit Flag
}

Method setFederalAgencyIEN(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set FederalAgencyIEN=$Piece($Get(^|NS|DPT(PatientIEN,.3)),"^",9)
	Set FederalAgencyIEN=$Extract(FederalAgencyIEN,1,50)
	If ..FederalAgencyIEN'=FederalAgencyIEN {
		Set ..FederalAgencyIEN=FederalAgencyIEN
		Set Flag=1
	}
	Quit Flag
}

Method setFilipinoVeteranCode(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set FilipinoVeteranCode=$Piece($Get(^|NS|DPT(PatientIEN,.321)),"^",14)
	If FilipinoVeteranCode]"" {
		Set Codes=$Piece($Get(^|NS|DD(2,.3214,0)),"^",3)
		Set zz=1
		While ($Piece(Codes,";",zz)]"") {
			Set Code=$Piece($Piece(Codes,";",zz),":",1)
			If (Code=FilipinoVeteranCode) {
				Set FilipinoVeteranCode=$Piece($Piece(Codes,";",zz),":",2)
			}
			Set zz=zz+1
		}
		Kill zz,Codes,Code
		}
	Set FilipinoVeteranCode=$Extract(FilipinoVeteranCode,1,50)
	If ..FilipinoVeteranCode'=FilipinoVeteranCode {
		Set ..FilipinoVeteranCode=FilipinoVeteranCode
		Set Flag=1
	}
	Quit Flag
}

Method setFilipinoVeteranCodeCode(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set FilipinoVeteranCodeCode=$Piece($Get(^|NS|DPT(PatientIEN,.321)),"^",14)
	Set FilipinoVeteranCodeCode=$Extract(FilipinoVeteranCodeCode,1,50)
	If ..FilipinoVeteranCodeCode'=FilipinoVeteranCodeCode {
		Set ..FilipinoVeteranCodeCode=FilipinoVeteranCodeCode
		Set Flag=1
	}
	Quit Flag
}

Method setFugitiveFelonFlag(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set FugitiveFelonFlag=$Piece($Get(^|NS|DPT(PatientIEN,"FFP")),"^",1)
	Set FugitiveFelonFlag=$Case(FugitiveFelonFlag,"1":"Y",:$Extract(FugitiveFelonFlag,1))
	Set FugitiveFelonFlag=$Extract(FugitiveFelonFlag,1,1)
	If ..FugitiveFelonFlag'=FugitiveFelonFlag {
		Set ..FugitiveFelonFlag=FugitiveFelonFlag
		Set Flag=1
	}
	Quit Flag
}

Method setFugitiveFelonFlagCode(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set FugitiveFelonFlagCode=$Piece($Get(^|NS|DPT(PatientIEN,"FFP")),"^",1)
	Set FugitiveFelonFlagCode=$Extract(FugitiveFelonFlagCode,1,50)
	If ..FugitiveFelonFlagCode'=FugitiveFelonFlagCode {
		Set ..FugitiveFelonFlagCode=FugitiveFelonFlagCode
		Set Flag=1
	}
	Quit Flag
}

Method setGender(NS As %String, PatientIEN As %String) As %Integer
{
	//DONE 07/13/18: Special Handling Flag Set. - done/checked mlb 1/30/2018
	//
	Set Flag=0
	Set Gender=$Piece($Get(^|NS|DPT(PatientIEN,0)),"^",2)
	Set Gender=$Extract(Gender,1,1)
	If ..Gender'=Gender {
		Set ..Gender=Gender
		Set Flag=1
	}
	Quit Flag
}

Method setGenderCode(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set GenderCode=$Piece($Get(^|NS|DPT(PatientIEN,0)),"^",2)
	Set GenderCode=$Extract(GenderCode,1,50)
	If ..GenderCode'=GenderCode {
		Set ..GenderCode=GenderCode
		Set Flag=1
	}
	Quit Flag
}

Method setGovernmentEmployeeFlag(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set GovernmentEmployeeFlag=$Piece($Get(^|NS|DPT(PatientIEN,.311)),"^",2)
	Set GovernmentEmployeeFlag=$Case(GovernmentEmployeeFlag,"Y":"Y","N":"N",:$Extract(GovernmentEmployeeFlag,1))
	Set GovernmentEmployeeFlag=$Extract(GovernmentEmployeeFlag,1,1)
	If ..GovernmentEmployeeFlag'=GovernmentEmployeeFlag {
		Set ..GovernmentEmployeeFlag=GovernmentEmployeeFlag
		Set Flag=1
	}
	Quit Flag
}

Method setGovernmentEmployeeFlagCode(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set GovernmentEmployeeFlagCode=$Piece($Get(^|NS|DPT(PatientIEN,.311)),"^",2)
	Set GovernmentEmployeeFlagCode=$Extract(GovernmentEmployeeFlagCode,1,50)
	If ..GovernmentEmployeeFlagCode'=GovernmentEmployeeFlagCode {
		Set ..GovernmentEmployeeFlagCode=GovernmentEmployeeFlagCode
		Set Flag=1
	}
	Quit Flag
}

Method setIneligibleCity(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set IneligibleCity=$Piece($Get(^|NS|DPT(PatientIEN,"INE")),"^",3)
	Set IneligibleCity=$Extract(IneligibleCity,1,50)
	If ..IneligibleCity'=IneligibleCity {
		Set ..IneligibleCity=IneligibleCity
		Set Flag=1
	}
	Quit Flag
}

Method setIneligibleDateTime(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set IneligibleDateTime=$Piece($Get(^|NS|DPT(PatientIEN,.15)),"^",2)
	If ('##class(%FilemanTimeStamp).IsValid(IneligibleDateTime)) {
		Set IneligibleDateTime=""
	}
	If ..IneligibleDateTime'=IneligibleDateTime {
		Set ..IneligibleDateTime=IneligibleDateTime
		Set Flag=1
	}
	Quit Flag
}

Method setIneligibleFMDate(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set IneligibleFMDate=$Piece($Get(^|NS|DPT(PatientIEN,.15)),"^",2)
	Set IneligibleFMDate=$Extract(IneligibleFMDate,1,50)
	If ..IneligibleFMDate'=IneligibleFMDate {
		Set ..IneligibleFMDate=IneligibleFMDate
		Set Flag=1
	}
	Quit Flag
}

Method setIneligibleReason(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set IneligibleReason=$Piece($Get(^|NS|DPT(PatientIEN,.3)),"^",7)
	Set IneligibleReason=$Extract(IneligibleReason,1,50)
	If ..IneligibleReason'=IneligibleReason {
		Set ..IneligibleReason=IneligibleReason
		Set Flag=1
	}
	Quit Flag
}

Method setIneligibleSource(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set IneligibleSource=$Piece($Get(^|NS|DPT(PatientIEN,"INE")),"^",1)
	If IneligibleSource]"" {
		Set Codes=$Piece($Get(^|NS|DD(2,.1651,0)),"^",3)
		Set zz=1
		While ($Piece(Codes,";",zz)]"") {
			Set Code=$Piece($Piece(Codes,";",zz),":",1)
			If (Code=IneligibleSource) {
				Set IneligibleSource=$Piece($Piece(Codes,";",zz),":",2)
			}
			Set zz=zz+1
		}
		Kill zz,Codes,Code
		}
	Set IneligibleSource=$Extract(IneligibleSource,1,50)
	If ..IneligibleSource'=IneligibleSource {
		Set ..IneligibleSource=IneligibleSource
		Set Flag=1
	}
	Quit Flag
}

Method setIneligibleSourceCode(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set IneligibleSourceCode=$Piece($Get(^|NS|DPT(PatientIEN,"INE")),"^",1)
	Set IneligibleSourceCode=$Extract(IneligibleSourceCode,1,50)
	If ..IneligibleSourceCode'=IneligibleSourceCode {
		Set ..IneligibleSourceCode=IneligibleSourceCode
		Set Flag=1
	}
	Quit Flag
}

Method setIneligibleStateIEN(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set IneligibleStateIEN=$Piece($Get(^|NS|DPT(PatientIEN,"INE")),"^",4)
	Set IneligibleStateIEN=$Extract(IneligibleStateIEN,1,50)
	If ..IneligibleStateIEN'=IneligibleStateIEN {
		Set ..IneligibleStateIEN=IneligibleStateIEN
		Set Flag=1
	}
	Quit Flag
}

Method setIneligibleVAROReason(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set IneligibleVAROReason=$Piece($Get(^|NS|DPT(PatientIEN,"INE")),"^",6)
	Set IneligibleVAROReason=$Extract(IneligibleVAROReason,1,100)
	If ..IneligibleVAROReason'=IneligibleVAROReason {
		Set ..IneligibleVAROReason=IneligibleVAROReason
		Set Flag=1
	}
	Quit Flag
}

Method setInsuranceCoverageFlag(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set InsuranceCoverageFlag=$Piece($Get(^|NS|DPT(PatientIEN,.31)),"^",11)
	Set InsuranceCoverageFlag=$Case(InsuranceCoverageFlag,"Y":"Y","N":"N","U":"U",:$Extract(InsuranceCoverageFlag,1))
	Set InsuranceCoverageFlag=$Extract(InsuranceCoverageFlag,1,1)
	If ..InsuranceCoverageFlag'=InsuranceCoverageFlag {
		Set ..InsuranceCoverageFlag=InsuranceCoverageFlag
		Set Flag=1
	}
	Quit Flag
}

Method setInsuranceCoverageFlagCode(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set InsuranceCoverageFlagCode=$Piece($Get(^|NS|DPT(PatientIEN,.31)),"^",11)
	Set InsuranceCoverageFlagCode=$Extract(InsuranceCoverageFlagCode,1,50)
	If ..InsuranceCoverageFlagCode'=InsuranceCoverageFlagCode {
		Set ..InsuranceCoverageFlagCode=InsuranceCoverageFlagCode
		Set Flag=1
	}
	Quit Flag
}

Method setIonizingRadiationExposureFlag(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set IonizingRadiationExposureFlag=$Piece($Get(^|NS|DPT(PatientIEN,.321)),"^",3)
	Set IonizingRadiationExposureFlag=$Case(IonizingRadiationExposureFlag,"Y":"Y","N":"N","U":"U",:$Extract(IonizingRadiationExposureFlag,1))
	Set IonizingRadiationExposureFlag=$Extract(IonizingRadiationExposureFlag,1,1)
	If ..IonizingRadiationExposureFlag'=IonizingRadiationExposureFlag {
		Set ..IonizingRadiationExposureFlag=IonizingRadiationExposureFlag
		Set Flag=1
	}
	Quit Flag
}

Method setIonizingRadiationExposureFlagCode(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set IonizingRadiationExposureFlagCode=$Piece($Get(^|NS|DPT(PatientIEN,.321)),"^",3)
	Set IonizingRadiationExposureFlagCode=$Extract(IonizingRadiationExposureFlagCode,1,50)
	If ..IonizingRadiationExposureFlagCode'=IonizingRadiationExposureFlagCode {
		Set ..IonizingRadiationExposureFlagCode=IonizingRadiationExposureFlagCode
		Set Flag=1
	}
	Quit Flag
}

Method setMaritalStatusIEN(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set MaritalStatusIEN=$Piece($Get(^|NS|DPT(PatientIEN,0)),"^",5)
	Set MaritalStatusIEN=$Extract(MaritalStatusIEN,1,50)
	If ..MaritalStatusIEN'=MaritalStatusIEN {
		Set ..MaritalStatusIEN=MaritalStatusIEN
		Set Flag=1
	}
	Quit Flag
}

Method setMedicaidEligibleFlag(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set MedicaidEligibleFlag=$Piece($Get(^|NS|DPT(PatientIEN,.38)),"^",1)
	Set MedicaidEligibleFlag=$Case(MedicaidEligibleFlag,"1":"Y","0":"N",:$Extract(MedicaidEligibleFlag,1))
	Set MedicaidEligibleFlag=$Extract(MedicaidEligibleFlag,1,1)
	If ..MedicaidEligibleFlag'=MedicaidEligibleFlag {
		Set ..MedicaidEligibleFlag=MedicaidEligibleFlag
		Set Flag=1
	}
	Quit Flag
}

Method setMedicaidEligibleFlagCode(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set MedicaidEligibleFlagCode=$Piece($Get(^|NS|DPT(PatientIEN,.38)),"^",1)
	Set MedicaidEligibleFlagCode=$Extract(MedicaidEligibleFlagCode,1,50)
	If ..MedicaidEligibleFlagCode'=MedicaidEligibleFlagCode {
		Set ..MedicaidEligibleFlagCode=MedicaidEligibleFlagCode
		Set Flag=1
	}
	Quit Flag
}

Method setMedicaidInquireDateTime(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set MedicaidInquireDateTime=$Piece($Get(^|NS|DPT(PatientIEN,.38)),"^",2)
	If ('##class(%FilemanTimeStamp).IsValid(MedicaidInquireDateTime)) {
		Set MedicaidInquireDateTime=""
	}
	If ..MedicaidInquireDateTime'=MedicaidInquireDateTime {
		Set ..MedicaidInquireDateTime=MedicaidInquireDateTime
		Set Flag=1
	}
	Quit Flag
}

Method setMedicaidInquireFMDate(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set MedicaidInquireFMDate=$Piece($Get(^|NS|DPT(PatientIEN,.38)),"^",2)
	Set MedicaidInquireFMDate=$Extract(MedicaidInquireFMDate,1,50)
	If ..MedicaidInquireFMDate'=MedicaidInquireFMDate {
		Set ..MedicaidInquireFMDate=MedicaidInquireFMDate
		Set Flag=1
	}
	Quit Flag
}

Method setMedicaidNumber(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set MedicaidNumber=$Piece($Get(^|NS|DPT(PatientIEN,.38)),"^",3)
	Set MedicaidNumber=$Extract(MedicaidNumber,1,50)
	If ..MedicaidNumber'=MedicaidNumber {
		Set ..MedicaidNumber=MedicaidNumber
		Set Flag=1
	}
	Quit Flag
}

Method setODSRankType(NS As %String, PatientIEN As %String) As %Integer
{
	//OK 07/13/18: Special Handling Flag Set. - done/checked mlb 1/30/2018
	//Resolved value from dimension table.
	Set Flag=0
	Set ODSRankType=$Piece($Get(^|NS|DPT(PatientIEN,"ODS")),"^",3)
	//Data is located in another FileMan File.
	//OK 07/13/18: Needs a childTableUpdate method and an update trigger created.
	//mlb - This is unlikely to change, and doesn't really have an effect.
	If (+ODSRankType) {
		Set ODSRankType=$Piece($Get(^|NS|DIC(25002.1,ODSRankType,0)),"^",2)
	}
	Set ODSRankType=$Extract(ODSRankType,1,50)
	If ..ODSRankType'=ODSRankType {
		Set ..ODSRankType=ODSRankType
		Set Flag=1
	}
	Quit Flag
}

Method setODSRecalledCode(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set ODSRecalledCode=$Piece($Get(^|NS|DPT(PatientIEN,"ODS")),"^",2)
	If ODSRecalledCode]"" {
		Set Codes=$Piece($Get(^|NS|DD(2,11500.02,0)),"^",3)
		Set zz=1
		While ($Piece(Codes,";",zz)]"") {
			Set Code=$Piece($Piece(Codes,";",zz),":",1)
			If (Code=ODSRecalledCode) {
				Set ODSRecalledCode=$Piece($Piece(Codes,";",zz),":",2)
			}
			Set zz=zz+1
		}
		Kill zz,Codes,Code
		}
	Set ODSRecalledCode=$Extract(ODSRecalledCode,1,50)
	If ..ODSRecalledCode'=ODSRecalledCode {
		Set ..ODSRecalledCode=ODSRecalledCode
		Set Flag=1
	}
	Quit Flag
}

Method setODSRecalledCodeCode(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set ODSRecalledCodeCode=$Piece($Get(^|NS|DPT(PatientIEN,"ODS")),"^",2)
	Set ODSRecalledCodeCode=$Extract(ODSRecalledCodeCode,1,50)
	If ..ODSRecalledCodeCode'=ODSRecalledCodeCode {
		Set ..ODSRecalledCodeCode=ODSRecalledCodeCode
		Set Flag=1
	}
	Quit Flag
}

Method setODSTreatmentDateTime(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set ODSTreatmentDateTime=$Piece($Get(^|NS|DPT(PatientIEN,"ODS")),"^",1)
	If ('##class(%FilemanTimeStamp).IsValid(ODSTreatmentDateTime)) {
		Set ODSTreatmentDateTime=""
	}
	If ..ODSTreatmentDateTime'=ODSTreatmentDateTime {
		Set ..ODSTreatmentDateTime=ODSTreatmentDateTime
		Set Flag=1
	}
	Quit Flag
}

Method setODSTreatmentFMDate(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set ODSTreatmentFMDate=$Piece($Get(^|NS|DPT(PatientIEN,"ODS")),"^",1)
	Set ODSTreatmentFMDate=$Extract(ODSTreatmentFMDate,1,50)
	If ..ODSTreatmentFMDate'=ODSTreatmentFMDate {
		Set ..ODSTreatmentFMDate=ODSTreatmentFMDate
		Set Flag=1
	}
	Quit Flag
}

Method setOperationDesertShieldRank(NS As %String, PatientIEN As %String) As %Integer
{
	//OK 07/13/18: Special Handling Flag Set. - done/checked mlb 1/30/2018
	//Resolved value from dimension table.
	Set Flag=0
	Set OperationDesertShieldRank=$Piece($Get(^|NS|DPT(PatientIEN,"ODS")),"^",3)
	//OK 07/13/18: Needs a childTableUpdate method and an update trigger created.
	//mlb - This is unlikely to change, and doesn't really have an effect.
	If (+OperationDesertShieldRank) {
		Set OperationDesertShieldRank=$Piece($Get(^|NS|DIC(25002.1,OperationDesertShieldRank,0)),"^",1)
	}
	Set OperationDesertShieldRank=$Extract(OperationDesertShieldRank,1,50)
	If ..OperationDesertShieldRank'=OperationDesertShieldRank {
		Set ..OperationDesertShieldRank=OperationDesertShieldRank
		Set Flag=1
	}
	Quit Flag
}

Method setPOWFlag(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set POWFlag=$Piece($Get(^|NS|DPT(PatientIEN,.52)),"^",5)
	Set POWFlag=$Case(POWFlag,"Y":"Y","N":"N","U":"U",:$Extract(POWFlag,1))
	Set POWFlag=$Extract(POWFlag,1,1)
	If ..POWFlag'=POWFlag {
		Set ..POWFlag=POWFlag
		Set Flag=1
	}
	Quit Flag
}

Method setPOWFlagCode(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set POWFlagCode=$Piece($Get(^|NS|DPT(PatientIEN,.52)),"^",5)
	Set POWFlagCode=$Extract(POWFlagCode,1,50)
	If ..POWFlagCode'=POWFlagCode {
		Set ..POWFlagCode=POWFlagCode
		Set Flag=1
	}
	Quit Flag
}

Method setPOWLocationIEN(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set POWLocationIEN=$Piece($Get(^|NS|DPT(PatientIEN,.52)),"^",6)
	Set POWLocationIEN=$Extract(POWLocationIEN,1,50)
	If ..POWLocationIEN'=POWLocationIEN {
		Set ..POWLocationIEN=POWLocationIEN
		Set Flag=1
	}
	Quit Flag
}

Method setPatientEnteredByStaffIEN(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set PatientEnteredByStaffIEN=$Piece($Get(^|NS|DPT(PatientIEN,0)),"^",15)
	Set PatientEnteredByStaffIEN=$Extract(PatientEnteredByStaffIEN,1,50)
	If ..PatientEnteredByStaffIEN'=PatientEnteredByStaffIEN {
		Set ..PatientEnteredByStaffIEN=PatientEnteredByStaffIEN
		Set Flag=1
	}
	Quit Flag
}

Method setPatientEnteredCode(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set PatientEnteredCode=$Piece($Get(^|NS|DPT(PatientIEN,0)),"^",17)
	If PatientEnteredCode]"" {
		Set Codes=$Piece($Get(^|NS|DD(2,.098,0)),"^",3)
		Set zz=1
		While ($Piece(Codes,";",zz)]"") {
			Set Code=$Piece($Piece(Codes,";",zz),":",1)
			If (Code=PatientEnteredCode) {
				Set PatientEnteredCode=$Piece($Piece(Codes,";",zz),":",2)
			}
			Set zz=zz+1
		}
		Kill zz,Codes,Code
		}
	Set PatientEnteredCode=$Extract(PatientEnteredCode,1,50)
	If ..PatientEnteredCode'=PatientEnteredCode {
		Set ..PatientEnteredCode=PatientEnteredCode
		Set Flag=1
	}
	Quit Flag
}

Method setPatientEnteredCodeCode(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set PatientEnteredCodeCode=$Piece($Get(^|NS|DPT(PatientIEN,0)),"^",17)
	Set PatientEnteredCodeCode=$Extract(PatientEnteredCodeCode,1,50)
	If ..PatientEnteredCodeCode'=PatientEnteredCodeCode {
		Set ..PatientEnteredCodeCode=PatientEnteredCodeCode
		Set Flag=1
	}
	Quit Flag
}

Method setPatientEnteredDateTime(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set PatientEnteredDateTime=$Piece($Get(^|NS|DPT(PatientIEN,0)),"^",16)
	If ('##class(%FilemanTimeStamp).IsValid(PatientEnteredDateTime)) {
		Set PatientEnteredDateTime=""
	}
	If ..PatientEnteredDateTime'=PatientEnteredDateTime {
		Set ..PatientEnteredDateTime=PatientEnteredDateTime
		Set Flag=1
	}
	Quit Flag
}

Method setPatientEnteredFMDate(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set PatientEnteredFMDate=$Piece($Get(^|NS|DPT(PatientIEN,0)),"^",16)
	Set PatientEnteredFMDate=$Extract(PatientEnteredFMDate,1,50)
	If ..PatientEnteredFMDate'=PatientEnteredFMDate {
		Set ..PatientEnteredFMDate=PatientEnteredFMDate
		Set Flag=1
	}
	Quit Flag
}

Method setPatientEnteredRemark(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set PatientEnteredRemark=$Piece($Get(^|NS|DPT(PatientIEN,0)),"^",10)
	Set PatientEnteredRemark=$Extract(PatientEnteredRemark,1,100)
	If ..PatientEnteredRemark'=PatientEnteredRemark {
		Set ..PatientEnteredRemark=PatientEnteredRemark
		Set Flag=1
	}
	Quit Flag
}

Method setPatientFirstName(NS As %String, PatientIEN As %String) As %Integer
{
	//DONE 07/13/18: Special Handling Flag Set. - done/checked mlb 1/30/2018
	//Get patient first name.
	Set Flag=0
	Set PatientFirstName=$Piece($Piece($Get(^|NS|DPT(PatientIEN,0)),"^",1),",",2)
	Set PatientFirstName=$Extract(PatientFirstName,1,50)
	If ..PatientFirstName'=PatientFirstName {
		Set ..PatientFirstName=PatientFirstName
		Set Flag=1
	}
	Quit Flag
}

Method setPatientICN(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set PatientICN=$Piece($Get(^|NS|DPT(PatientIEN,"MPI")),"^",1)
	Set PatientICN=$Extract(PatientICN,1,50)
	If ..PatientICN'=PatientICN {
		Set ..PatientICN=PatientICN
		Set Flag=1
	}
	Quit Flag
}

Method setPatientLastName(NS As %String, PatientIEN As %String) As %Integer
{
	//DONE 07/13/18: Special Handling Flag Set. - done/checked mlb 1/30/2018
	//Get patient last name.
	Set Flag=0
	Set PatientLastName=$Piece($Piece($Get(^|NS|DPT(PatientIEN,0)),"^",1),",",1)
	Set PatientLastName=$Extract(PatientLastName,1,50)
	If ..PatientLastName'=PatientLastName {
		Set ..PatientLastName=PatientLastName
		Set Flag=1
	}
	Quit Flag
}

Method setPatientMissingCity(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set PatientMissingCity=$Piece($Get(^|NS|DPT(PatientIEN,"INE")),"^",8)
	Set PatientMissingCity=$Extract(PatientMissingCity,1,50)
	If ..PatientMissingCity'=PatientMissingCity {
		Set ..PatientMissingCity=PatientMissingCity
		Set Flag=1
	}
	Quit Flag
}

Method setPatientMissingDateTime(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set PatientMissingDateTime=$Piece($Get(^|NS|DPT(PatientIEN,.15)),"^",3)
	If ('##class(%FilemanTimeStamp).IsValid(PatientMissingDateTime)) {
		Set PatientMissingDateTime=""
	}
	If ..PatientMissingDateTime'=PatientMissingDateTime {
		Set ..PatientMissingDateTime=PatientMissingDateTime
		Set Flag=1
	}
	Quit Flag
}

Method setPatientMissingFMDate(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set PatientMissingFMDate=$Piece($Get(^|NS|DPT(PatientIEN,.15)),"^",3)
	Set PatientMissingFMDate=$Extract(PatientMissingFMDate,1,50)
	If ..PatientMissingFMDate'=PatientMissingFMDate {
		Set ..PatientMissingFMDate=PatientMissingFMDate
		Set Flag=1
	}
	Quit Flag
}

Method setPatientMissingSource(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set PatientMissingSource=$Piece($Get(^|NS|DPT(PatientIEN,"INE")),"^",7)
	If PatientMissingSource]"" {
		Set Codes=$Piece($Get(^|NS|DD(2,.1657,0)),"^",3)
		Set zz=1
		While ($Piece(Codes,";",zz)]"") {
			Set Code=$Piece($Piece(Codes,";",zz),":",1)
			If (Code=PatientMissingSource) {
				Set PatientMissingSource=$Piece($Piece(Codes,";",zz),":",2)
			}
			Set zz=zz+1
		}
		Kill zz,Codes,Code
		}
	Set PatientMissingSource=$Extract(PatientMissingSource,1,50)
	If ..PatientMissingSource'=PatientMissingSource {
		Set ..PatientMissingSource=PatientMissingSource
		Set Flag=1
	}
	Quit Flag
}

Method setPatientMissingSourceCode(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set PatientMissingSourceCode=$Piece($Get(^|NS|DPT(PatientIEN,"INE")),"^",7)
	Set PatientMissingSourceCode=$Extract(PatientMissingSourceCode,1,50)
	If ..PatientMissingSourceCode'=PatientMissingSourceCode {
		Set ..PatientMissingSourceCode=PatientMissingSourceCode
		Set Flag=1
	}
	Quit Flag
}

Method setPatientMissingStateIEN(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set PatientMissingStateIEN=$Piece($Get(^|NS|DPT(PatientIEN,"INE")),"^",9)
	Set PatientMissingStateIEN=$Extract(PatientMissingStateIEN,1,50)
	If ..PatientMissingStateIEN'=PatientMissingStateIEN {
		Set ..PatientMissingStateIEN=PatientMissingStateIEN
		Set Flag=1
	}
	Quit Flag
}

Method setPatientName(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set PatientName=$Piece($Get(^|NS|DPT(PatientIEN,0)),"^",1)
	Set PatientName=$Extract(PatientName,1,100)
	If ..PatientName'=PatientName {
		Set ..PatientName=PatientName
		Set Flag=1
	}
	Quit Flag
}

Method setPatientSSN(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set PatientSSN=$Piece($Get(^|NS|DPT(PatientIEN,0)),"^",9)
	Set PatientSSN=$Extract(PatientSSN,1,50)
	If ..PatientSSN'=PatientSSN {
		Set ..PatientSSN=PatientSSN
		Set Flag=1
	}
	Quit Flag
}

Method setPatientTypeIEN(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set PatientTypeIEN=$Piece($Get(^|NS|DPT(PatientIEN,"TYPE")),"^",1)
	Set PatientTypeIEN=$Extract(PatientTypeIEN,1,50)
	If ..PatientTypeIEN'=PatientTypeIEN {
		Set ..PatientTypeIEN=PatientTypeIEN
		Set Flag=1
	}
	Quit Flag
}

Method setPercentServiceConnect(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set PercentServiceConnect=$Piece($Get(^|NS|DPT(PatientIEN,.3)),"^",2)
	Set:(PercentServiceConnect]"") PercentServiceConnect=+PercentServiceConnect
	If ..PercentServiceConnect'=PercentServiceConnect {
		Set ..PercentServiceConnect=PercentServiceConnect
		Set Flag=1
	}
	Quit Flag
}

Method setPeriodOfServiceIEN(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set PeriodOfServiceIEN=$Piece($Get(^|NS|DPT(PatientIEN,.32)),"^",3)
	Set PeriodOfServiceIEN=$Extract(PeriodOfServiceIEN,1,50)
	If ..PeriodOfServiceIEN'=PeriodOfServiceIEN {
		Set ..PeriodOfServiceIEN=PeriodOfServiceIEN
		Set Flag=1
	}
	Quit Flag
}

Method setPreferredInstitutionIEN(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set PreferredInstitutionIEN=$Piece($Get(^|NS|DPT(PatientIEN,"ENR")),"^",2)
	Set PreferredInstitutionIEN=$Extract(PreferredInstitutionIEN,1,50)
	If ..PreferredInstitutionIEN'=PreferredInstitutionIEN {
		Set ..PreferredInstitutionIEN=PreferredInstitutionIEN
		Set Flag=1
	}
	Quit Flag
}

Method setPreferredInstitutionSource(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set PreferredInstitutionSource=$Piece($Get(^|NS|DPT(PatientIEN,"ENR")),"^",3)
	If PreferredInstitutionSource]"" {
		Set Codes=$Piece($Get(^|NS|DD(2,27.03,0)),"^",3)
		Set zz=1
		While ($Piece(Codes,";",zz)]"") {
			Set Code=$Piece($Piece(Codes,";",zz),":",1)
			If (Code=PreferredInstitutionSource) {
				Set PreferredInstitutionSource=$Piece($Piece(Codes,";",zz),":",2)
			}
			Set zz=zz+1
		}
		Kill zz,Codes,Code
		}
	Set PreferredInstitutionSource=$Extract(PreferredInstitutionSource,1,50)
	If ..PreferredInstitutionSource'=PreferredInstitutionSource {
		Set ..PreferredInstitutionSource=PreferredInstitutionSource
		Set Flag=1
	}
	Quit Flag
}

Method setPreferredInstitutionSourceCode(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set PreferredInstitutionSourceCode=$Piece($Get(^|NS|DPT(PatientIEN,"ENR")),"^",3)
	Set PreferredInstitutionSourceCode=$Extract(PreferredInstitutionSourceCode,1,50)
	If ..PreferredInstitutionSourceCode'=PreferredInstitutionSourceCode {
		Set ..PreferredInstitutionSourceCode=PreferredInstitutionSourceCode
		Set Flag=1
	}
	Quit Flag
}

Method setPseudoSSNReason(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set PseudoSSNReason=$Piece($Get(^|NS|DPT(PatientIEN,"SSN")),"^",1)
	If PseudoSSNReason]"" {
		Set Codes=$Piece($Get(^|NS|DD(2,.0906,0)),"^",3)
		Set zz=1
		While ($Piece(Codes,";",zz)]"") {
			Set Code=$Piece($Piece(Codes,";",zz),":",1)
			If (Code=PseudoSSNReason) {
				Set PseudoSSNReason=$Piece($Piece(Codes,";",zz),":",2)
			}
			Set zz=zz+1
		}
		Kill zz,Codes,Code
		}
	Set PseudoSSNReason=$Extract(PseudoSSNReason,1,50)
	If ..PseudoSSNReason'=PseudoSSNReason {
		Set ..PseudoSSNReason=PseudoSSNReason
		Set Flag=1
	}
	Quit Flag
}

Method setPseudoSSNReasonCode(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set PseudoSSNReasonCode=$Piece($Get(^|NS|DPT(PatientIEN,"SSN")),"^",1)
	Set PseudoSSNReasonCode=$Extract(PseudoSSNReasonCode,1,50)
	If ..PseudoSSNReasonCode'=PseudoSSNReasonCode {
		Set ..PseudoSSNReasonCode=PseudoSSNReasonCode
		Set Flag=1
	}
	Quit Flag
}

Method setRadiationExposureCode(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set RadiationExposureCode=$Piece($Get(^|NS|DPT(PatientIEN,.321)),"^",12)
	If RadiationExposureCode]"" {
		Set Codes=$Piece($Get(^|NS|DD(2,.3212,0)),"^",3)
		Set zz=1
		While ($Piece(Codes,";",zz)]"") {
			Set Code=$Piece($Piece(Codes,";",zz),":",1)
			If (Code=RadiationExposureCode) {
				Set RadiationExposureCode=$Piece($Piece(Codes,";",zz),":",2)
			}
			Set zz=zz+1
		}
		Kill zz,Codes,Code
		}
	Set RadiationExposureCode=$Extract(RadiationExposureCode,1,50)
	If ..RadiationExposureCode'=RadiationExposureCode {
		Set ..RadiationExposureCode=RadiationExposureCode
		Set Flag=1
	}
	Quit Flag
}

Method setRadiationExposureCodeCode(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set RadiationExposureCodeCode=$Piece($Get(^|NS|DPT(PatientIEN,.321)),"^",12)
	Set RadiationExposureCodeCode=$Extract(RadiationExposureCodeCode,1,50)
	If ..RadiationExposureCodeCode'=RadiationExposureCodeCode {
		Set ..RadiationExposureCodeCode=RadiationExposureCodeCode
		Set Flag=1
	}
	Quit Flag
}

Method setReligionIEN(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set ReligionIEN=$Piece($Get(^|NS|DPT(PatientIEN,0)),"^",8)
	Set ReligionIEN=$Extract(ReligionIEN,1,50)
	If ..ReligionIEN'=ReligionIEN {
		Set ..ReligionIEN=ReligionIEN
		Set Flag=1
	}
	Quit Flag
}

Method setSHADFlag(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set SHADFlag=$Piece($Get(^|NS|DPT(PatientIEN,.321)),"^",15)
	Set SHADFlag=$Case(SHADFlag,"1":"Y","0":"N",:$Extract(SHADFlag,1))
	Set SHADFlag=$Extract(SHADFlag,1,1)
	If ..SHADFlag'=SHADFlag {
		Set ..SHADFlag=SHADFlag
		Set Flag=1
	}
	Quit Flag
}

Method setSHADFlagCode(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set SHADFlagCode=$Piece($Get(^|NS|DPT(PatientIEN,.321)),"^",15)
	Set SHADFlagCode=$Extract(SHADFlagCode,1,50)
	If ..SHADFlagCode'=SHADFlagCode {
		Set ..SHADFlagCode=SHADFlagCode
		Set Flag=1
	}
	Quit Flag
}

Method setSSNVerificationStatus(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set SSNVerificationStatus=$Piece($Get(^|NS|DPT(PatientIEN,"SSN")),"^",2)
	If SSNVerificationStatus]"" {
		Set Codes=$Piece($Get(^|NS|DD(2,.0907,0)),"^",3)
		Set zz=1
		While ($Piece(Codes,";",zz)]"") {
			Set Code=$Piece($Piece(Codes,";",zz),":",1)
			If (Code=SSNVerificationStatus) {
				Set SSNVerificationStatus=$Piece($Piece(Codes,";",zz),":",2)
			}
			Set zz=zz+1
		}
		Kill zz,Codes,Code
		}
	Set SSNVerificationStatus=$Extract(SSNVerificationStatus,1,50)
	If ..SSNVerificationStatus'=SSNVerificationStatus {
		Set ..SSNVerificationStatus=SSNVerificationStatus
		Set Flag=1
	}
	Quit Flag
}

Method setSSNVerificationStatusCode(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set SSNVerificationStatusCode=$Piece($Get(^|NS|DPT(PatientIEN,"SSN")),"^",2)
	Set SSNVerificationStatusCode=$Extract(SSNVerificationStatusCode,1,50)
	If ..SSNVerificationStatusCode'=SSNVerificationStatusCode {
		Set ..SSNVerificationStatusCode=SSNVerificationStatusCode
		Set Flag=1
	}
	Quit Flag
}

Method setScrSSN(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set ScrSSN=$Piece($Get(^|NS|DPT(PatientIEN,0)),"^",9)
	Set ScrSSN=$Extract(ScrSSN,1,50)
	If ..ScrSSN'=ScrSSN {
		Set ..ScrSSN=ScrSSN
		Set Flag=1
	}
	Quit Flag
}

Method setSelfIdentifiedGender(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set SelfIdentifiedGender=$Piece($Get(^|NS|DPT(PatientIEN,.24)),"^",4)
	If SelfIdentifiedGender]"" {
		Set Codes=$Piece($Get(^|NS|DD(2,.024,0)),"^",3)
		Set zz=1
		While ($Piece(Codes,";",zz)]"") {
			Set Code=$Piece($Piece(Codes,";",zz),":",1)
			If (Code=SelfIdentifiedGender) {
				Set SelfIdentifiedGender=$Piece($Piece(Codes,";",zz),":",2)
			}
			Set zz=zz+1
		}
		Kill zz,Codes,Code
		}
	Set SelfIdentifiedGender=$Extract(SelfIdentifiedGender,1,50)
	If ..SelfIdentifiedGender'=SelfIdentifiedGender {
		Set ..SelfIdentifiedGender=SelfIdentifiedGender
		Set Flag=1
	}
	Quit Flag
}

Method setSelfIdentifiedGenderCode(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set SelfIdentifiedGenderCode=$Piece($Get(^|NS|DPT(PatientIEN,.24)),"^",4)
	Set SelfIdentifiedGenderCode=$Extract(SelfIdentifiedGenderCode,1,50)
	If ..SelfIdentifiedGenderCode'=SelfIdentifiedGenderCode {
		Set ..SelfIdentifiedGenderCode=SelfIdentifiedGenderCode
		Set Flag=1
	}
	Quit Flag
}

Method setSensitiveFlag(NS As %String, PatientIEN As %String) As %Integer
{
	//DONE 07/13/18: Special Handling Flag Set. - done/checked mlb 1/30/2018
	//"0":"N","1":"Y",:$Extract(SensitiveFlag,1)
	Set Flag=0
	Set SensitiveFlag=$Piece($Get(^|NS|DGSL(38.1,PatientIEN,0)),"^",2)
	Set SensitiveFlag=$Case(SensitiveFlag,"0":"N","1":"Y",:$Extract(SensitiveFlag,1))
	Set SensitiveFlag=$Extract(SensitiveFlag,1,1)
	If ..SensitiveFlag'=SensitiveFlag {
		Set ..SensitiveFlag=SensitiveFlag
		Set Flag=1
	}
	Quit Flag
}

Method setSensitiveFlagCode(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set SensitiveFlagCode=$Piece($Get(^|NS|DGSL(38.1,PatientIEN,0)),"^",2)
	Set SensitiveFlagCode=$Extract(SensitiveFlagCode,1,50)
	If ..SensitiveFlagCode'=SensitiveFlagCode {
		Set ..SensitiveFlagCode=SensitiveFlagCode
		Set Flag=1
	}
	Quit Flag
}

Method setServiceConnectedFlag(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set ServiceConnectedFlag=$Piece($Get(^|NS|DPT(PatientIEN,.3)),"^",1)
	Set ServiceConnectedFlag=$Case(ServiceConnectedFlag,"Y":"Y","N":"N",:$Extract(ServiceConnectedFlag,1))
	Set ServiceConnectedFlag=$Extract(ServiceConnectedFlag,1,1)
	If ..ServiceConnectedFlag'=ServiceConnectedFlag {
		Set ..ServiceConnectedFlag=ServiceConnectedFlag
		Set Flag=1
	}
	Quit Flag
}

Method setServiceConnectedFlagCode(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set ServiceConnectedFlagCode=$Piece($Get(^|NS|DPT(PatientIEN,.3)),"^",1)
	Set ServiceConnectedFlagCode=$Extract(ServiceConnectedFlagCode,1,50)
	If ..ServiceConnectedFlagCode'=ServiceConnectedFlagCode {
		Set ..ServiceConnectedFlagCode=ServiceConnectedFlagCode
		Set Flag=1
	}
	Quit Flag
}

Method setSouthwestAsiaCondition(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set SouthwestAsiaCondition=$Piece($Get(^|NS|DPT(PatientIEN,.322)),"^",13)
	If SouthwestAsiaCondition]"" {
		Set Codes=$Piece($Get(^|NS|DD(2,.322013,0)),"^",3)
		Set zz=1
		While ($Piece(Codes,";",zz)]"") {
			Set Code=$Piece($Piece(Codes,";",zz),":",1)
			If (Code=SouthwestAsiaCondition) {
				Set SouthwestAsiaCondition=$Piece($Piece(Codes,";",zz),":",2)
			}
			Set zz=zz+1
		}
		Kill zz,Codes,Code
		}
	Set SouthwestAsiaCondition=$Extract(SouthwestAsiaCondition,1,50)
	If ..SouthwestAsiaCondition'=SouthwestAsiaCondition {
		Set ..SouthwestAsiaCondition=SouthwestAsiaCondition
		Set Flag=1
	}
	Quit Flag
}

Method setSouthwestAsiaConditionCode(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set SouthwestAsiaConditionCode=$Piece($Get(^|NS|DPT(PatientIEN,.322)),"^",13)
	Set SouthwestAsiaConditionCode=$Extract(SouthwestAsiaConditionCode,1,50)
	If ..SouthwestAsiaConditionCode'=SouthwestAsiaConditionCode {
		Set ..SouthwestAsiaConditionCode=SouthwestAsiaConditionCode
		Set Flag=1
	}
	Quit Flag
}

Method setStateCountyIEN(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set StateCountyIEN=$Piece($Get(^|NS|DPT(PatientIEN,.11)),"^",7)
	Set StateCountyIEN=$Extract(StateCountyIEN,1,50)
	If ..StateCountyIEN'=StateCountyIEN {
		Set ..StateCountyIEN=StateCountyIEN
		Set Flag=1
	}
	Quit Flag
}

Method setStateIEN(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set StateIEN=$Piece($Get(^|NS|DPT(PatientIEN,.11)),"^",5)
	Set StateIEN=$Extract(StateIEN,1,50)
	If ..StateIEN'=StateIEN {
		Set ..StateIEN=StateIEN
		Set Flag=1
	}
	Quit Flag
}

Method setStreetAddress1(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set StreetAddress1=$Piece($Get(^|NS|DPT(PatientIEN,.11)),"^",1)
	Set StreetAddress1=$Extract(StreetAddress1,1,50)
	If ..StreetAddress1'=StreetAddress1 {
		Set ..StreetAddress1=StreetAddress1
		Set Flag=1
	}
	Quit Flag
}

Method setStreetAddress2(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set StreetAddress2=$Piece($Get(^|NS|DPT(PatientIEN,.11)),"^",2)
	Set StreetAddress2=$Extract(StreetAddress2,1,50)
	If ..StreetAddress2'=StreetAddress2 {
		Set ..StreetAddress2=StreetAddress2
		Set Flag=1
	}
	Quit Flag
}

Method setTestPatientFlag(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set TestPatientFlag=$Piece($Get(^|NS|DPT(PatientIEN,0)),"^",21)
	Set TestPatientFlag=$Case(TestPatientFlag,"1":"Y","2":"N",:$Extract(TestPatientFlag,1))
	Set TestPatientFlag=$Extract(TestPatientFlag,1,1)
	If ..TestPatientFlag'=TestPatientFlag {
		Set ..TestPatientFlag=TestPatientFlag
		Set Flag=1
	}
	Quit Flag
}

Method setTestPatientFlagCode(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set TestPatientFlagCode=$Piece($Get(^|NS|DPT(PatientIEN,0)),"^",21)
	Set TestPatientFlagCode=$Extract(TestPatientFlagCode,1,50)
	If ..TestPatientFlagCode'=TestPatientFlagCode {
		Set ..TestPatientFlagCode=TestPatientFlagCode
		Set Flag=1
	}
	Quit Flag
}

Method setVeteranFlag(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set VeteranFlag=$Piece($Get(^|NS|DPT(PatientIEN,"VET")),"^",1)
	Set VeteranFlag=$Case(VeteranFlag,"Y":"Y","N":"N",:$Extract(VeteranFlag,1))
	Set VeteranFlag=$Extract(VeteranFlag,1,1)
	If ..VeteranFlag'=VeteranFlag {
		Set ..VeteranFlag=VeteranFlag
		Set Flag=1
	}
	Quit Flag
}

Method setVeteranFlagCode(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set VeteranFlagCode=$Piece($Get(^|NS|DPT(PatientIEN,"VET")),"^",1)
	Set VeteranFlagCode=$Extract(VeteranFlagCode,1,50)
	If ..VeteranFlagCode'=VeteranFlagCode {
		Set ..VeteranFlagCode=VeteranFlagCode
		Set Flag=1
	}
	Quit Flag
}

Method setVeteranTransportationProgramFlag(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set VeteranTransportationProgramFlag=$Piece($Get(^|NS|DPT(PatientIEN,3000)),"^",1)
	Set VeteranTransportationProgramFlag=$Case(VeteranTransportationProgramFlag,"0":"N","1":"Y",:$Extract(VeteranTransportationProgramFlag,1))
	Set VeteranTransportationProgramFlag=$Extract(VeteranTransportationProgramFlag,1,1)
	If ..VeteranTransportationProgramFlag'=VeteranTransportationProgramFlag {
		Set ..VeteranTransportationProgramFlag=VeteranTransportationProgramFlag
		Set Flag=1
	}
	Quit Flag
}

Method setVeteranTransportationProgramFlagCode(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set VeteranTransportationProgramFlagCode=$Piece($Get(^|NS|DPT(PatientIEN,3000)),"^",1)
	Set VeteranTransportationProgramFlagCode=$Extract(VeteranTransportationProgramFlagCode,1,50)
	If ..VeteranTransportationProgramFlagCode'=VeteranTransportationProgramFlagCode {
		Set ..VeteranTransportationProgramFlagCode=VeteranTransportationProgramFlagCode
		Set Flag=1
	}
	Quit Flag
}

Method setVietnamServiceFlag(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set VietnamServiceFlag=$Piece($Get(^|NS|DPT(PatientIEN,.321)),"^",1)
	Set VietnamServiceFlag=$Extract(VietnamServiceFlag,1,1)
	If ..VietnamServiceFlag'=VietnamServiceFlag {
		Set ..VietnamServiceFlag=VietnamServiceFlag
		Set Flag=1
	}
	Quit Flag
}

Method setVietnamServiceFlagCode(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set VietnamServiceFlagCode=$Piece($Get(^|NS|DPT(PatientIEN,.321)),"^",1)
	Set VietnamServiceFlagCode=$Extract(VietnamServiceFlagCode,1,50)
	If ..VietnamServiceFlagCode'=VietnamServiceFlagCode {
		Set ..VietnamServiceFlagCode=VietnamServiceFlagCode
		Set Flag=1
	}
	Quit Flag
}

Method setZip(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set Zip=$Piece($Get(^|NS|DPT(PatientIEN,.11)),"^",6)
	Set Zip=$Extract(Zip,1,50)
	If ..Zip'=Zip {
		Set ..Zip=Zip
		Set Flag=1
	}
	Quit Flag
}

Method setZip4(NS As %String, PatientIEN As %String) As %Integer
{
	Set Flag=0
	Set Zip4=$Piece($Get(^|NS|DPT(PatientIEN,.11)),"^",12)
	Set Zip4=$Extract(Zip4,1,50)
	If ..Zip4'=Zip4 {
		Set ..Zip4=Zip4
		Set Flag=1
	}
	Quit Flag
}

ClassMethod CheckVX130ToVISTA(Sta3n As %Integer, StartIEN As %String = 0, EndIEN As %Integer = "") As %Integer
{
	Write Sta3n,!,$ZDateTime($H,3),!
	Set VistaSite=##class(VX130.VistaSite).%OpenId(Sta3n)
	Set NS=VistaSite.VistaSiteNamespace
	Set LastIEN=""
	Set Count=0
	Set:LastIEN="" LastIEN=$Order(^|NS|DPT("A"),-1)
	Set SQL="SELECT PatientIEN FROM SPatient.SPatient_2_v123 WHERE CAST(PatientIEN As Numeric)>="_StartIEN_" AND CAST(PatientIEN As Numeric)<="_EndIEN_"  AND Sta3n="_Sta3n_" AND OpCode IS NULL ORDER BY CAST(PatientIEN As Numeric)"
	//Write SQL,!
	Set tStatement=##class(%SQL.Statement).%New()
	Set Status=tStatement.%Prepare(SQL)
	Set rSet=tStatement.%Execute()
	While(rSet.%Next()) {
		Set PatientIEN=rSet.PatientIEN
		Set LastIEN=PatientIEN
		Set Count=Count+1
		If $Get(^|NS|DPT(D0,0))=""
		{
			//Set qcid=##class(QC.QualityCheckHistory).GetID("VX130",Sta3n,..%ClassName(1))
			//Do ##class(QC.Detail).AddEntry(qcid,Sta3n_"||"_$Replace(LastIEN,",","||"),"1")
		}
		//If '(Count#10000) Do ##class(QC.QualityCheckHistory).UpdateDQStatus("VX130",Sta3n,..%ClassName(1),LastIEN)
	}
	//Do ##class(QC.QualityCheckHistory).UpdateDQStatus("VX130",Sta3n,..%ClassName(1),LastIEN)
	//Do ##class(QC.QualityCheckHistory).EndQualityCheck("VX130",Sta3n,..%ClassName(1))
	Quit
}

ClassMethod ToJSONObject(id As %String) As %DynamicObject
{
	Set oref=..%OpenId(id,0,.sc)
	Set jsonObj=##class(%DynamicObject).%New()
	If $IsObject(oref) {
		Set jsonObj.Sta3n=+oref.Sta3n
		Set jsonObj.PatientIEN=oref.PatientIEN
		Set:oref.PatientFirstName]"" jsonObj.PatientFirstName=oref.PatientFirstName
		Set:oref.PatientLastName]"" jsonObj.PatientLastName=oref.PatientLastName
		Set:oref.PatientName]"" jsonObj.PatientName=oref.PatientName
		Set:oref.Gender]"" jsonObj.Gender=oref.Gender
		Set:oref.GenderCode]"" jsonObj.GenderCode=oref.GenderCode
		Set:oref.BirthDateTime]"" jsonObj.BirthDateTime=+oref.BirthDateTime
		Set:oref.BirthFMDate]"" jsonObj.BirthFMDate=oref.BirthFMDate
		Set:oref.MaritalStatusIEN]"" jsonObj.MaritalStatusIEN=oref.MaritalStatusIEN
		Set:oref.ReligionIEN]"" jsonObj.ReligionIEN=oref.ReligionIEN
		Set:oref.DuplicateRecordStatus]"" jsonObj.DuplicateRecordStatus=oref.DuplicateRecordStatus
		Set:oref.DuplicateRecordStatusCode]"" jsonObj.DuplicateRecordStatusCode=oref.DuplicateRecordStatusCode
		Set:oref.DestinationMergePatientIEN]"" jsonObj.DestinationMergePatientIEN=oref.DestinationMergePatientIEN
		Set:oref.PatientSSN]"" jsonObj.PatientSSN=oref.PatientSSN
		Set:oref.ScrSSN]"" jsonObj.ScrSSN=oref.ScrSSN
		Set:oref.PseudoSSNReason]"" jsonObj.PseudoSSNReason=oref.PseudoSSNReason
		Set:oref.PseudoSSNReasonCode]"" jsonObj.PseudoSSNReasonCode=oref.PseudoSSNReasonCode
		Set:oref.SSNVerificationStatus]"" jsonObj.SSNVerificationStatus=oref.SSNVerificationStatus
		Set:oref.SSNVerificationStatusCode]"" jsonObj.SSNVerificationStatusCode=oref.SSNVerificationStatusCode
		Set:oref.PatientEnteredRemark]"" jsonObj.PatientEnteredRemark=oref.PatientEnteredRemark
		Set:oref.PatientEnteredByStaffIEN]"" jsonObj.PatientEnteredByStaffIEN=oref.PatientEnteredByStaffIEN
		Set:oref.PatientEnteredDateTime]"" jsonObj.PatientEnteredDateTime=+oref.PatientEnteredDateTime
		Set:oref.PatientEnteredFMDate]"" jsonObj.PatientEnteredFMDate=oref.PatientEnteredFMDate
		Set:oref.PatientEnteredCode]"" jsonObj.PatientEnteredCode=oref.PatientEnteredCode
		Set:oref.PatientEnteredCodeCode]"" jsonObj.PatientEnteredCodeCode=oref.PatientEnteredCodeCode
		Set:oref.StreetAddress1]"" jsonObj.StreetAddress1=oref.StreetAddress1
		Set:oref.Zip4]"" jsonObj.Zip4=oref.Zip4
		Set:oref.StreetAddress2]"" jsonObj.StreetAddress2=oref.StreetAddress2
		Set:oref.City]"" jsonObj.City=oref.City
		Set:oref.StateIEN]"" jsonObj.StateIEN=oref.StateIEN
		Set:oref.Zip]"" jsonObj.Zip=oref.Zip
		Set:oref.StateCountyIEN]"" jsonObj.StateCountyIEN=oref.StateCountyIEN
		Set:oref.BadAddressIndicator]"" jsonObj.BadAddressIndicator=oref.BadAddressIndicator
		Set:oref.BadAddressIndicatorCode]"" jsonObj.BadAddressIndicatorCode=oref.BadAddressIndicatorCode
		Set:oref.CurrentMeansTestStatusIEN]"" jsonObj.CurrentMeansTestStatusIEN=oref.CurrentMeansTestStatusIEN
		Set:oref.IneligibleDateTime]"" jsonObj.IneligibleDateTime=+oref.IneligibleDateTime
		Set:oref.IneligibleFMDate]"" jsonObj.IneligibleFMDate=oref.IneligibleFMDate
		Set:oref.PatientMissingDateTime]"" jsonObj.PatientMissingDateTime=+oref.PatientMissingDateTime
		Set:oref.PatientMissingFMDate]"" jsonObj.PatientMissingFMDate=oref.PatientMissingFMDate
		Set:oref.IneligibleSource]"" jsonObj.IneligibleSource=oref.IneligibleSource
		Set:oref.IneligibleSourceCode]"" jsonObj.IneligibleSourceCode=oref.IneligibleSourceCode
		Set:oref.IneligibleCity]"" jsonObj.IneligibleCity=oref.IneligibleCity
		Set:oref.IneligibleStateIEN]"" jsonObj.IneligibleStateIEN=oref.IneligibleStateIEN
		Set:oref.IneligibleVAROReason]"" jsonObj.IneligibleVAROReason=oref.IneligibleVAROReason
		Set:oref.PatientMissingSource]"" jsonObj.PatientMissingSource=oref.PatientMissingSource
		Set:oref.PatientMissingSourceCode]"" jsonObj.PatientMissingSourceCode=oref.PatientMissingSourceCode
		Set:oref.PatientMissingCity]"" jsonObj.PatientMissingCity=oref.PatientMissingCity
		Set:oref.PatientMissingStateIEN]"" jsonObj.PatientMissingStateIEN=oref.PatientMissingStateIEN
		Set:oref.EmergencyResponseIndicator]"" jsonObj.EmergencyResponseIndicator=oref.EmergencyResponseIndicator
		Set:oref.EmergencyResponseIndicatorCode]"" jsonObj.EmergencyResponseIndicatorCode=oref.EmergencyResponseIndicatorCode
		Set:oref.ServiceConnectedFlag]"" jsonObj.ServiceConnectedFlag=oref.ServiceConnectedFlag
		Set:oref.ServiceConnectedFlagCode]"" jsonObj.ServiceConnectedFlagCode=oref.ServiceConnectedFlagCode
		Set:oref.PercentServiceConnect]"" jsonObj.PercentServiceConnect=oref.PercentServiceConnect
		Set:oref.IneligibleReason]"" jsonObj.IneligibleReason=oref.IneligibleReason
		Set:oref.FederalAgencyIEN]"" jsonObj.FederalAgencyIEN=oref.FederalAgencyIEN
		Set:oref.GovernmentEmployeeFlag]"" jsonObj.GovernmentEmployeeFlag=oref.GovernmentEmployeeFlag
		Set:oref.GovernmentEmployeeFlagCode]"" jsonObj.GovernmentEmployeeFlagCode=oref.GovernmentEmployeeFlagCode
		Set:oref.InsuranceCoverageFlag]"" jsonObj.InsuranceCoverageFlag=oref.InsuranceCoverageFlag
		Set:oref.InsuranceCoverageFlagCode]"" jsonObj.InsuranceCoverageFlagCode=oref.InsuranceCoverageFlagCode
		Set:oref.VietnamServiceFlag]"" jsonObj.VietnamServiceFlag=oref.VietnamServiceFlag
		Set:oref.VietnamServiceFlagCode]"" jsonObj.VietnamServiceFlagCode=oref.VietnamServiceFlagCode
		Set:oref.AgentOrangeExposureFlag]"" jsonObj.AgentOrangeExposureFlag=oref.AgentOrangeExposureFlag
		Set:oref.AgentOrangeExposureFlagCode]"" jsonObj.AgentOrangeExposureFlagCode=oref.AgentOrangeExposureFlagCode
		Set:oref.IonizingRadiationExposureFlag]"" jsonObj.IonizingRadiationExposureFlag=oref.IonizingRadiationExposureFlag
		Set:oref.IonizingRadiationExposureFlagCode]"" jsonObj.IonizingRadiationExposureFlagCode=oref.IonizingRadiationExposureFlagCode
		Set:oref.SHADFlag]"" jsonObj.SHADFlag=oref.SHADFlag
		Set:oref.SHADFlagCode]"" jsonObj.SHADFlagCode=oref.SHADFlagCode
		Set:oref.RadiationExposureCode]"" jsonObj.RadiationExposureCode=oref.RadiationExposureCode
		Set:oref.RadiationExposureCodeCode]"" jsonObj.RadiationExposureCodeCode=oref.RadiationExposureCodeCode
		Set:oref.AgentOrangeLocationCode]"" jsonObj.AgentOrangeLocationCode=oref.AgentOrangeLocationCode
		Set:oref.AgentOrangeLocationCodeCode]"" jsonObj.AgentOrangeLocationCodeCode=oref.AgentOrangeLocationCodeCode
		Set:oref.FilipinoVeteranCode]"" jsonObj.FilipinoVeteranCode=oref.FilipinoVeteranCode
		Set:oref.FilipinoVeteranCodeCode]"" jsonObj.FilipinoVeteranCodeCode=oref.FilipinoVeteranCodeCode
		Set:oref.SouthwestAsiaCondition]"" jsonObj.SouthwestAsiaCondition=oref.SouthwestAsiaCondition
		Set:oref.SouthwestAsiaConditionCode]"" jsonObj.SouthwestAsiaConditionCode=oref.SouthwestAsiaConditionCode
		Set:oref.PeriodOfServiceIEN]"" jsonObj.PeriodOfServiceIEN=oref.PeriodOfServiceIEN
		Set:oref.DeathDateTime]"" jsonObj.DeathDateTime=+oref.DeathDateTime
		Set:oref.DeathFMDate]"" jsonObj.DeathFMDate=oref.DeathFMDate
		Set:oref.DeathEnteredByStaffIEN]"" jsonObj.DeathEnteredByStaffIEN=oref.DeathEnteredByStaffIEN
		Set:oref.DeathNotificationSource]"" jsonObj.DeathNotificationSource=oref.DeathNotificationSource
		Set:oref.DeathModifiedDateTime]"" jsonObj.DeathModifiedDateTime=+oref.DeathModifiedDateTime
		Set:oref.DeathModifiedFMDate]"" jsonObj.DeathModifiedFMDate=oref.DeathModifiedFMDate
		Set:oref.DeathLastUpdatedByStaffIEN]"" jsonObj.DeathLastUpdatedByStaffIEN=oref.DeathLastUpdatedByStaffIEN
		Set:oref.CollateralSponsorPatientIEN]"" jsonObj.CollateralSponsorPatientIEN=oref.CollateralSponsorPatientIEN
		Set:oref.EligibilityIEN]"" jsonObj.EligibilityIEN=oref.EligibilityIEN
		Set:oref.EligibilityVACode]"" jsonObj.EligibilityVACode=oref.EligibilityVACode
		Set:oref.EligibilityStatus]"" jsonObj.EligibilityStatus=oref.EligibilityStatus
		Set:oref.EligibilityStatusCode]"" jsonObj.EligibilityStatusCode=oref.EligibilityStatusCode
		Set:oref.EligibilityStatusDateTime]"" jsonObj.EligibilityStatusDateTime=+oref.EligibilityStatusDateTime
		Set:oref.EligibilityStatusFMDate]"" jsonObj.EligibilityStatusFMDate=oref.EligibilityStatusFMDate
		Set:oref.EligibilityVerificationSource]"" jsonObj.EligibilityVerificationSource=oref.EligibilityVerificationSource
		Set:oref.EligibilityVerificationSourceCode]"" jsonObj.EligibilityVerificationSourceCode=oref.EligibilityVerificationSourceCode
		Set:oref.EligibilityInterimDateTime]"" jsonObj.EligibilityInterimDateTime=+oref.EligibilityInterimDateTime
		Set:oref.EligibilityInterimFMDate]"" jsonObj.EligibilityInterimFMDate=oref.EligibilityInterimFMDate
		Set:oref.EligibilityVerificationMethod]"" jsonObj.EligibilityVerificationMethod=oref.EligibilityVerificationMethod
		Set:oref.EligibilityEnteredStaffIEN]"" jsonObj.EligibilityEnteredStaffIEN=oref.EligibilityEnteredStaffIEN
		Set:oref.MedicaidEligibleFlag]"" jsonObj.MedicaidEligibleFlag=oref.MedicaidEligibleFlag
		Set:oref.MedicaidEligibleFlagCode]"" jsonObj.MedicaidEligibleFlagCode=oref.MedicaidEligibleFlagCode
		Set:oref.MedicaidInquireDateTime]"" jsonObj.MedicaidInquireDateTime=+oref.MedicaidInquireDateTime
		Set:oref.MedicaidInquireFMDate]"" jsonObj.MedicaidInquireFMDate=oref.MedicaidInquireFMDate
		Set:oref.MedicaidNumber]"" jsonObj.MedicaidNumber=oref.MedicaidNumber
		Set:oref.POWFlag]"" jsonObj.POWFlag=oref.POWFlag
		Set:oref.POWFlagCode]"" jsonObj.POWFlagCode=oref.POWFlagCode
		Set:oref.POWLocationIEN]"" jsonObj.POWLocationIEN=oref.POWLocationIEN
		Set:oref.CombatFlag]"" jsonObj.CombatFlag=oref.CombatFlag
		Set:oref.CombatFlagCode]"" jsonObj.CombatFlagCode=oref.CombatFlagCode
		Set:oref.CombatFromDate]"" jsonObj.CombatFromDate=+oref.CombatFromDate
		Set:oref.CombatFromFMDate]"" jsonObj.CombatFromFMDate=oref.CombatFromFMDate
		Set:oref.CombatToDate]"" jsonObj.CombatToDate=+oref.CombatToDate
		Set:oref.CombatToFMDate]"" jsonObj.CombatToFMDate=oref.CombatToFMDate
		Set:oref.CombatEligibilityEndDate]"" jsonObj.CombatEligibilityEndDate=+oref.CombatEligibilityEndDate
		Set:oref.CombatEligibilityEndFMDate]"" jsonObj.CombatEligibilityEndFMDate=oref.CombatEligibilityEndFMDate
		Set:oref.TestPatientFlag]"" jsonObj.TestPatientFlag=oref.TestPatientFlag
		Set:oref.TestPatientFlagCode]"" jsonObj.TestPatientFlagCode=oref.TestPatientFlagCode
		Set:oref.CurrentEnrollmentIEN]"" jsonObj.CurrentEnrollmentIEN=oref.CurrentEnrollmentIEN
		Set:oref.PreferredInstitutionIEN]"" jsonObj.PreferredInstitutionIEN=oref.PreferredInstitutionIEN
		Set:oref.PatientTypeIEN]"" jsonObj.PatientTypeIEN=oref.PatientTypeIEN
		Set:oref.PatientICN]"" jsonObj.PatientICN=oref.PatientICN
		Set:oref.FugitiveFelonFlag]"" jsonObj.FugitiveFelonFlag=oref.FugitiveFelonFlag
		Set:oref.FugitiveFelonFlagCode]"" jsonObj.FugitiveFelonFlagCode=oref.FugitiveFelonFlagCode
		Set:oref.FFFEnteredStaffIEN]"" jsonObj.FFFEnteredStaffIEN=oref.FFFEnteredStaffIEN
		Set:oref.FFFEnteredDateTime]"" jsonObj.FFFEnteredDateTime=+oref.FFFEnteredDateTime
		Set:oref.FFFEnteredFMDate]"" jsonObj.FFFEnteredFMDate=oref.FFFEnteredFMDate
		Set:oref.FFFRemovedStaffIEN]"" jsonObj.FFFRemovedStaffIEN=oref.FFFRemovedStaffIEN
		Set:oref.FFFRemovedDateTime]"" jsonObj.FFFRemovedDateTime=+oref.FFFRemovedDateTime
		Set:oref.FFFRemovedFMDate]"" jsonObj.FFFRemovedFMDate=oref.FFFRemovedFMDate
		Set:oref.FFFRemovedReason]"" jsonObj.FFFRemovedReason=oref.FFFRemovedReason
		Set:oref.VeteranFlag]"" jsonObj.VeteranFlag=oref.VeteranFlag
		Set:oref.VeteranFlagCode]"" jsonObj.VeteranFlagCode=oref.VeteranFlagCode
		Set:oref.ODSTreatmentDateTime]"" jsonObj.ODSTreatmentDateTime=+oref.ODSTreatmentDateTime
		Set:oref.ODSTreatmentFMDate]"" jsonObj.ODSTreatmentFMDate=oref.ODSTreatmentFMDate
		Set:oref.ODSRecalledCode]"" jsonObj.ODSRecalledCode=oref.ODSRecalledCode
		Set:oref.ODSRecalledCodeCode]"" jsonObj.ODSRecalledCodeCode=oref.ODSRecalledCodeCode
		Set:oref.ODSRankType]"" jsonObj.ODSRankType=oref.ODSRankType
		Set:oref.OperationDesertShieldRank]"" jsonObj.OperationDesertShieldRank=oref.OperationDesertShieldRank
		Set:oref.SensitiveFlag]"" jsonObj.SensitiveFlag=oref.SensitiveFlag
		Set:oref.SensitiveFlagCode]"" jsonObj.SensitiveFlagCode=oref.SensitiveFlagCode
		Set:oref.PreferredInstitutionSource]"" jsonObj.PreferredInstitutionSource=oref.PreferredInstitutionSource
		Set:oref.PreferredInstitutionSourceCode]"" jsonObj.PreferredInstitutionSourceCode=oref.PreferredInstitutionSourceCode
		Set:oref.VeteranTransportationProgramFlag]"" jsonObj.VeteranTransportationProgramFlag=oref.VeteranTransportationProgramFlag
		Set:oref.VeteranTransportationProgramFlagCode]"" jsonObj.VeteranTransportationProgramFlagCode=oref.VeteranTransportationProgramFlagCode
		Set:oref.SelfIdentifiedGender]"" jsonObj.SelfIdentifiedGender=oref.SelfIdentifiedGender
		Set:oref.SelfIdentifiedGenderCode]"" jsonObj.SelfIdentifiedGenderCode=oref.SelfIdentifiedGenderCode
		Set:oref.DeathDocumentationType]"" jsonObj.DeathDocumentationType=oref.DeathDocumentationType
		Set:oref.OpCode]"" jsonObj.OpCode=oref.OpCode
		Set:oref.VistaCreateDate]"" jsonObj.VistaCreateDate=oref.VistaCreateDate
		Set:oref.VistaEditDate]"" jsonObj.VistaEditDate=oref.VistaEditDate
	}
	Quit jsonObj
}

Storage Default
{
<Data name="SPatient2v123DefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>AgentOrangeExposureFlag</Value>
</Value>
<Value name="3">
<Value>AgentOrangeExposureFlagCode</Value>
</Value>
<Value name="4">
<Value>AgentOrangeLocationCode</Value>
</Value>
<Value name="5">
<Value>AgentOrangeLocationCodeCode</Value>
</Value>
<Value name="6">
<Value>BadAddressIndicator</Value>
</Value>
<Value name="7">
<Value>BadAddressIndicatorCode</Value>
</Value>
<Value name="8">
<Value>BirthDateTime</Value>
</Value>
<Value name="9">
<Value>BirthFMDate</Value>
</Value>
<Value name="10">
<Value>City</Value>
</Value>
<Value name="11">
<Value>CollateralSponsorPatientIEN</Value>
</Value>
<Value name="12">
<Value>CombatEligibilityEndDate</Value>
</Value>
<Value name="13">
<Value>CombatEligibilityEndFMDate</Value>
</Value>
<Value name="14">
<Value>CombatFlag</Value>
</Value>
<Value name="15">
<Value>CombatFlagCode</Value>
</Value>
<Value name="16">
<Value>CombatFromDate</Value>
</Value>
<Value name="17">
<Value>CombatFromFMDate</Value>
</Value>
<Value name="18">
<Value>CombatToDate</Value>
</Value>
<Value name="19">
<Value>CombatToFMDate</Value>
</Value>
<Value name="20">
<Value>CurrentEnrollmentIEN</Value>
</Value>
<Value name="21">
<Value>CurrentMeansTestStatusIEN</Value>
</Value>
<Value name="22">
<Value>DeathDateTime</Value>
</Value>
<Value name="23">
<Value>DeathDocumentationType</Value>
</Value>
<Value name="24">
<Value>DeathEnteredByStaffIEN</Value>
</Value>
<Value name="25">
<Value>DeathFMDate</Value>
</Value>
<Value name="26">
<Value>DeathLastUpdatedByStaffIEN</Value>
</Value>
<Value name="27">
<Value>DeathModifiedDateTime</Value>
</Value>
<Value name="28">
<Value>DeathModifiedFMDate</Value>
</Value>
<Value name="29">
<Value>DeathNotificationSource</Value>
</Value>
<Value name="30">
<Value>DestinationMergePatientIEN</Value>
</Value>
<Value name="31">
<Value>DuplicateRecordStatus</Value>
</Value>
<Value name="32">
<Value>DuplicateRecordStatusCode</Value>
</Value>
<Value name="33">
<Value>EligibilityEnteredStaffIEN</Value>
</Value>
<Value name="34">
<Value>EligibilityIEN</Value>
</Value>
<Value name="35">
<Value>EligibilityInterimDateTime</Value>
</Value>
<Value name="36">
<Value>EligibilityInterimFMDate</Value>
</Value>
<Value name="37">
<Value>EligibilityStatus</Value>
</Value>
<Value name="38">
<Value>EligibilityStatusCode</Value>
</Value>
<Value name="39">
<Value>EligibilityStatusDateTime</Value>
</Value>
<Value name="40">
<Value>EligibilityStatusFMDate</Value>
</Value>
<Value name="41">
<Value>EligibilityVACode</Value>
</Value>
<Value name="42">
<Value>EligibilityVerificationMethod</Value>
</Value>
<Value name="43">
<Value>EligibilityVerificationSource</Value>
</Value>
<Value name="44">
<Value>EligibilityVerificationSourceCode</Value>
</Value>
<Value name="45">
<Value>EmergencyResponseIndicator</Value>
</Value>
<Value name="46">
<Value>EmergencyResponseIndicatorCode</Value>
</Value>
<Value name="47">
<Value>FFFEnteredDateTime</Value>
</Value>
<Value name="48">
<Value>FFFEnteredFMDate</Value>
</Value>
<Value name="49">
<Value>FFFEnteredStaffIEN</Value>
</Value>
<Value name="50">
<Value>FFFRemovedDateTime</Value>
</Value>
<Value name="51">
<Value>FFFRemovedFMDate</Value>
</Value>
<Value name="52">
<Value>FFFRemovedReason</Value>
</Value>
<Value name="53">
<Value>FFFRemovedStaffIEN</Value>
</Value>
<Value name="54">
<Value>FederalAgencyIEN</Value>
</Value>
<Value name="55">
<Value>FilipinoVeteranCode</Value>
</Value>
<Value name="56">
<Value>FilipinoVeteranCodeCode</Value>
</Value>
<Value name="57">
<Value>FugitiveFelonFlag</Value>
</Value>
<Value name="58">
<Value>FugitiveFelonFlagCode</Value>
</Value>
<Value name="59">
<Value>Gender</Value>
</Value>
<Value name="60">
<Value>GenderCode</Value>
</Value>
<Value name="61">
<Value>GovernmentEmployeeFlag</Value>
</Value>
<Value name="62">
<Value>GovernmentEmployeeFlagCode</Value>
</Value>
<Value name="63">
<Value>IneligibleCity</Value>
</Value>
<Value name="64">
<Value>IneligibleDateTime</Value>
</Value>
<Value name="65">
<Value>IneligibleFMDate</Value>
</Value>
<Value name="66">
<Value>IneligibleReason</Value>
</Value>
<Value name="67">
<Value>IneligibleSource</Value>
</Value>
<Value name="68">
<Value>IneligibleSourceCode</Value>
</Value>
<Value name="69">
<Value>IneligibleStateIEN</Value>
</Value>
<Value name="70">
<Value>IneligibleVAROReason</Value>
</Value>
<Value name="71">
<Value>InsuranceCoverageFlag</Value>
</Value>
<Value name="72">
<Value>InsuranceCoverageFlagCode</Value>
</Value>
<Value name="73">
<Value>IonizingRadiationExposureFlag</Value>
</Value>
<Value name="74">
<Value>IonizingRadiationExposureFlagCode</Value>
</Value>
<Value name="75">
<Value>MaritalStatusIEN</Value>
</Value>
<Value name="76">
<Value>MedicaidEligibleFlag</Value>
</Value>
<Value name="77">
<Value>MedicaidEligibleFlagCode</Value>
</Value>
<Value name="78">
<Value>MedicaidInquireDateTime</Value>
</Value>
<Value name="79">
<Value>MedicaidInquireFMDate</Value>
</Value>
<Value name="80">
<Value>MedicaidNumber</Value>
</Value>
<Value name="81">
<Value>ODSRankType</Value>
</Value>
<Value name="82">
<Value>ODSRecalledCode</Value>
</Value>
<Value name="83">
<Value>ODSRecalledCodeCode</Value>
</Value>
<Value name="84">
<Value>ODSTreatmentDateTime</Value>
</Value>
<Value name="85">
<Value>ODSTreatmentFMDate</Value>
</Value>
<Value name="86">
<Value>OpCode</Value>
</Value>
<Value name="87">
<Value>OperationDesertShieldRank</Value>
</Value>
<Value name="88">
<Value>POWFlag</Value>
</Value>
<Value name="89">
<Value>POWFlagCode</Value>
</Value>
<Value name="90">
<Value>POWLocationIEN</Value>
</Value>
<Value name="91">
<Value>PatientEnteredByStaffIEN</Value>
</Value>
<Value name="92">
<Value>PatientEnteredCode</Value>
</Value>
<Value name="93">
<Value>PatientEnteredCodeCode</Value>
</Value>
<Value name="94">
<Value>PatientEnteredDateTime</Value>
</Value>
<Value name="95">
<Value>PatientEnteredFMDate</Value>
</Value>
<Value name="96">
<Value>PatientEnteredRemark</Value>
</Value>
<Value name="97">
<Value>PatientFirstName</Value>
</Value>
<Value name="98">
<Value>PatientICN</Value>
</Value>
<Value name="99">
<Value>PatientLastName</Value>
</Value>
<Value name="100">
<Value>PatientMissingCity</Value>
</Value>
<Value name="101">
<Value>PatientMissingDateTime</Value>
</Value>
<Value name="102">
<Value>PatientMissingFMDate</Value>
</Value>
<Value name="103">
<Value>PatientMissingSource</Value>
</Value>
<Value name="104">
<Value>PatientMissingSourceCode</Value>
</Value>
<Value name="105">
<Value>PatientMissingStateIEN</Value>
</Value>
<Value name="106">
<Value>PatientName</Value>
</Value>
<Value name="107">
<Value>PatientSSN</Value>
</Value>
<Value name="108">
<Value>PatientTypeIEN</Value>
</Value>
<Value name="109">
<Value>PercentServiceConnect</Value>
</Value>
<Value name="110">
<Value>PeriodOfServiceIEN</Value>
</Value>
<Value name="111">
<Value>PreferredInstitutionIEN</Value>
</Value>
<Value name="112">
<Value>PreferredInstitutionSource</Value>
</Value>
<Value name="113">
<Value>PreferredInstitutionSourceCode</Value>
</Value>
<Value name="114">
<Value>PseudoSSNReason</Value>
</Value>
<Value name="115">
<Value>PseudoSSNReasonCode</Value>
</Value>
<Value name="116">
<Value>RadiationExposureCode</Value>
</Value>
<Value name="117">
<Value>RadiationExposureCodeCode</Value>
</Value>
<Value name="118">
<Value>ReligionIEN</Value>
</Value>
<Value name="119">
<Value>SHADFlag</Value>
</Value>
<Value name="120">
<Value>SHADFlagCode</Value>
</Value>
<Value name="121">
<Value>SSNVerificationStatus</Value>
</Value>
<Value name="122">
<Value>SSNVerificationStatusCode</Value>
</Value>
<Value name="123">
<Value>ScrSSN</Value>
</Value>
<Value name="124">
<Value>SelfIdentifiedGender</Value>
</Value>
<Value name="125">
<Value>SelfIdentifiedGenderCode</Value>
</Value>
<Value name="126">
<Value>SensitiveFlag</Value>
</Value>
<Value name="127">
<Value>SensitiveFlagCode</Value>
</Value>
<Value name="128">
<Value>ServiceConnectedFlag</Value>
</Value>
<Value name="129">
<Value>ServiceConnectedFlagCode</Value>
</Value>
<Value name="130">
<Value>SouthwestAsiaCondition</Value>
</Value>
<Value name="131">
<Value>SouthwestAsiaConditionCode</Value>
</Value>
<Value name="132">
<Value>StateCountyIEN</Value>
</Value>
<Value name="133">
<Value>StateIEN</Value>
</Value>
<Value name="134">
<Value>StreetAddress1</Value>
</Value>
<Value name="135">
<Value>StreetAddress2</Value>
</Value>
<Value name="136">
<Value>TestPatientFlag</Value>
</Value>
<Value name="137">
<Value>TestPatientFlagCode</Value>
</Value>
<Value name="138">
<Value>VeteranFlag</Value>
</Value>
<Value name="139">
<Value>VeteranFlagCode</Value>
</Value>
<Value name="140">
<Value>VeteranTransportationProgramFlag</Value>
</Value>
<Value name="141">
<Value>VeteranTransportationProgramFlagCode</Value>
</Value>
<Value name="142">
<Value>VietnamServiceFlag</Value>
</Value>
<Value name="143">
<Value>VietnamServiceFlagCode</Value>
</Value>
<Value name="144">
<Value>VistaCreateDate</Value>
</Value>
<Value name="145">
<Value>VistaEditDate</Value>
</Value>
<Value name="146">
<Value>Zip</Value>
</Value>
<Value name="147">
<Value>Zip4</Value>
</Value>
</Data>
<DataLocation>^SPatient.SPatient2v123D</DataLocation>
<DefaultData>SPatient2v123DefaultData</DefaultData>
<ExtentSize>1000000</ExtentSize>
<IdLocation>^SPatient.SPatient2v123D</IdLocation>
<IndexLocation>^SPatient.SPatient2v123I</IndexLocation>
<Property name="%%CLASSNAME">
<AverageFieldSize>1</AverageFieldSize>
<OutlierSelectivity>.999767:</OutlierSelectivity>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="%%ID">
<AverageFieldSize>10.61</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<Property name="AgentOrangeExposureFlag">
<AverageFieldSize>.89</AverageFieldSize>
<OutlierSelectivity>.827333:"N"</OutlierSelectivity>
<Selectivity>5.7555%</Selectivity>
</Property>
<Property name="AgentOrangeExposureFlagCode">
<AverageFieldSize>.89</AverageFieldSize>
<OutlierSelectivity>.827333:"N"</OutlierSelectivity>
<Selectivity>5.7555%</Selectivity>
</Property>
<Property name="AgentOrangeLocationCode">
<AverageFieldSize>.46</AverageFieldSize>
<OutlierSelectivity>.934333:</OutlierSelectivity>
<Selectivity>2.1889%</Selectivity>
</Property>
<Property name="AgentOrangeLocationCodeCode">
<AverageFieldSize>.07</AverageFieldSize>
<OutlierSelectivity>.934333:</OutlierSelectivity>
<Selectivity>2.1889%</Selectivity>
</Property>
<Property name="BadAddressIndicator">
<AverageFieldSize>.93</AverageFieldSize>
<OutlierSelectivity>.925333:</OutlierSelectivity>
<Selectivity>3.7333%</Selectivity>
</Property>
<Property name="BadAddressIndicatorCode">
<AverageFieldSize>.07</AverageFieldSize>
<OutlierSelectivity>.925333:</OutlierSelectivity>
<Selectivity>3.7333%</Selectivity>
</Property>
<Property name="BirthDateTime">
<AverageFieldSize>6.98</AverageFieldSize>
<Selectivity>0.0043%</Selectivity>
</Property>
<Property name="BirthFMDate">
<AverageFieldSize>6.98</AverageFieldSize>
<Selectivity>0.0043%</Selectivity>
</Property>
<Property name="City">
<AverageFieldSize>8.2</AverageFieldSize>
<Selectivity>0.0567%</Selectivity>
</Property>
<Property name="CollateralSponsorPatientIEN">
<AverageFieldSize>.07</AverageFieldSize>
<OutlierSelectivity>.987:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="CombatEligibilityEndDate">
<AverageFieldSize>.65</AverageFieldSize>
<OutlierSelectivity>.907:</OutlierSelectivity>
<Selectivity>0.0035%</Selectivity>
</Property>
<Property name="CombatEligibilityEndFMDate">
<AverageFieldSize>.65</AverageFieldSize>
<OutlierSelectivity>.907:</OutlierSelectivity>
<Selectivity>0.0035%</Selectivity>
</Property>
<Property name="CombatFlag">
<AverageFieldSize>.49</AverageFieldSize>
<Selectivity>33.3333%</Selectivity>
</Property>
<Property name="CombatFlagCode">
<AverageFieldSize>.49</AverageFieldSize>
<Selectivity>33.3333%</Selectivity>
</Property>
<Property name="CombatFromDate">
<AverageFieldSize>.5</AverageFieldSize>
<OutlierSelectivity>.928:</OutlierSelectivity>
<Selectivity>0.0276%</Selectivity>
</Property>
<Property name="CombatFromFMDate">
<AverageFieldSize>.5</AverageFieldSize>
<OutlierSelectivity>.928:</OutlierSelectivity>
<Selectivity>0.0276%</Selectivity>
</Property>
<Property name="CombatToDate">
<AverageFieldSize>.51</AverageFieldSize>
<OutlierSelectivity>.927667:</OutlierSelectivity>
<Selectivity>0.0270%</Selectivity>
</Property>
<Property name="CombatToFMDate">
<AverageFieldSize>.51</AverageFieldSize>
<OutlierSelectivity>.927667:</OutlierSelectivity>
<Selectivity>0.0270%</Selectivity>
</Property>
<Property name="CurrentEnrollmentIEN">
<AverageFieldSize>5.92</AverageFieldSize>
<OutlierSelectivity>.146:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="CurrentMeansTestStatusIEN">
<AverageFieldSize>.64</AverageFieldSize>
<Selectivity>12.5000%</Selectivity>
</Property>
<Property name="DeathDateTime">
<AverageFieldSize>4.47</AverageFieldSize>
<OutlierSelectivity>.611:</OutlierSelectivity>
<Selectivity>0.0026%</Selectivity>
</Property>
<Property name="DeathDocumentationType">
<AverageFieldSize>.18</AverageFieldSize>
<OutlierSelectivity>.991667:</OutlierSelectivity>
<Selectivity>0.1163%</Selectivity>
</Property>
<Property name="DeathEnteredByStaffIEN">
<AverageFieldSize>.08</AverageFieldSize>
<OutlierSelectivity>.982667:</OutlierSelectivity>
<Selectivity>0.0413%</Selectivity>
</Property>
<Property name="DeathFMDate">
<AverageFieldSize>4.47</AverageFieldSize>
<OutlierSelectivity>.611:</OutlierSelectivity>
<Selectivity>0.0026%</Selectivity>
</Property>
<Property name="DeathLastUpdatedByStaffIEN">
<AverageFieldSize>.11</AverageFieldSize>
<OutlierSelectivity>.976:</OutlierSelectivity>
<Selectivity>0.0535%</Selectivity>
</Property>
<Property name="DeathModifiedDateTime">
<AverageFieldSize>3.54</AverageFieldSize>
<OutlierSelectivity>.620333:</OutlierSelectivity>
<Selectivity>0.0839%</Selectivity>
</Property>
<Property name="DeathModifiedFMDate">
<AverageFieldSize>3.54</AverageFieldSize>
<OutlierSelectivity>.620333:</OutlierSelectivity>
<Selectivity>0.0839%</Selectivity>
</Property>
<Property name="DeathNotificationSource">
<AverageFieldSize>4.06</AverageFieldSize>
<OutlierSelectivity>.612:</OutlierSelectivity>
<Selectivity>4.8500%</Selectivity>
</Property>
<Property name="DestinationMergePatientIEN">
<AverageFieldSize>.01</AverageFieldSize>
<OutlierSelectivity>.997:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="DuplicateRecordStatus">
<AverageFieldSize>1</AverageFieldSize>
<OutlierSelectivity>.999767:</OutlierSelectivity>
<Selectivity>0.0233%</Selectivity>
</Property>
<Property name="DuplicateRecordStatusCode">
<AverageFieldSize>1</AverageFieldSize>
<OutlierSelectivity>.999767:</OutlierSelectivity>
<Selectivity>0.0233%</Selectivity>
</Property>
<Property name="EligibilityEnteredStaffIEN">
<AverageFieldSize>1.92</AverageFieldSize>
<OutlierSelectivity>.850667:.5</OutlierSelectivity>
<Selectivity>0.1727%</Selectivity>
</Property>
<Property name="EligibilityIEN">
<AverageFieldSize>1.14</AverageFieldSize>
<OutlierSelectivity>.389333:5</OutlierSelectivity>
<Selectivity>2.6551%</Selectivity>
</Property>
<Property name="EligibilityInterimDateTime">
<AverageFieldSize>.35</AverageFieldSize>
<OutlierSelectivity>.949667:</OutlierSelectivity>
<Selectivity>0.0009%</Selectivity>
</Property>
<Property name="EligibilityInterimFMDate">
<AverageFieldSize>.35</AverageFieldSize>
<OutlierSelectivity>.949667:</OutlierSelectivity>
<Selectivity>0.0009%</Selectivity>
</Property>
<Property name="EligibilityStatus">
<AverageFieldSize>7.86</AverageFieldSize>
<OutlierSelectivity>.886333:"VERIFIED"</OutlierSelectivity>
<Selectivity>5.6833%</Selectivity>
</Property>
<Property name="EligibilityStatusCode">
<AverageFieldSize>.93</AverageFieldSize>
<OutlierSelectivity>.886333:"V"</OutlierSelectivity>
<Selectivity>5.6833%</Selectivity>
</Property>
<Property name="EligibilityStatusDateTime">
<AverageFieldSize>6.24</AverageFieldSize>
<OutlierSelectivity>.108667:</OutlierSelectivity>
<Selectivity>0.0208%</Selectivity>
</Property>
<Property name="EligibilityStatusFMDate">
<AverageFieldSize>6.24</AverageFieldSize>
<OutlierSelectivity>.108667:</OutlierSelectivity>
<Selectivity>0.0208%</Selectivity>
</Property>
<Property name="EligibilityVACode">
<AverageFieldSize>.99</AverageFieldSize>
<OutlierSelectivity>.390333:5</OutlierSelectivity>
<Selectivity>7.6208%</Selectivity>
</Property>
<Property name="EligibilityVerificationMethod">
<AverageFieldSize>8.36</AverageFieldSize>
<OutlierSelectivity>.293333:"CEV/VBA"</OutlierSelectivity>
<Selectivity>0.2171%</Selectivity>
</Property>
<Property name="EligibilityVerificationSource">
<AverageFieldSize>3.45</AverageFieldSize>
<Selectivity>33.3333%</Selectivity>
</Property>
<Property name="EligibilityVerificationSourceCode">
<AverageFieldSize>.95</AverageFieldSize>
<Selectivity>33.3333%</Selectivity>
</Property>
<Property name="EmergencyResponseIndicator">
<AverageFieldSize>.06</AverageFieldSize>
<OutlierSelectivity>.992667:</OutlierSelectivity>
<Selectivity>0.7333%</Selectivity>
</Property>
<Property name="EmergencyResponseIndicatorCode">
<AverageFieldSize>.01</AverageFieldSize>
<OutlierSelectivity>.992667:</OutlierSelectivity>
<Selectivity>0.7333%</Selectivity>
</Property>
<Property name="FFFEnteredDateTime">
<AverageFieldSize>.01</AverageFieldSize>
<OutlierSelectivity>.999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="FFFEnteredFMDate">
<AverageFieldSize>.01</AverageFieldSize>
<OutlierSelectivity>.999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="FFFEnteredStaffIEN">
<AverageFieldSize>1</AverageFieldSize>
<OutlierSelectivity>.999:</OutlierSelectivity>
<Selectivity>0.0382%</Selectivity>
</Property>
<Property name="FFFRemovedDateTime">
<AverageFieldSize>.01</AverageFieldSize>
<OutlierSelectivity>.999333:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="FFFRemovedFMDate">
<AverageFieldSize>.01</AverageFieldSize>
<OutlierSelectivity>.999333:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="FFFRemovedReason">
<AverageFieldSize>.02</AverageFieldSize>
<OutlierSelectivity>.999333:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="FFFRemovedStaffIEN">
<AverageFieldSize>1</AverageFieldSize>
<OutlierSelectivity>.999333:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="FederalAgencyIEN">
<AverageFieldSize>1</AverageFieldSize>
<OutlierSelectivity>.996667:</OutlierSelectivity>
<Selectivity>0.0561%</Selectivity>
</Property>
<Property name="FilipinoVeteranCode">
<AverageFieldSize>1</AverageFieldSize>
<OutlierSelectivity>.999767:</OutlierSelectivity>
<Selectivity>0.0233%</Selectivity>
</Property>
<Property name="FilipinoVeteranCodeCode">
<AverageFieldSize>1</AverageFieldSize>
<OutlierSelectivity>.999767:</OutlierSelectivity>
<Selectivity>0.0233%</Selectivity>
</Property>
<Property name="FugitiveFelonFlag">
<AverageFieldSize>1</AverageFieldSize>
<OutlierSelectivity>.999667:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="FugitiveFelonFlagCode">
<AverageFieldSize>1</AverageFieldSize>
<OutlierSelectivity>.999667:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="Gender">
<AverageFieldSize>.99</AverageFieldSize>
<OutlierSelectivity>.866667:"M"</OutlierSelectivity>
<Selectivity>6.6666%</Selectivity>
</Property>
<Property name="GenderCode">
<AverageFieldSize>.99</AverageFieldSize>
<OutlierSelectivity>.866667:"M"</OutlierSelectivity>
<Selectivity>6.6666%</Selectivity>
</Property>
<Property name="GovernmentEmployeeFlag">
<AverageFieldSize>.01</AverageFieldSize>
<OutlierSelectivity>.993667:</OutlierSelectivity>
<Selectivity>0.3167%</Selectivity>
</Property>
<Property name="GovernmentEmployeeFlagCode">
<AverageFieldSize>.01</AverageFieldSize>
<OutlierSelectivity>.993667:</OutlierSelectivity>
<Selectivity>0.3167%</Selectivity>
</Property>
<Property name="IneligibleCity">
<AverageFieldSize>.03</AverageFieldSize>
<OutlierSelectivity>.996:</OutlierSelectivity>
<Selectivity>0.0556%</Selectivity>
</Property>
<Property name="IneligibleDateTime">
<AverageFieldSize>.08</AverageFieldSize>
<OutlierSelectivity>.988:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="IneligibleFMDate">
<AverageFieldSize>.08</AverageFieldSize>
<OutlierSelectivity>.988:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="IneligibleReason">
<AverageFieldSize>.23</AverageFieldSize>
<OutlierSelectivity>.988:</OutlierSelectivity>
<Selectivity>0.0105%</Selectivity>
</Property>
<Property name="IneligibleSource">
<AverageFieldSize>.02</AverageFieldSize>
<OutlierSelectivity>.995667:</OutlierSelectivity>
<Selectivity>0.2166%</Selectivity>
</Property>
<Property name="IneligibleSourceCode">
<AverageFieldSize>1</AverageFieldSize>
<OutlierSelectivity>.995667:</OutlierSelectivity>
<Selectivity>0.2166%</Selectivity>
</Property>
<Property name="IneligibleStateIEN">
<AverageFieldSize>.01</AverageFieldSize>
<OutlierSelectivity>.996:</OutlierSelectivity>
<Selectivity>0.0556%</Selectivity>
</Property>
<Property name="IneligibleVAROReason">
<AverageFieldSize>.03</AverageFieldSize>
<OutlierSelectivity>.998667:</OutlierSelectivity>
<Selectivity>0.0253%</Selectivity>
</Property>
<Property name="InsuranceCoverageFlag">
<AverageFieldSize>.99</AverageFieldSize>
<OutlierSelectivity>.637333:"N"</OutlierSelectivity>
<Selectivity>12.0889%</Selectivity>
</Property>
<Property name="InsuranceCoverageFlagCode">
<AverageFieldSize>.99</AverageFieldSize>
<OutlierSelectivity>.637333:"N"</OutlierSelectivity>
<Selectivity>12.0889%</Selectivity>
</Property>
<Property name="IonizingRadiationExposureFlag">
<AverageFieldSize>.89</AverageFieldSize>
<OutlierSelectivity>.888667:"N"</OutlierSelectivity>
<Selectivity>3.7111%</Selectivity>
</Property>
<Property name="IonizingRadiationExposureFlagCode">
<AverageFieldSize>.89</AverageFieldSize>
<OutlierSelectivity>.888667:"N"</OutlierSelectivity>
<Selectivity>3.7111%</Selectivity>
</Property>
<Property name="MaritalStatusIEN">
<AverageFieldSize>.94</AverageFieldSize>
<OutlierSelectivity>.495:2</OutlierSelectivity>
<Selectivity>7.2143%</Selectivity>
</Property>
<Property name="MedicaidEligibleFlag">
<AverageFieldSize>.7</AverageFieldSize>
<Selectivity>33.3333%</Selectivity>
</Property>
<Property name="MedicaidEligibleFlagCode">
<AverageFieldSize>.7</AverageFieldSize>
<Selectivity>33.3333%</Selectivity>
</Property>
<Property name="MedicaidInquireDateTime">
<AverageFieldSize>8</AverageFieldSize>
<OutlierSelectivity>.321:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="MedicaidInquireFMDate">
<AverageFieldSize>8</AverageFieldSize>
<OutlierSelectivity>.321:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="MedicaidNumber">
<AverageFieldSize>.04</AverageFieldSize>
<OutlierSelectivity>.995:</OutlierSelectivity>
<Selectivity>0.0050%</Selectivity>
</Property>
<Property name="ODSRankType">
<AverageFieldSize>1</AverageFieldSize>
<OutlierSelectivity>.999767:</OutlierSelectivity>
<Selectivity>0.0233%</Selectivity>
</Property>
<Property name="ODSRecalledCode">
<AverageFieldSize>1</AverageFieldSize>
<OutlierSelectivity>.999767:</OutlierSelectivity>
<Selectivity>0.0233%</Selectivity>
</Property>
<Property name="ODSRecalledCodeCode">
<AverageFieldSize>1</AverageFieldSize>
<OutlierSelectivity>.999767:</OutlierSelectivity>
<Selectivity>0.0233%</Selectivity>
</Property>
<Property name="ODSTreatmentDateTime">
<AverageFieldSize>1</AverageFieldSize>
<OutlierSelectivity>.999767:</OutlierSelectivity>
<Selectivity>0.0233%</Selectivity>
</Property>
<Property name="ODSTreatmentFMDate">
<AverageFieldSize>1</AverageFieldSize>
<OutlierSelectivity>.999767:</OutlierSelectivity>
<Selectivity>0.0233%</Selectivity>
</Property>
<Property name="OpCode">
<AverageFieldSize>1</AverageFieldSize>
<OutlierSelectivity>.999767:</OutlierSelectivity>
<Selectivity>0.0233%</Selectivity>
</Property>
<Property name="OperationDesertShieldRank">
<AverageFieldSize>1</AverageFieldSize>
<OutlierSelectivity>.999767:</OutlierSelectivity>
<Selectivity>0.0233%</Selectivity>
</Property>
<Property name="POWFlag">
<AverageFieldSize>.61</AverageFieldSize>
<Selectivity>25.0000%</Selectivity>
</Property>
<Property name="POWFlagCode">
<AverageFieldSize>.61</AverageFieldSize>
<Selectivity>25.0000%</Selectivity>
</Property>
<Property name="POWLocationIEN">
<AverageFieldSize>.01</AverageFieldSize>
<OutlierSelectivity>.992667:</OutlierSelectivity>
<Selectivity>0.3667%</Selectivity>
</Property>
<Property name="PatientEnteredByStaffIEN">
<AverageFieldSize>3.46</AverageFieldSize>
<OutlierSelectivity>.168:</OutlierSelectivity>
<Selectivity>0.1113%</Selectivity>
</Property>
<Property name="PatientEnteredCode">
<AverageFieldSize>.01</AverageFieldSize>
<OutlierSelectivity>.999333:</OutlierSelectivity>
<Selectivity>0.0667%</Selectivity>
</Property>
<Property name="PatientEnteredCodeCode">
<AverageFieldSize>1</AverageFieldSize>
<OutlierSelectivity>.999333:</OutlierSelectivity>
<Selectivity>0.0667%</Selectivity>
</Property>
<Property name="PatientEnteredDateTime">
<AverageFieldSize>5.88</AverageFieldSize>
<OutlierSelectivity>.159333:</OutlierSelectivity>
<Selectivity>0.0099%</Selectivity>
</Property>
<Property name="PatientEnteredFMDate">
<AverageFieldSize>5.88</AverageFieldSize>
<OutlierSelectivity>.159333:</OutlierSelectivity>
<Selectivity>0.0099%</Selectivity>
</Property>
<Property name="PatientEnteredRemark">
<AverageFieldSize>16.94</AverageFieldSize>
<OutlierSelectivity>.468333:</OutlierSelectivity>
<Selectivity>0.0072%</Selectivity>
</Property>
<Property name="PatientFirstName">
<AverageFieldSize>10.15</AverageFieldSize>
<Selectivity>0.0093%</Selectivity>
</Property>
<Property name="PatientICN">
<AverageFieldSize>9.97</AverageFieldSize>
<Selectivity>0.0002%</Selectivity>
</Property>
<Property name="PatientIEN">
<AverageFieldSize>5.61</AverageFieldSize>
<Selectivity>0.0005%</Selectivity>
</Property>
<Property name="PatientLastName">
<AverageFieldSize>6.55</AverageFieldSize>
<Selectivity>0.0176%</Selectivity>
</Property>
<Property name="PatientMissingCity">
<AverageFieldSize>1</AverageFieldSize>
<OutlierSelectivity>.999767:</OutlierSelectivity>
<Selectivity>0.0233%</Selectivity>
</Property>
<Property name="PatientMissingDateTime">
<AverageFieldSize>1</AverageFieldSize>
<OutlierSelectivity>.999767:</OutlierSelectivity>
<Selectivity>0.0233%</Selectivity>
</Property>
<Property name="PatientMissingFMDate">
<AverageFieldSize>1</AverageFieldSize>
<OutlierSelectivity>.999767:</OutlierSelectivity>
<Selectivity>0.0233%</Selectivity>
</Property>
<Property name="PatientMissingSource">
<AverageFieldSize>1</AverageFieldSize>
<OutlierSelectivity>.999767:</OutlierSelectivity>
<Selectivity>0.0233%</Selectivity>
</Property>
<Property name="PatientMissingSourceCode">
<AverageFieldSize>1</AverageFieldSize>
<OutlierSelectivity>.999767:</OutlierSelectivity>
<Selectivity>0.0233%</Selectivity>
</Property>
<Property name="PatientMissingStateIEN">
<AverageFieldSize>1</AverageFieldSize>
<OutlierSelectivity>.999767:</OutlierSelectivity>
<Selectivity>0.0233%</Selectivity>
</Property>
<Property name="PatientName">
<AverageFieldSize>17.7</AverageFieldSize>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="PatientSSN">
<AverageFieldSize>9</AverageFieldSize>
<Selectivity>0.0002%</Selectivity>
</Property>
<Property name="PatientTypeIEN">
<AverageFieldSize>1.49</AverageFieldSize>
<OutlierSelectivity>.439667:12</OutlierSelectivity>
<Selectivity>5.6033%</Selectivity>
</Property>
<Property name="PercentServiceConnect">
<AverageFieldSize>.91</AverageFieldSize>
<OutlierSelectivity>.563:</OutlierSelectivity>
<Selectivity>3.9727%</Selectivity>
</Property>
<Property name="PeriodOfServiceIEN">
<AverageFieldSize>1.56</AverageFieldSize>
<OutlierSelectivity>.286667:7</OutlierSelectivity>
<Selectivity>3.2424%</Selectivity>
</Property>
<Property name="PreferredInstitutionIEN">
<AverageFieldSize>2.75</AverageFieldSize>
<OutlierSelectivity>.180667:</OutlierSelectivity>
<Selectivity>0.1715%</Selectivity>
</Property>
<Property name="PreferredInstitutionSource">
<AverageFieldSize>3.07</AverageFieldSize>
<OutlierSelectivity>.56:"ESR"</OutlierSelectivity>
<Selectivity>11.0000%</Selectivity>
</Property>
<Property name="PreferredInstitutionSourceCode">
<AverageFieldSize>.84</AverageFieldSize>
<OutlierSelectivity>.56:"E"</OutlierSelectivity>
<Selectivity>11.0000%</Selectivity>
</Property>
<Property name="PseudoSSNReason">
<AverageFieldSize>.05</AverageFieldSize>
<OutlierSelectivity>.997333:</OutlierSelectivity>
<Selectivity>0.0847%</Selectivity>
</Property>
<Property name="PseudoSSNReasonCode">
<AverageFieldSize>1</AverageFieldSize>
<OutlierSelectivity>.997333:</OutlierSelectivity>
<Selectivity>0.0847%</Selectivity>
</Property>
<Property name="RadiationExposureCode">
<AverageFieldSize>.07</AverageFieldSize>
<OutlierSelectivity>.996667:</OutlierSelectivity>
<Selectivity>0.0774%</Selectivity>
</Property>
<Property name="RadiationExposureCodeCode">
<AverageFieldSize>1</AverageFieldSize>
<OutlierSelectivity>.996667:</OutlierSelectivity>
<Selectivity>0.0774%</Selectivity>
</Property>
<Property name="ReligionIEN">
<AverageFieldSize>1.71</AverageFieldSize>
<OutlierSelectivity>.316:29</OutlierSelectivity>
<Selectivity>1.4553%</Selectivity>
</Property>
<Property name="SHADFlag">
<AverageFieldSize>1</AverageFieldSize>
<OutlierSelectivity>.999767:</OutlierSelectivity>
<Selectivity>0.0233%</Selectivity>
</Property>
<Property name="SHADFlagCode">
<AverageFieldSize>1</AverageFieldSize>
<OutlierSelectivity>.999767:</OutlierSelectivity>
<Selectivity>0.0233%</Selectivity>
</Property>
<Property name="SSNVerificationStatus">
<AverageFieldSize>6.7</AverageFieldSize>
<OutlierSelectivity>.824667:"VERIFIED"</OutlierSelectivity>
<Selectivity>8.7666%</Selectivity>
</Property>
<Property name="SSNVerificationStatusCode">
<AverageFieldSize>.84</AverageFieldSize>
<OutlierSelectivity>.824667:4</OutlierSelectivity>
<Selectivity>8.7666%</Selectivity>
</Property>
<Property name="ScrSSN">
<AverageFieldSize>9</AverageFieldSize>
<Selectivity>0.0002%</Selectivity>
</Property>
<Property name="SelfIdentifiedGender">
<AverageFieldSize>.31</AverageFieldSize>
<OutlierSelectivity>.939333:</OutlierSelectivity>
<Selectivity>2.0222%</Selectivity>
</Property>
<Property name="SelfIdentifiedGenderCode">
<AverageFieldSize>.06</AverageFieldSize>
<OutlierSelectivity>.939333:</OutlierSelectivity>
<Selectivity>2.0222%</Selectivity>
</Property>
<Property name="SensitiveFlag">
<AverageFieldSize>.08</AverageFieldSize>
<OutlierSelectivity>.922:</OutlierSelectivity>
<Selectivity>3.9000%</Selectivity>
</Property>
<Property name="SensitiveFlagCode">
<AverageFieldSize>.08</AverageFieldSize>
<OutlierSelectivity>.922:</OutlierSelectivity>
<Selectivity>3.9000%</Selectivity>
</Property>
<Property name="ServiceConnectedFlag">
<AverageFieldSize>.99</AverageFieldSize>
<Selectivity>33.3333%</Selectivity>
</Property>
<Property name="ServiceConnectedFlagCode">
<AverageFieldSize>.99</AverageFieldSize>
<Selectivity>33.3333%</Selectivity>
</Property>
<Property name="SouthwestAsiaCondition">
<AverageFieldSize>1.7</AverageFieldSize>
<OutlierSelectivity>.833667:"NO"</OutlierSelectivity>
<Selectivity>8.3166%</Selectivity>
</Property>
<Property name="SouthwestAsiaConditionCode">
<AverageFieldSize>.85</AverageFieldSize>
<OutlierSelectivity>.833667:"N"</OutlierSelectivity>
<Selectivity>8.3166%</Selectivity>
</Property>
<Property name="Sta3n">
<AverageFieldSize>3</AverageFieldSize>
<Selectivity>12.5000%</Selectivity>
</Property>
<Property name="StateCountyIEN">
<AverageFieldSize>1.61</AverageFieldSize>
<OutlierSelectivity>.073667:4</OutlierSelectivity>
<Selectivity>0.7470%</Selectivity>
</Property>
<Property name="StateIEN">
<AverageFieldSize>1.87</AverageFieldSize>
<OutlierSelectivity>.139667:23</OutlierSelectivity>
<Selectivity>1.5094%</Selectivity>
</Property>
<Property name="StreetAddress1">
<AverageFieldSize>15.47</AverageFieldSize>
<Selectivity>0.0033%</Selectivity>
</Property>
<Property name="StreetAddress2">
<AverageFieldSize>1.52</AverageFieldSize>
<OutlierSelectivity>.866333:</OutlierSelectivity>
<Selectivity>0.0042%</Selectivity>
</Property>
<Property name="TestPatientFlag">
<AverageFieldSize>1</AverageFieldSize>
<OutlierSelectivity>.999667:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="TestPatientFlagCode">
<AverageFieldSize>1</AverageFieldSize>
<OutlierSelectivity>.999667:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="VeteranFlag">
<AverageFieldSize>.99</AverageFieldSize>
<OutlierSelectivity>.876333:"Y"</OutlierSelectivity>
<Selectivity>6.1833%</Selectivity>
</Property>
<Property name="VeteranFlagCode">
<AverageFieldSize>.99</AverageFieldSize>
<OutlierSelectivity>.876333:"Y"</OutlierSelectivity>
<Selectivity>6.1833%</Selectivity>
</Property>
<Property name="VeteranTransportationProgramFlag">
<AverageFieldSize>1</AverageFieldSize>
<OutlierSelectivity>.999767:</OutlierSelectivity>
<Selectivity>0.0233%</Selectivity>
</Property>
<Property name="VeteranTransportationProgramFlagCode">
<AverageFieldSize>1</AverageFieldSize>
<OutlierSelectivity>.999767:</OutlierSelectivity>
<Selectivity>0.0233%</Selectivity>
</Property>
<Property name="VietnamServiceFlag">
<AverageFieldSize>.46</AverageFieldSize>
<Selectivity>25.0000%</Selectivity>
</Property>
<Property name="VietnamServiceFlagCode">
<AverageFieldSize>.46</AverageFieldSize>
<Selectivity>25.0000%</Selectivity>
</Property>
<Property name="VistaCreateDate">
<AverageFieldSize>19</AverageFieldSize>
<OutlierSelectivity>.943:"1900-01-01 00:00:00"</OutlierSelectivity>
<Selectivity>0.0004%</Selectivity>
</Property>
<Property name="VistaEditDate">
<AverageFieldSize>19</AverageFieldSize>
<Selectivity>0.0098%</Selectivity>
</Property>
<Property name="Zip">
<AverageFieldSize>4.89</AverageFieldSize>
<Selectivity>0.0441%</Selectivity>
</Property>
<Property name="Zip4">
<AverageFieldSize>6.06</AverageFieldSize>
<Selectivity>0.0263%</Selectivity>
</Property>
<SQLMap name="MainIndex">
<BlockCount>-17331848</BlockCount>
</SQLMap>
<SQLMap name="PatientEnteredByStaffIENIndex">
<BlockCount>-224212</BlockCount>
</SQLMap>
<SQLMap name="PatientICNIndex">
<BlockCount>-216672</BlockCount>
</SQLMap>
<SQLMap name="PatientICNOnlyIndex">
<BlockCount>-425752</BlockCount>
</SQLMap>
<SQLMap name="PatientSSNIndex">
<BlockCount>-427812</BlockCount>
</SQLMap>
<SQLMap name="VistaEditDateIndex">
<BlockCount>-327056</BlockCount>
</SQLMap>
<StreamLocation>^SPatient.SPatient2v123S</StreamLocation>
<Type>%Storage.Persistent</Type>
}

ClassMethod NewVX130ToVISTA(Sta3n As %Integer, StartIEN As %String = 0, EndIEN As %Integer = "")
{
	Write Sta3n,!,$ZDateTime($H,3),!
	Set VistaSite=##class(VX130.VistaSite).%OpenId(Sta3n)
	Set NS=VistaSite.VistaSiteNamespace
	Set LastIEN=""
	Set Count=0
	Set:EndIEN="" EndIEN=$Order(^SPatient.SPatient2v123D(Sta3n,"%"),-1)
	Set PatientIEN=$Order(^SPatient.SPatient2v123D(Sta3n,StartIEN))
	While (PatientIEN]"")&(PatientIEN<EndIEN)
	{
		Set LastIEN=PatientIEN
		If $Get(^|NS|DPT(PatientIEN,0))=""
		{
			If ..%OpenId(Sta3n_"||"_$Replace(LastIEN,",","||")).OpCode']""
			{
				//Set qcid=##class(QC.QualityCheckHistory).GetID("VX130",Sta3n,..%ClassName(1))
				//Do ##class(QC.Detail).AddEntry(qcid,Sta3n_"||"_$Replace(LastIEN,",","||"),"1")
			}
		}
		Set PatientIEN=$Order(^SPatient.SPatient2v123D(Sta3n,PatientIEN))
		Set Count=Count+1
		//If '(Count#10000) Do ##class(QC.QualityCheckHistory).UpdateDQStatus("VX130",Sta3n,..%ClassName(1),LastIEN)
	}
	//Do ##class(QC.QualityCheckHistory).UpdateDQStatus("VX130",Sta3n,..%ClassName(1),LastIEN)
	//Do ##class(QC.QualityCheckHistory).EndQualityCheck("VX130",Sta3n,..%ClassName(1))
	Quit
}

ClassMethod ToFHIRObject(id As %String) As %DynamicObject
{
	Set oref=..%OpenId(id,0,.sc)
	Set jsonObj=##class(%DynamicObject).%New()
	If $IsObject(oref) {
		Set jsonObj.resourceType="Patient"
		Set jsonObj.identifier=oref.PatientICN
		set nameObj=##class(%DynamicObject).%New()
		set nameObj.use="official"
		set nameObj.text=oref.PatientName
		set nameObj.family=oref.PatientLastName
		set nameObj.given=##class(%DynamicArray).%New()
		set firstname=oref.PatientFirstName
		for i=1:1 { quit:$Piece(firstname," ",i)=""  do nameObj.given.%Push($Piece(firstname," ",i)) }
		set jsonObj.name=##class(%DynamicArray).%New()
		do jsonObj.name.%Push(nameObj)
		set gender=oref.GenderCode
		set jsonObj.gender=$case(gender,"M":"male","F":"female","O":"other",:"unknown")
		set jsonObj.birthdate=##class(%FilemanDate).LogicalToOdbc(oref.BirthDateTime)
		set:oref.DeathDateTime jsonObj.deceasedDateTime=##class(%FilemanDate).LogicalToOdbc(oref.DeathDateTime)
		do:oref.DeathDateTime="" jsonObj.%Set("deceasedBoolean",0,"boolean")
		
	}
	quit jsonObj
}

ClassMethod CleanUp() As %String
{
	kill Sta3n,PatientIEN,PatientFirstName,PatientLastName,PatientName,Gender,GenderCode,BirthDateTime,BirthFMDate,MaritalStatusIEN,ReligionIEN,DuplicateRecordStatus,DuplicateRecordStatusCode,DestinationMergePatientIEN,PatientSSN,ScrSSN,PseudoSSNReason,PseudoSSNReasonCode,SSNVerificationStatus,SSNVerificationStatusCode,PatientEnteredRemark,PatientEnteredByStaffIEN,PatientEnteredDateTime,PatientEnteredFMDate,PatientEnteredCode,PatientEnteredCodeCode,StreetAddress1,Zip4,StreetAddress2,City,StateIEN,Zip,StateCountyIEN,BadAddressIndicator,BadAddressIndicatorCode,CurrentMeansTestStatusIEN,IneligibleDateTime,IneligibleFMDate,PatientMissingDateTime,PatientMissingFMDate,IneligibleSource,IneligibleSourceCode,IneligibleCity,IneligibleStateIEN,IneligibleVAROReason,PatientMissingSource,PatientMissingSourceCode,PatientMissingCity,PatientMissingStateIEN,EmergencyResponseIndicator,EmergencyResponseIndicatorCode,ServiceConnectedFlag,ServiceConnectedFlagCode,PercentServiceConnect,IneligibleReason,FederalAgencyIEN,GovernmentEmployeeFlag,GovernmentEmployeeFlagCode,InsuranceCoverageFlag,InsuranceCoverageFlagCode,VietnamServiceFlag,VietnamServiceFlagCode,AgentOrangeExposureFlag,AgentOrangeExposureFlagCode,IonizingRadiationExposureFlag,IonizingRadiationExposureFlagCode,SHADFlag,SHADFlagCode,RadiationExposureCode,RadiationExposureCodeCode,AgentOrangeLocationCode,AgentOrangeLocationCodeCode,FilipinoVeteranCode,FilipinoVeteranCodeCode,SouthwestAsiaCondition,SouthwestAsiaConditionCode,PeriodOfServiceIEN,DeathDateTime,DeathFMDate,DeathEnteredByStaffIEN,DeathNotificationSource,DeathModifiedDateTime,DeathModifiedFMDate,DeathLastUpdatedByStaffIEN,CollateralSponsorPatientIEN,EligibilityIEN,EligibilityVACode,EligibilityStatus,EligibilityStatusCode,EligibilityStatusDateTime,EligibilityStatusFMDate,EligibilityVerificationSource,EligibilityVerificationSourceCode,EligibilityInterimDateTime,EligibilityInterimFMDate,EligibilityVerificationMethod,EligibilityEnteredStaffIEN,MedicaidEligibleFlag,MedicaidEligibleFlagCode,MedicaidInquireDateTime,MedicaidInquireFMDate,MedicaidNumber,POWFlag,POWFlagCode,POWLocationIEN,CombatFlag,CombatFlagCode,CombatFromDate,CombatFromFMDate,CombatToDate,CombatToFMDate,CombatEligibilityEndDate,CombatEligibilityEndFMDate,TestPatientFlag,TestPatientFlagCode,CurrentEnrollmentIEN,PreferredInstitutionIEN,PatientTypeIEN,PatientICN,FugitiveFelonFlag,FugitiveFelonFlagCode,FFFEnteredStaffIEN,FFFEnteredDateTime,FFFEnteredFMDate,FFFRemovedStaffIEN,FFFRemovedDateTime,FFFRemovedFMDate,FFFRemovedReason,VeteranFlag,VeteranFlagCode,ODSTreatmentDateTime,ODSTreatmentFMDate,ODSRecalledCode,ODSRecalledCodeCode,ODSRankType,OperationDesertShieldRank,SensitiveFlag,SensitiveFlagCode,PreferredInstitutionSource,PreferredInstitutionSourceCode,VeteranTransportationProgramFlag,VeteranTransportationProgramFlagCode,SelfIdentifiedGender,SelfIdentifiedGenderCode,DeathDocumentationType,OpCode,VistaCreateDate,VistaEditDate
	kill NS,Flag,LogEdits,SQLCODE,VistaSite,%objlasterror,%ROWCOUNT,BitFlag,id,oref
}

}
