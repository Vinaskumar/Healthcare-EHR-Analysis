# 🏥 Healthcare Analytics Project  

---

## 📌 Executive Summary  
This project demonstrates how healthcare data can be leveraged to improve **hospital operations, financial performance, and patient outcomes**.  
By simulating an Electronic Health Records (EHR)-inspired environment, we analyze patient encounters, diagnoses, procedures, observations, and payments.  
The project answers **10 key business questions** using SQL, focusing on emergency room (ER) operations and payer performance.  

---

## ❓ Business Problem  
Hospitals face challenges in managing **patient flow, clinical operations, and financial performance**.  
Key concerns include:  
- High ER congestion  
- Unclear visibility into common conditions and procedures  
- Inefficiencies in claim processing and payments  
- Lack of actionable insights for decision-making  

This project aims to address these challenges by exploring **encounter patterns, patient conditions, operational timelines, and payer performance**.  

---

## ⚙️ Methodology  
1. **Data Modeling** – Designed a relational structure connecting encounters, diagnoses, procedures, observations, and payments.  
2. **SQL Analysis** – Wrote queries to answer real-world healthcare business questions.  
3. **Operational Metrics** – Focused on ER visits, patient counts, and length of stay.  
4. **Financial Metrics** – Analyzed claim denial rates, billed vs paid amounts, and payment turnaround times.  
5. **Clinical Insights** – Identified top diagnoses, procedures, and observation trends.  

Example query (Q5 – Average time from ER admit to first procedure):  

```sql
SELECT 
    e.encounter_id,
    DATEDIFF(MINUTE, e.admit_time, MIN(p.start_time)) AS minutes_to_first_procedure
FROM encounters e
JOIN procedures p ON e.encounter_id = p.encounter_id
WHERE e.encounter_type = 'ER'
GROUP BY e.encounter_id;
```

---

## 🧰 Skills

SQL: Joins, aggregations, window functions, filtering, case statements

Healthcare Analytics: EHR concepts, claims analysis, operational KPIs

Data Modeling: Understanding entity relationships between encounters, diagnoses, and payments

Business Intelligence: Translating clinical and financial data into actionable insights

---

## 📊 Results & Business Recommendations

### Key findings from the analysis:

ER Visits: Total visit counts and unique patient volumes provide insights into hospital load.

Length of Stay (LOS): Average LOS helps measure ER efficiency.

Top Conditions: Identifying frequent ER conditions assists in resource planning.

Procedures & Observations: Helps align staffing and equipment availability.

Financials: Denial rates and billed vs paid comparisons highlight payer negotiation opportunities.

### Recommendations:

Optimize staffing during peak ER hours.

Implement fast-track protocols for high-frequency conditions.

Improve claims submission accuracy to reduce denial rates.

Negotiate better terms with payers showing delayed payments.

---

## 🚀 Next Steps

Visualization: Build dashboards in Tableau/Power BI for real-time monitoring.

Predictive Analytics: Forecast ER visit volumes and claim approval probabilities.

Automation: Develop ETL pipelines for continuous data updates.

Expansion: Extend the analysis to inpatient and outpatient settings beyond ER.
