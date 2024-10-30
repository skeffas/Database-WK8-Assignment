-- Healthcare Facilities
CREATE TABLE Facilities (
    facility_id INT PRIMARY KEY,
    facility_name VARCHAR(100),
    facility_type VARCHAR(50),
    location_district VARCHAR(50),
    beds_available INT,
    has_emergency_unit BOOLEAN,
    has_maternity_ward BOOLEAN,
    establishment_date DATE
);

-- Healthcare Providers
CREATE TABLE Healthcare_Providers (
    provider_id INT PRIMARY KEY,
    facility_id INT,
    provider_name VARCHAR(100),
    specialization VARCHAR(50),
    years_experience INT,
    is_available BOOLEAN,
    FOREIGN KEY (facility_id) REFERENCES Facilities(facility_id)
);

-- Patients
CREATE TABLE Patients (
    patient_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    date_of_birth DATE,
    district VARCHAR(50),
    contact_number VARCHAR(20),
    registration_date DATE
);

-- Pregnancies
CREATE TABLE Pregnancies (
    pregnancy_id INT PRIMARY KEY,
    patient_id INT,
    expected_delivery_date DATE,
    risk_level VARCHAR(20),
    registration_date DATE,
    outcome VARCHAR(50),
    delivery_date DATE,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
);

-- Prenatal Visits
CREATE TABLE Prenatal_Visits (
    visit_id INT PRIMARY KEY,
    pregnancy_id INT,
    facility_id INT,
    provider_id INT,
    visit_date DATE,
    visit_type VARCHAR(50),
    complications VARCHAR(200),
    next_appointment DATE,
    FOREIGN KEY (pregnancy_id) REFERENCES Pregnancies(pregnancy_id),
    FOREIGN KEY (facility_id) REFERENCES Facilities(facility_id),
    FOREIGN KEY (provider_id) REFERENCES Healthcare_Providers(provider_id)
);

-- Emergency Cases
CREATE TABLE Emergency_Cases (
    case_id INT PRIMARY KEY,
    pregnancy_id INT,
    facility_id INT,
    emergency_type VARCHAR(100),
    report_time TIMESTAMP,
    response_time_minutes INT,
    outcome VARCHAR(100),
    FOREIGN KEY (pregnancy_id) REFERENCES Pregnancies(pregnancy_id),
    FOREIGN KEY (facility_id) REFERENCES Facilities(facility_id)
);

-- Sample Data Population
INSERT INTO Facilities VALUES
(1, 'Central Maternity Hospital', 'Hospital', 'Central', 100, true, true, '2010-01-01'),
(2, 'Eastern Community Clinic', 'Clinic', 'Eastern', 20, false, true, '2015-03-15'),
(3, 'Western Health Center', 'Health Center', 'Western', 30, true, true, '2012-06-22');

INSERT INTO Healthcare_Providers VALUES
(1, 1, 'Dr. Sarah Johnson', 'Obstetrician', 10, true),
(2, 1, 'Dr. Michael Lee', 'Gynecologist', 8, true),
(3, 2, 'Dr. Emily Chen', 'Midwife', 5, true);

INSERT INTO Patients VALUES
(1, 'Maria', 'Garcia', '1990-05-15', 'Central', '123-456-7890', '2023-01-15'),
(2, 'Jane', 'Smith', '1988-08-22', 'Eastern', '234-567-8901', '2023-02-01'),
(3, 'Alice', 'Johnson', '1992-03-10', 'Western', '345-678-9012', '2023-02-15');

INSERT INTO Pregnancies VALUES
(1, 1, '2024-08-15', 'Low', '2023-12-15', NULL, NULL),
(2, 2, '2024-07-01', 'High', '2023-11-01', 'Successful', '2024-07-03'),
(3, 3, '2024-09-30', 'Medium', '2024-01-15', NULL, NULL);
