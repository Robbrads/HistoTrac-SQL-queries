/*Main*/
Select  patient.lastnm, patient.firstnm, sample.samplenbr, sample.logtime, ([dbo].[TestsForSample](Sample.SampleID)) as TestTypeCd, sample.sampledt from sample inner join patient on patient.patientid = sample.patientid where sample.logtime between CAST (convert (varchar(11), '<From Date>') as datetime) and  CAST (convert (varchar (11), '<To Date>') + ' 23:59:59' as datetime) order by sample.samplenbr asc


