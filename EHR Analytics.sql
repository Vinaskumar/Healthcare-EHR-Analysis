
-- ================================================
-- Healthcare Analytics SQL Script
-- Dataset: patients, encounters, conditions, observations, procedures, claims, payments, payers
-- ================================================

-- 1. How many ER visits happened overall?
SELECT COUNT(*) AS total_er_visits
FROM encounters
WHERE encounter_type = 'ER';

-- 2. How many unique patients visited ER?
SELECT COUNT(DISTINCT patient_id) AS unique_patients
FROM encounters
WHERE encounter_type = 'ER';

-- 3. Average ER length of stay (LOS) in hours
SELECT 
    AVG(DATEDIFF(HOUR, admit_time, discharge_time)) AS avg_los_hours
FROM encounters
WHERE encounter_type = 'ER';

-- 4. Top 5 primary conditions for ER visits
SELECT TOP 5 c.condition_name, COUNT(*) AS er_visits
FROM conditions c
JOIN encounters e ON c.encounter_id = e.encounter_id
WHERE e.encounter_type = 'ER' AND c.is_primary = 1
GROUP BY c.condition_name
ORDER BY er_visits DESC;

-- 5. Average time between admission and first procedure
WITH first_proc AS (
    SELECT 
        e.encounter_id,
        DATEDIFF(MINUTE, e.admit_time, MIN(p.start_time)) AS minutes_to_first_proc
    FROM encounters e
    JOIN procedures p 
        ON e.encounter_id = p.encounter_id
    WHERE e.encounter_type = 'ER'
    GROUP BY e.encounter_id, e.admit_time
)
SELECT 
    AVG(minutes_to_first_proc) AS avg_minutes_to_procedure
FROM first_proc;


-- 6. Claim denial rate by payer
SELECT pr.payer_name,
       ROUND(COUNT(CASE WHEN c.claim_status = 'Denied' THEN 1 END)*100.0 / COUNT(*),2) AS denial_rate_pct
FROM claims c
JOIN payers pr ON c.payer_id = pr.payer_id
GROUP BY pr.payer_name;

-- 7. Average payment turnaround (days) per payer
SELECT pr.payer_name,
       AVG(DATEDIFF(DAY, c.service_date, p.paid_date)) AS avg_turnaround_days
FROM claims c
JOIN payments p ON c.claim_id = p.claim_id
JOIN payers pr ON c.payer_id = pr.payer_id
WHERE c.claim_status = 'Paid'
GROUP BY pr.payer_name;

-- 8. Total billed vs total paid per payer
SELECT pr.payer_name,
       SUM(c.claim_amount) AS total_billed,
       SUM(p.paid_amount) AS total_paid
FROM claims c
JOIN payments p ON c.claim_id = p.claim_id
JOIN payers pr ON c.payer_id = pr.payer_id
GROUP BY pr.payer_name;

-- 9. Most common observation type recorded during ER visits
SELECT TOP 1 o.observation_type, COUNT(*) AS total_records
FROM observations o
JOIN encounters e ON o.encounter_id = e.encounter_id
WHERE e.encounter_type = 'ER'
GROUP BY o.observation_type
ORDER BY total_records DESC;

-- 10. Most denied procedure codes
SELECT p.procedure_name, COUNT(*) AS denied_count
FROM procedures p
JOIN claims c ON p.encounter_id = c.encounter_id
WHERE c.claim_status = 'Denied'
GROUP BY p.procedure_name
ORDER BY denied_count DESC;


