/*Main*/
select patient.SSNbr, sample.SpecimenTypeCd, patient.dob, patient.lastnm, patient.firstnm, sample.samplenbr, sample.sampledt, patient.hospitalid from labelprint left join sample on labelprint.sampleid = sample.sampleid left join patient on sample.patientid = patient.patientid where labelprint.userid = <User ID> and (sample.sampleid in (<Label Sample>) or labelprint.sampleid = 0) order by labelprint.ordernbr