-- Avg stay for each diagnosis
SELECT
	diag_1,
    COUNT(diag_1) AS total_diagnosis,
    CASE 
			WHEN diag_1 = 428 THEN 'Heart failure'
            WHEN diag_1 = 414 THEN 'Other forms of chronic ischemic heart disease'
			WHEN diag_1 = 786 THEN 'Symptoms involving respiratory system and other chest symptoms'
			WHEN diag_1 = 410 THEN 'Acute myocardial infarction'
			WHEN diag_1 = 486 THEN 'Pneumonia, organism unspecified'
			WHEN diag_1 = 427 THEN 'Cardiac dysrhythmias'
			WHEN diag_1 = 491 THEN 'Chronic bronchitis'
			WHEN diag_1 = 715 THEN 'Osteoarthrosis and allied disorders'
			WHEN diag_1 = 682 THEN 'Other cellulitis and abscess'
			WHEN diag_1 = 434 THEN 'Occlusion of cerebral arteries'
		END AS IC9_desc,
	ROUND(AVG(time_in_hospital),2) AS avg_hospital_stay
FROM
	diabetes_data
GROUP BY
	diag_1
ORDER BY
	total_diagnosis DESC
LIMIT 10;