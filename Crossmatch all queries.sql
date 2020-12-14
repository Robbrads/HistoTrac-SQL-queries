/*main*/
Select
 patient.lastnm,
patient.firstnm + ' ' + isnull(patient.minm,'') as FirstNm,
patient.hospitalid,
patient.ssnbr,
patient.categorycd, 
patient.dob, 
hospital.hospitalnm, 
patient.gendercd, 
patient.racecd,
 isnull(sub.signaturetxt,'') as SubmittedSig, 
patientreport.submitteddt, isnull(employee.signaturetxt,'') as SignatureTxt, isnull(patientreport.statuscd,'') as ReportStatusCd, 
physician.lastnm PhysicianLastNm, 
physician.firstnm PhysicianFirstNm

from patient
left join physician on physician.physicianid = patient.physicianid
 left join hospital on patient.servicinghospitalid = hospital.hospitalid
 left join patientreport on patientreport.patientid = patient.patientid and (patientreport.patientreportid = <Patient Report ID> or patientreport.patientreportid is null)
 left join employee sub on sub.employeeid = patientreport.submittedbyid
 left join employee on employee.employeeid = <User ID> where patient.patientid = <Current Patient>




/*subRptTransplantHistory*/
Select
 th.transplantdt,
 th.donorid, 
th.eventcd, th.organcd, th.notestxt, th.mismatchtxt
from
 transplanthistory th 
where th.patientid = <Current Patient> 
order by th.transplantdt desc




/*subRptHLATyping*/
select
p.lastnm,
p.firstnm +' '+p.minm as FirstNm,
p.hospitalid,
 rel.lookuptxt as relationshiptypecd,
p.abocd +' '+ p.rhcd ABOcd,
case isnull(p.ma1eqcd,'') when '' then case isnull(a1.aequivalentcd,'') when '' then p.a1cd else a1.aequivalentcd end else p.ma1eqcd end  A1,
case isnull(p.ma2eqcd,'') when '' then case isnull(a2.aequivalentcd,'') when '' then p.a2cd else a2.aequivalentcd end else p.ma2eqcd end  A2,
case isnull(p.mb1eqcd,'') when '' then case isnull(b1.bequivalentcd,'') when '' then p.b1cd else b1.bequivalentcd end else p.mb1eqcd end  B1,
case isnull(p.mb2eqcd,'') when '' then case isnull(b2.bequivalentcd,'') when '' then p.b2cd else b2.bequivalentcd end else p.mb2eqcd end  B2,
case isnull(p.mBW1Cd,'') when '' then p.bw1cd else p.mbw1cd end Bw1,
case isnull(p.mBW2Cd,'') when '' then p.bw2cd else p.mbw2cd end Bw2,
case isnull(p.mc1eqcd,'') when '' then case isnull(c1.cequivalentcd,'') when '' then p.cw1cd else c1.cequivalentcd end else p.mc1eqcd end Cw1,
case isnull(p.mc2eqcd,'') when '' then case isnull(c2.cequivalentcd,'') when '' then p.cw2cd else c2.cequivalentcd end else p.mc2eqcd end Cw2,
case isnull(p.mdrb11eqcd,'') when '' then case isnull(drb11.drb1equivalentcd,'') when '' then p.dr1cd else drb11.drb1equivalentcd end else p.mdrb11eqcd end DR1,
case isnull(p.mdrb12eqcd,'') when '' then case isnull(drb12.drb1equivalentcd,'') when '' then p.dr2cd else drb12.drb1equivalentcd end else p.mdrb12eqcd end DR2,
p.drw1cd, p.drw2cd,
case isnull(p.mdqb11eqcd,'') when '' then case isnull(dqb11.dqb1equivalentcd,'') when '' then p.dq1cd else dqb11.dqb1equivalentcd end else p.mdqb11eqcd end DQ1,
case isnull(p.mdqb12eqcd,'') when '' then case isnull(dqb12.dqb1equivalentcd,'') when '' then p.dq2cd else dqb12.dqb1equivalentcd end else p.mdqb12eqcd end DQ2,
p.lastmoleculartypedt TypeDt,
isnull(rp.mamismatchcd,'') MMa,
isnull(rp.mbmismatchcd,'') MMb,
isnull(rp.mcmismatchcd,'') MMc,
isnull(rp.mdrb1mismatchcd,'') MMdr,
case isnull(rp.mdrb3mismatchcd,'') when '' then isnull(rp.drwmismatchcd,'') else rp.mdrb3mismatchcd end MMdrw,
isnull(rp.mdqb1mismatchcd,'') Mmdq,
 isnull(rp.mdqa1mismatchcd,'') MMmdqa,
 isnull(rp.mdpb1mismatchcd,'') MMmdpa,
