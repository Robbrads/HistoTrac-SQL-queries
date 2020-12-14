/*Main*/
select patient.lastnm,patient.firstnm + ' ' + isnull(patient.minm,'') as FirstNm,patient.hospitalid,patient.ssnbr,patient.categorycd, patient.dob, hospital.hospitalnm, patient.gendercd, patient.racecd, isnull(sub.signaturetxt,'') as SubmittedSig, patientreport.submitteddt, isnull(employee.signaturetxt,'') as SignatureTxt, isnull(patientreport.statuscd,'') as ReportStatusCd, physician.lastnm PhysicianLastNm, physician.firstnm PhysicianFirstNm, patient.notestxt as Relationship from patient left join physician on physician.physicianid = patient.physicianid left join hospital on patient.servicinghospitalid = hospital.hospitalid left join patientreport on patientreport.patientid = patient.patientid and (patientreport.patientreportid = <Patient Report ID> or patientreport.patientreportid is null) left join employee sub on sub.employeeid = patientreport.submittedbyid left join employee on employee.employeeid = <User ID> where patient.patientid = <Current Patient>

/*subRptSpecimen*/
select 
sample.sampledt, 
sample.samplenbr,
sample.specimentypecd,
sample.SampleFromCd,
test.testeddt, 
e.lastnm as ELastnm, 
e.firstnm as EFirstNm, 
test.testmethodcd, 
physician.FirstNm as PhysicianFirstNm,
physician.LastNm as PhysicianLastNm,
physician.EmailAddrTxt,
lookupcode.lookuptxt, usertest.cov
from 
patient inner join sample on sample.patientid = patient.patientid 
left join test on test.sampleid = sample.sampleid left join usertest on usertest.testid = test.testid
left join employee e on e.employeeid = test.completedbyid 
left join physician on physician.PhysicianID = sample.OrderingPhysicianID
left join lookupcode on lookupcode.lookuptablenm = 'Sample From' and lookupcode.lookupcd = sample.samplefromcd 
where 
test.testid in (<Molecular Tests>) 
order by sample.sampledt desc


/*subRptComment*/
select case isnull(patientreport.patientreportid,-1) when -1 then patientreportcomment.commenttxt else patientreport.commenttxt end Comments from patientreportcomment left join patientreport on patientreport.patientreportid = <Patient Report ID> where PatientReportComment.patientid = <Current Patient> and PatientReportComment.reportid = <Report ID>