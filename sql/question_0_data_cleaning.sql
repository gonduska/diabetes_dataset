-- Data Cleaning

-- race
UPDATE 
	diabetes_data
SET 
	race = null
WHERE 
	race = '?';

-- weight
UPDATE 
	diabetes_data
SET 
	weight = NULL
WHERE 
	TRIM(weight) = '?';

SELECT 
  CASE 
    WHEN weight IS NULL THEN 'NULL'
    ELSE weight 
  END AS weight_group,
  COUNT(*) 
FROM diabetes_data
GROUP BY weight_group;

-- payer_code
UPDATE 
	diabetes_data
SET
	payer_code = null
WHERE
	TRIM(payer_code) = '?';
	

-- medical_specialty

UPDATE 
	diabetes_data
SET
	medical_specialty = null
WHERE
	TRIM(medical_specialty) = '?';
    
-- diag_1, diag_2, diag_3
-- ?
-- also IC9 codes have length >=3, hence anything less is not valid. for diagnosis based analysis I am excluding these for all diag col
-- diag_1
select diag_1, count(diag_1) from diabetes_data group by diag_1 having length(diag_1) < 3;
-- diag_2
select diag_2, count(diag_2) from diabetes_data group by diag_2 having length(diag_2) < 3;
-- diag_3
select diag_3, count(diag_3) from diabetes_data group by diag_3 having length(diag_3) < 3;


-- admission_type_id
UPDATE
	diabetes_data
SET 
	admission_type_id = null
WHERE
	admission_type_id in (5,6,8);

-- discharge_disposition_id
UPDATE
	diabetes_data
SET 
	discharge_disposition_id = null
WHERE
	discharge_disposition_id in (18,25,26);

-- admission_source_id

UPDATE
	diabetes_data
SET
	admission_source_id = null
WHERE
	admission_source_id in (9,15,17,20,21);
    
    
