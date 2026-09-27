-- ============================================================
-- 04_kpi_queries_oracle.sql
-- Hospital Patient & Revenue Analytics System — KPI Queries
-- Target: Oracle Database 10g
--
-- Oracle 10g notes vs the SQLite version:
--   * No LIMIT / FETCH FIRST (that's 12c+) -> use ROWNUM over
--     an ordered subquery instead.
--   * No strftime() -> use TO_CHAR(date, 'YYYY-MM') instead.
--   * Analytic/window functions (OVER PARTITION BY) work fine
--     in 10g, so query 9 is unchanged in structure.
-- ============================================================

-- 1. Total revenue and total admissions (headline KPIs)
SELECT
    COUNT(*) AS total_admissions,
    ROUND(SUM(billing_amount), 2) AS total_revenue,
    ROUND(AVG(billing_amount), 2) AS avg_billing_per_admission
FROM admissions;

-- 2. Monthly revenue trend
SELECT
    TO_CHAR(date_of_admission, 'YYYY-MM') AS month,
    COUNT(*) AS admissions,
    ROUND(SUM(billing_amount), 2) AS revenue
FROM admissions
GROUP BY TO_CHAR(date_of_admission, 'YYYY-MM')
ORDER BY month;

-- 3. Revenue by hospital (top 10)
SELECT * FROM (
    SELECT
        h.hospital_name,
        COUNT(*) AS admissions,
        ROUND(SUM(a.billing_amount), 2) AS revenue
    FROM admissions a
    JOIN hospitals h ON a.hospital_id = h.hospital_id
    GROUP BY h.hospital_name
    ORDER BY revenue DESC
)
WHERE ROWNUM <= 10;

-- 4. Revenue by doctor (top 10)
SELECT * FROM (
    SELECT
        d.doctor_name,
        COUNT(*) AS admissions,
        ROUND(SUM(a.billing_amount), 2) AS revenue
    FROM admissions a
    JOIN doctors d ON a.doctor_id = d.doctor_id
    GROUP BY d.doctor_name
    ORDER BY revenue DESC
)
WHERE ROWNUM <= 10;

-- 5. Average length of stay overall and by admission type
SELECT
    admission_type,
    COUNT(*) AS admissions,
    ROUND(AVG(length_of_stay), 2) AS avg_length_of_stay
FROM admissions
GROUP BY admission_type
ORDER BY avg_length_of_stay DESC;

-- 6. Revenue and average billing by admission type
SELECT
    admission_type,
    COUNT(*) AS admissions,
    ROUND(SUM(billing_amount), 2) AS revenue,
    ROUND(AVG(billing_amount), 2) AS avg_billing
FROM admissions
GROUP BY admission_type
ORDER BY revenue DESC;

-- 7. Insurance provider split — revenue and admission share
SELECT
    p.provider_name,
    COUNT(*) AS admissions,
    ROUND(SUM(a.billing_amount), 2) AS revenue,
    ROUND(100 * COUNT(*) / (SELECT COUNT(*) FROM admissions), 2) AS pct_of_admissions
FROM admissions a
JOIN insurance_providers p ON a.provider_id = p.provider_id
GROUP BY p.provider_name
ORDER BY revenue DESC;

-- 8. Top medical conditions by total billing (cost burden)
SELECT
    medical_condition,
    COUNT(*) AS admissions,
    ROUND(SUM(billing_amount), 2) AS revenue,
    ROUND(AVG(billing_amount), 2) AS avg_billing
FROM admissions
GROUP BY medical_condition
ORDER BY revenue DESC;

-- 9. Patient demographics — admissions by age bracket and gender
SELECT
    CASE
        WHEN pt.age < 18 THEN 'Under 18'
        WHEN pt.age BETWEEN 18 AND 35 THEN '18-35'
        WHEN pt.age BETWEEN 36 AND 55 THEN '36-55'
        WHEN pt.age BETWEEN 56 AND 75 THEN '56-75'
        ELSE '75+'
    END AS age_bracket,
    pt.gender,
    COUNT(*) AS admissions,
    ROUND(SUM(a.billing_amount), 2) AS revenue
FROM admissions a
JOIN patients pt ON a.patient_id = pt.patient_id
GROUP BY
    CASE
        WHEN pt.age < 18 THEN 'Under 18'
        WHEN pt.age BETWEEN 18 AND 35 THEN '18-35'
        WHEN pt.age BETWEEN 36 AND 55 THEN '36-55'
        WHEN pt.age BETWEEN 56 AND 75 THEN '56-75'
        ELSE '75+'
    END,
    pt.gender
ORDER BY 1, 2;

-- 10. Test result outcomes by medical condition (quality-of-care angle)
SELECT
    medical_condition,
    test_results,
    COUNT(*) AS cases,
    ROUND(100 * COUNT(*) / SUM(COUNT(*)) OVER (PARTITION BY medical_condition), 2) AS pct_within_condition
FROM admissions
GROUP BY medical_condition, test_results
ORDER BY medical_condition, cases DESC;

-- 11. Room utilization — most frequently used rooms
SELECT * FROM (
    SELECT
        room_number,
        COUNT(*) AS times_used
    FROM admissions
    GROUP BY room_number
    ORDER BY times_used DESC
)
WHERE ROWNUM <= 10;

-- 12. Repeat patients (readmission-style signal)
SELECT * FROM (
    SELECT
        pt.name,
        pt.age,
        pt.gender,
        COUNT(*) AS num_admissions,
        ROUND(SUM(a.billing_amount), 2) AS total_billed
    FROM admissions a
    JOIN patients pt ON a.patient_id = pt.patient_id
    GROUP BY a.patient_id, pt.name, pt.age, pt.gender
    HAVING COUNT(*) > 1
    ORDER BY num_admissions DESC
)
WHERE ROWNUM <= 10;
