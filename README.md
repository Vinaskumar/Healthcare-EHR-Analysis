# 🏥 Healthcare Analytics Project  

## 📌 Overview  
This project simulates a **healthcare analytics environment** using a synthetic dataset inspired by Electronic Health Records (EHR).  
It focuses on analyzing **patient encounters, diagnoses, procedures, clinical observations, and payments** to derive meaningful insights for hospital operations and patient care.  

The goal is to practice:  
- Working with healthcare domain concepts  
- Writing SQL for business-driven questions  
- Understanding how data flows across encounters, diagnoses, procedures, and payments  
- Applying analytics for operational and financial improvements  

---

## 🔍 Business Questions  

The project answers **10 real-world healthcare questions** using SQL, including:  

1. How many ER visits happened overall?
2. How many unique patients visited ER?
3. Average ER length of stay (LOS) in hours
4. Top 5 primary conditions for ER visits 
5. Average time between admission and first procedure 
6. Claim denial rate by payer 
7. Average payment turnaround (days) per payer 
8. Total billed vs total paid per payer  
9. Most common observation type recorded during ER visits 
10. Most denied procedure codes  

---

## 🛠️ Example Query  

Here’s one of the queries (Q5 – Average time from ER admit to first procedure):  

```sql
SELECT 
    e.encounter_id,
    DATEDIFF(MINUTE, e.admit_time, MIN(p.start_time)) AS minutes_to_first_procedure
FROM encounters e
JOIN procedures p ON e.encounter_id = p.encounter_id
WHERE e.encounter_type = 'ER'
GROUP BY e.encounter_id;
