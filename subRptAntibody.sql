select 
sample.sampledt, 
testdefinition.testtxt as TestTypeCd,
test.treatmentcd,test.dilutiontxt, 
test.pctposcnt as PRA, 
isnull(test.praresultcd,'') as ResultCD, 
test.reportablecommentstxt as CommentsTxt, 
test.signedoffdt as BilledDt,
test.pracellcd as CellCd, 
case isnull(test.specificitytxt,'') when '' then isnull(usertest.cspecificitytxt,'') else isnull(test.specificitytxt,'') end as SpecificityTxt, 
case isnull(test.lowriskantibodytxt,'') when '' then isnull(usertest.clowriskantibodytxt,'') else isnull(test.lowriskantibodytxt,'') end as LowRiskAntibodyTxt, 
case isnull(test.moderateriskantibodytxt,'') when '' then isnull(usertest.cmoderaterisktxt,'') else isnull(test.moderateriskantibodytxt,'') end as ModerateRiskAntibodyTxt,
isnull(test.negspecificitytxt,'') as NegSpecificityTxt, test.testeddt,
testdefinition.testclasscd, 
sample.samplenbr, 
testbatch.batchnm as testbatchnm
from patient 
inner join sample on sample.patientid = patient.patientid
inner join test on sample.sampleid = test.sampleid 
inner join testdefinition on testdefinition.testtypecd = test.testtypecd  
left join usertest on usertest.testid = test.testid 
left join testbatch on testbatch.testbatchid = test.assignedtobatchid 
where test.testid in (<Antibody Tests>) 
