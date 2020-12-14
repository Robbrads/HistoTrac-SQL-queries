/*Main*/
select otheridnbr, 
unosid,
 p.lastnm, 
p.firstnm, 
p.hospitalid, 
dob,
 hospitalnm, 
e.lastnm ELastNm, 
e.firstnm EFirstNm,
 ma1cd, ma2cd, mb1cd, mb2cd, mbw1cd, mbw2cd, mc1cd, mc2cd, mdrb11cd, mdrb12cd, mdqb11cd, mdqb12cd, mdrb31cd, mdrb32cd, mdrb41cd, mdrb42cd, mdrb51cd, mdrb52cd, ma1eqcd, ma2eqcd, mb1eqcd, mb2eqcd, mc1eqcd, mc2eqcd, mdrb11eqcd, mdrb12eqcd, mdqb11eqcd, mdqb12eqcd, isnull(mdrb31eqcd,'') mdrb31eqcd, isnull(mdrb32eqcd,'') mdrb32eqcd, isnull(mdrb41eqcd,'') mdrb41eqcd, isnull(mdrb42eqcd,'') mdrb42eqcd, isnull(mdrb51eqcd,'') mdrb51eqcd, isnull(mdrb52eqcd,'') mdrb52eqcd, mdpb11cd, mdpb12cd 
from 
patient p 
left join hospital on hospital.hospitalid = p.servicinghospitalid 
left join employee e on e.employeeid = <User ID>
 where p.patientid = <Current Patient>


/*subRptSpecimen*/
select 
sample.sampledt, 
sample.samplenbr,
sample.specimentypecd,
test.testeddt, 
test.testmethodcd 
from 
patient inner join sample on sample.patientid = patient.patientid 
left join test on test.sampleid = sample.sampleid 
where 
test.testid in (<Molecular Tests>) 
