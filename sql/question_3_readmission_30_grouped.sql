-- Exploring readmission within 30 days
SELECT
	age,
    COUNT(readmitted) AS num_readmitted_patients
FROM
	diabetes_data
WHERE 
	REPLACE(readmitted, '\r', '') IN ('<30')
GROUP BY
	age;
    
SELECT
    COUNT(readmitted) AS readmissions_under_30
,
		CASE
		  WHEN CAST(diag_1 AS UNSIGNED) BETWEEN 390 AND 459 OR CAST(diag_1 AS UNSIGNED) = 785 THEN 'Circulatory'
		  WHEN CAST(diag_1 AS UNSIGNED) BETWEEN 460 AND 519 OR CAST(diag_1 AS UNSIGNED) = 786 THEN 'Respiratory'
		  WHEN CAST(diag_1 AS UNSIGNED) BETWEEN 520 AND 579 OR CAST(diag_1 AS UNSIGNED) = 787 THEN 'Digestive'
		  WHEN CAST(diag_1 AS UNSIGNED) = 250 THEN 'Diabetes'
		  WHEN CAST(diag_1 AS UNSIGNED) BETWEEN 800 AND 999 THEN 'Injury'
		  WHEN CAST(diag_1 AS UNSIGNED) BETWEEN 710 AND 739 THEN 'Musculoskeletal'
		  WHEN CAST(diag_1 AS UNSIGNED) BETWEEN 140 AND 239 THEN 'Neoplasms'
		  WHEN diag_1 IS NULL OR diag_1 = '?' THEN 'Missing/Unknown'
		ELSE 'Other'
END AS diagnosis_group

FROM
	diabetes_data
WHERE 
	REPLACE(readmitted, '\r', '') IN ('<30')
GROUP BY
	diagnosis_group
ORDER BY
	readmissions_under_30 DESC
    ;



SELECT
  visit_frequency,
  COUNT(*) AS admissions,
  SUM(CASE WHEN REPLACE(readmitted, '\r', '') = '<30' THEN 1 ELSE 0 END) AS readmitted_under_30,
  ROUND(SUM(CASE WHEN REPLACE(readmitted, '\r', '') = '<30' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS readmission_rate_pct
FROM (
  SELECT *,
    CASE
      WHEN (number_outpatient + number_emergency + number_inpatient) BETWEEN 1 AND 2 THEN 'Some prior visits'
      WHEN (number_outpatient + number_emergency + number_inpatient) >= 3 THEN 'Frequent past visits'
      ELSE 'No prior visits'
    END AS visit_frequency
  FROM diabetes_data
) AS grouped
GROUP BY visit_frequency
ORDER BY readmission_rate_pct DESC;