isnull(rp.mdpb1mismatcimentypecd else '' end SpecimenTypeCd,
case when p.lastmolecularsampledt = s.sampledt then s.logtime else '' end LogTime,
 rp.ordernbr

from
 patientcase pc
 inner join relatedpatient rp on rp.caseid = pc.caseid
 Inner join patient p on rp.relatedpatientid = P.patientid
 left join sample s on s.patientid = p.patientid
 left join lookupcode rel on rel.lookuptablenm = 'Relationship' and rel.lookupcd = rp.relationshiptypecd
left join hlaa a1 on a1.acd = p.ma1cd
 left join hlaa a2 on a2.acd = p.ma2cd left join hlab b1 on b1.bcd = p.mb1cd
 left join hlab b2 on b2.bcd = p.mb2cd
left join hlac c1 on c1.ccd = p.mc1cd left join hlac c2 on c2.ccd = p.mc2cd
 left join hladrb1 drb11 on drb11.drb1cd = p.mdrb11cd left join hladrb1 drb12 on drb12.drb1cd = p.mdrb12cd
 left join hladrb3 drb31 on drb31.drb3cd = p.mdrb31cd left join hladrb3 drb32 on drb32.drb3cd = p.mdrb32cd
 left join hladrb4 drb41 on drb41.drb4cd = p.mdrb41cd left join hladrb4 drb42 on drb42.drb4cd = p.mdrb42cd
  left join hladrb5 drb51 on drb51.drb5cd = p.mdrb51cd  left join hladrb5 drb52 on drb52.drb5cd = p.mdrb52cd left join hladqb1 dqb11 on dqb11.dqb1cd = p.mdqb11cd
 left join hladqb1 dqb12 on dqb12.dqb1cd = p.mdqb12cd where pc.caseid = <Patient Cases> and rp.relatedpatientid IN (<Donor>)
order by Rp.OrderNbr asc, SampleDt desc, s.logtime desc





/*subRptComment*/
select
case isnull(patientreport.patientreportid,-1) when -1 then cast(patientreportcomment.commenttxt as nvarchar(4000)) else cast(patientreport.commenttxt as nvarchar(4000)) end CommentTxt

from patientreportcomment
left join patientreport on patientreport.patientreportid = <Patient Report ID> where PatientReportComment.patientid = <Current Patient> and PatientReportComment.reportid = <Report ID>



/*Supplemental*/


/*subRptXmatch*/
select s.samplenbr,
s.specimentypecd,
ds.samplenbr as DonorSampleNbr,
ds.specimentypecd as DonorSampleType, ds.sampletypecd as UNOSID,
patient.hospitalid,
patient.ssnbr,
patient.lastnm,
patient.firstnm,
x.sampledt as SerumDt,
t.xmatchdt as XMDt,
 isnull(x.treatcd,'') as techniqueCd,
x.cellcd,
x.tempcd,
 x.resultcd as Result,
 x.reportablecommentstxt as CommentsTxt,
t.signedoffdt as BilledDt,
patient.notestxt as Relationship,
t.donorid,
xc.componentnm,
t.reportablecommentstxt as TestCommentsTxt,
td.testtxt,
x.testeddt,
x.difftxt as MESFTxt,
 t.testid,
patient.suppressnameind,
 x.dilutioncd,
x.DiffTxt,
patient.unosid,
 t.testtypecd,
 patient.dob,
 x.compsamplenbr,
 isnull(ux.IgGResult,'') IgGResult, ux.IgMResult,
ux.DTTResult

from xmatch x
 inner join test t on x.testid = t.testid
 inner join testdefinition td on td.testtypecd = t.testtypecd
 inner join sample s on s.sampleid = t.sampleid
 inner join patient  on t.donorid = patient.patientid
 inner join relatedpatient rp on rp.patientid = s.patientid and rp.relatedpatientid = t.donorid
left join sample ds on ds.sampleid = t.cellsampleid
 left join lookupcode rel on rel.lookuptablenm = 'Relationship' and rel.lookupcd = rp.relationshiptypecd
 left join xmatchcomponent xc on xc.testtypecd = t.testtypecd and xc.componentnm = x.componentnm
 left join userxmatch ux on ux.xmatchid = x.xmatchid
 left join lookupcode ov on ov.lookuptablenm = 'Crossmatch Result' and ov.lookupcd = t.xmatchresultcd
 left join lookupcode r on r.lookuptablenm = 'Crossmatch Result' and r.lookupcd = x.resultcd where  t.testid in (<Crossmatch Tests>) and isnull(x.compsamplenbr,'') <> ''

order by rp.ordernbr asc,t.donorid,t.xmatchdt desc, x.methodcd asc, x.treatcd asc, xc.ordernbr asc





/*subRptAntibody*/
select
 sample.sampledt,
testdefinition.testtxt,
 cast(test.pctposcnt as nvarchar(10)) as PRA,
test.praresultcd,
case isnull(test.specificitytxt,'') when '' then isnull(usertest.cspecificitytxt,'') else isnull(test.specificitytxt,'') end as SpecificityTxt,
case isnull(test.lowriskantibodytxt,'') when '' then isnull(usertest.clowriskantibodytxt,'') else isnull(test.lowriskantibodytxt,'') end as LowRiskAntibodyTxt,
case isnull(test.moderateriskantibodytxt,'') when '' then isnull(usertest.cmoderaterisktxt,'') else isnull(test.moderateriskantibodytxt,'') end as ModerateRiskAntibodyTxt,
test.reportablecommentstxt as CommentsTxt,
test.testeddt,
sample.samplenbr,
test.treatmentcd,
 sample.logtime,
sample.specimentypecd,
cast(test.cpraamt as nvarchar(10)) as CPRA,
testdefinition.testclasscd

from test
inner join testdefinition on testdefinition.testtypecd = test.testtypecd
 inner join sample on sample.sampleid = test.sampleid
left join usertest on usertest.testid = test.testid where test.testid in (<Antibody Tests>) and test.testtypecd not like '%PRA%'

order by sample.sampledt desc





/*Unused*/


/*subRptCaseComment - removed*/
select
 case isnull(patientreport.patientreportid,-1) when -1 then cast(patientreportcomment.commenttxt as nvarchar(4000)) else cast(patientreport.commenttxt as nvarchar(4000)) end CommentTxt

 from patientreportcomment
 left join patientreport on patientreport.patientreportid = <Patient Report ID> where PatientReportComment.patientid = <Current Patient> and PatientReportComment.reportid = <Report ID>



 /*subRptXmatchInterp - removed*/
select
patient.hospitalid,
patient.ssnbr,
patient.lastnm,
patient.firstnm,
x.sampledt as SerumDt,
 t.xmatchdt as XMDt,
isnull(x.treatcd,'') as techniqueCd,
 x.cellcd,
x.tempcd,
isnull(r.lookuptxt,'') as Result,
ov.lookuptxt as OverallResultCd,
 x.reportablecommentstxt as CommentsTxt,
t.signedoffdt as BilledDt, patient.notestxt as Relationship, t.donorid,
xc.componentnm,
t.reportablecommentstxt as TestCommentsTxt,
td.testtxt,
x.testeddt,
x.difftxt as MESFTxt,
 t.testid,
 patient.suppressnameind,
 x.dilutioncd,
x.DiffTxt,
patient.unosid,
t.testtypecd,
patient.dob,
x.compsamplenbr samplenbr,
isnull(ux.IgGResult,'') IgGResult,
 ux.IgMResult

from xmatch x
inner join test t on x.testid = t.testid
 inner join testdefinition td on td.testtypecd = t.testtypecd
inner join sample s on s.sampleid = t.sampleid
 inner join patient  on t.donorid = patient.patientid
 inner join relatedpatient rp on rp.patientid = s.patientid and rp.relatedpatientid = t.donorid
 left join lookupcode rel on rel.lookuptablenm = 'Relationship' and rel.lookupcd = rp.relationshiptypecd
left join xmatchcomponent xc on xc.testtypecd = t.testtypecd and xc.componentnm = x.componentnm
left join userxmatch ux on ux.xmatchid = x.xmatchid
left join lookupcode ov on ov.lookuptablenm = 'Crossmatch Result' and ov.lookupcd = t.xmatchresultcd
 left join lookupcode r on r.lookuptablenm = 'Crossmatch Result' and r.lookupcd = x.resultcd where  t.testid in (<Crossmatch Tests>) and isnull(x.compsamplenbr,'') <> ''

 order by rp.ordernbr asc,t.donorid,t.xmatchdt desc, x.methodcd asc, x.treatcd asc, xc.ordernbr asc





