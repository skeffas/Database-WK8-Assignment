-- 1. Facility Coverage Analysis
SELECT 
    f.location_district,
    COUNT(f.facility_id) as total_facilities,
    SUM(f.beds_available) as total_beds,
    COUNT(CASE WHEN f.has_emergency_unit THEN 1 END) as emergency_units
FROM Facilities f
GROUP BY f.location_district;

-- 2. Provider Distribution
SELECT 
    f.location_district,
    hp.specialization,
    COUNT(hp.provider_id) as provider_count,
    AVG(hp.years_experience) as avg_experience
FROM Healthcare_Providers hp
JOIN Facilities f ON hp.facility_id = f.facility_id
GROUP BY f.location_district, hp.specialization;

-- 3. Risk Level Distribution
SELECT 
    risk_level,
    COUNT(*) as pregnancy_count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Pregnancies), 2) as percentage
FROM Pregnancies
GROUP BY risk_level;

-- 4. Prenatal Visit Compliance
SELECT 
    p.pregnancy_id,
    COUNT(pv.visit_id) as visit_count,
    MAX(pv.visit_date) as last_visit_date,
    CASE 
        WHEN p.expected_delivery_date > CURRENT_DATE 
        THEN ROUND(COUNT(pv.visit_id) * 1.0 / 
             (EXTRACT(MONTH FROM age(p.expected_delivery_date, p.registration_date))), 2)
        ELSE NULL
    END as visits_per_month
FROM Pregnancies p
LEFT JOIN Prenatal_Visits pv ON p.pregnancy_id = pv.pregnancy_id
GROUP BY p.pregnancy_id, p.expected_delivery_date, p.registration_date;

-- 5. Emergency Response Analysis
SELECT 
    f.facility_name,
    AVG(ec.response_time_minutes) as avg_response_time,
    COUNT(ec.case_id) as total_emergencies,
    COUNT(CASE WHEN ec.outcome = 'Successful' THEN 1 END) as successful_outcomes
FROM Emergency_Cases ec
JOIN Facilities f ON ec.facility_id = f.facility_id
GROUP BY f.facility_name;
