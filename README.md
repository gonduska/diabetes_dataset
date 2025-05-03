# Analysis of Data for Diabetes patients - 130-US Hospitals for Years 1999-2008

## Project Summary
This project explores the Diabetes Hospital Readmission dataset using SQL for analysis and Tableau for visualisation. 
The aim is to extract real-world, actionable insights and showcase technical skills in data cleaning, aggregation, and exploratory diagnosis.

## Objectives

This project aims to answer the following real-world healthcare analysis questions:

- Clean and prepare the dataset for analysis, ensuring no corrupt or ambiguous data impacts results

- How long do patients typically stay in hospital, and how does this vary by age, gender, or condition?

- What are the most common diagnoses among hospitalised diabetic patients?

- Which combinations of diagnoses frequently occur together?
  
- Identify the most frequent diagnoses and group them using ICD-9 categories

- Analyse co-diagnosis patterns using diag_1, diag_2, and diag_3 columns

- How does the demographic breakdown (age, race, gender) relate to diagnosis patterns?

- Are there notable trends or concerns in readmission rates or chronic condition clustering?

- How can we segment patients into meaningful types for further targeted healthcare interventions?

- Explore patient demographics and hospital usage trends (age, gender, race, stay duration)

- Lay groundwork for deeper exploration into medication usage patterns and patient segmentation

## Dataset Introduction and Description


The dataset originates from the UCI Machine Learning Repository and is also hosted on Kaggle. It captures hospital admissions data for diabetic patients, providing insights into their diagnoses, treatments, demographics, and outcomes.

The data simulates real hospital encounter records, focused on analysing factors related to readmission, medication use, and disease patterns.

Key attributes include patient demographics, diagnosis codes, hospital stay duration, medications administered, and discharge outcomes.

Key columns:

- race: Ethnic background of the patient

- gender: Patient sex

- age: Age range bracket

- diag_1, diag_2, diag_3: ICD-9 diagnosis codes (primary and secondary)

- weight: Patient weight bracket

- time_in_hospital: Number of days admitted

- readmitted: Whether the patient was readmitted within 30 days

- medications: Medications recorded for the encounter

## Tools used

- MySQL/SQLite
- Tableau

## Data Cleaning

Several columns contained missing or ambiguous values, typically represented by the placeholder "?". Key affected fields included race, weight, and the diagnosis columns (diag_1, diag_2, diag_3). These "?" entries were systematically replaced with NULL to ensure consistency and enable accurate filtering and aggregation.

Additionally, several ID fields, such as admission_type_id, discharge_disposition_id, and admission_source_id—included values that were labeled in the accompanying data dictionary as "Not Mapped", "Not Available", or simply NULL. 

These entries (e.g., IDs like 5, 6, or 8) were also treated as missing data and excluded from any analysis requiring valid categorical grouping.

For diagnosis fields, ICD-9 codes are expected to be at least three characters in length. Upon inspection, many entries were found with only one or two digits, such as 8, 23, or even "?". These were considered corrupted or truncated values (e.g., it's unclear whether 8 refers to 008, 080, or 800) and were excluded from diagnosis-based analysis.

By enforcing these cleaning rules, the dataset was made robust enough for consistent SQL querying and trustworthy analysis.

🔗 [SQL code for Data Cleaning](./sql/question_0_data_cleaning.sql)

## Understanding Patient Demographics

This dataset contains over 100,000 hospital admissions from approximately 70,000 unique diabetic patients. Around 54% of patients are female and 46% male. The majority of admissions (76.5%) are among Caucasian patients, and the most represented age group falls between 70 and 80 years old.

![Age_Gender_Bar Chart](./visuals/01_age_gender.png)

The average hospital stay increases with age, showing a clear correlation between age and length of admission. 
Female patients tend to remain hospitalised slightly longer than male patients by approximately 1.4 hours on average. A small, but consistent difference.

![Avg_Age_Gender_Bar Chart](./visuals/02_avg_hospital_stay.png)

## Analysing Diagnosis Records

To identify the most prevalent primary conditions among diabetic hospital admissions, we queried the diag_1 column, which records the primary ICD-9 diagnosis code per encounter. 

We grouped and counted these codes to determine frequency and ranked them using a RANK() window function.

Since raw ICD-9 codes are not human-readable, we manually mapped the top 10 most frequent codes to their corresponding clinical descriptions using a CASE statement.

Rank | ICD-9 Code | Diagnosis Description | Total Cases
1 | 428 | Heart failure | 6,862
2 | 414 | Other forms of chronic ischemic heart disease | 6,580
3 | 786 | Symptoms involving respiratory system and other chest symptoms | 4,016
4 | 410 | Acute myocardial infarction | 3,614
5 | 486 | Pneumonia, organism unspecified | 3,508
6 | 427 | Cardiac dysrhythmias | 2,766
7 | 491 | Chronic bronchitis | 2,275
8 | 715 | Osteoarthrosis and allied disorders | 2,151
9 | 682 | Other cellulitis and abscess | 2,042
10 | 434 | Occlusion of cerebral arteries | 2,028

These results suggest that many diabetic admissions are associated with cardiovascular and respiratory conditions. Heart failure alone accounts for nearly 7,000 admissions, followed closely by chronic heart disease and various respiratory issues. This confirms the significant overlap between diabetes and other chronic linked health conditions.

To better understand the healthcare burden associated with different conditions, we analysed the average hospital stay for the top 10 most frequent primary diagnoses shown above. 

While some conditions lead to relatively short admissions (for example respiratory symptoms: 2.12 days), others are associated with significantly longer stays.

Diagnosis | Avg. Hospital Stay (days)
Pneumonia | 5.04
Acute myocardial infarction | 4.87
Other cellulitis and abscess | 4.81
Occlusion of cerebral arteries | 4.76
Heart failure | 4.57

🔗 [SQL code for Q2](./sql/question_2_diagnosis_avg_stay.sql)


This data shows that conditions like pneumonia, heart failure, and serious circulatory disorders result in longer admissions, likely due to the need for more intensive care and recovery time. Conversely, more general or symptomatic diagnoses, such as chest symptoms, tend to lead to shorter stays.
