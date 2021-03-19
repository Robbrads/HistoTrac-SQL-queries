/*Main*/
select patient.patientid, patient.lastnm, patient.firstnm, patient.ssnbr, patient.dob, patient.hospitalid as hospitalnbr, patient.agenbr, patient.diagnosiscd, patient.abocd, patient.rhcd, patient.gendercd, patient.racecd, patient.dialysisid, patient.statuscd, patient.patienttypecd, patient.unosid, patient.physicianid, patient.servicinghospitalid, physician.lastnm as physicianlastnm, physician.firstnm as physicianfirstnm, hospital.hospitalnm, dialysis.dialysisnm, patient.categorycd, patient.unoslisteddt, patient.unoscd, patient.unosactivatedind as unosactivateind, patient.ethnicitycd, patient.deathdt as dod, patient.maidennm, patient.minm, patient.otheridnbr, patient.locationtxt as locationnm, coord.lastnm CoordLastNm, coord.firstnm CoordFirstNm from patient left join physician on physician.physicianid = patient.physicianid left join hospital on hospital.hospitalid = patient.servicinghospitalid left join dialysis on dialysis.dialysisid = patient.dialysisid left join coordinator coord on coord.coordinatorid = patient.coordinatorid where patient.patientid = <Current Patient>