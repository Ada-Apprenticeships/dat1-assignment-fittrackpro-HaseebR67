.open fittrackpro.db
.mode column

DROP TABLE IF EXISTS locations;

CREATE TABLE locations (
    location_id INTEGER PRIMARY KEY NOT NULL,
    name VARCHAR,
    address VARCHAR,
    phone_number VARCHAR CHECk(length(replace(phone_number,'','')) >= 10),
    email CHECK(email LIKE '%_@_%._%'),
    opening_hours VARCHAR CHECK(opening_hours LIKE '__:__-__:__')
);

DROP TABLE IF EXISTS members; 

CREATE TABLE members(
    member_id INTEGER PRIMARY KEY NOT NULL,
    first_name VARCHAR, 
    last_name VARCHAR, 
    email CHECK(email LIKE '%_@_%._%'),
    phone_number VARCHAR CHECk(length(replace(phone_number,'','')) >= 10),
    date_of_birth DATE, 
    join_date DATE,
    emergency_contact_name VARCHAR,
    emergency_contact_phone VARCHAR CHECk(length(replace(phone_number,'','')) >= 10)
);

DROP TABLE IF EXISTS staff;

CREATE TABLE staff(
    staff_id INTEGER PRIMARY KEY NOT NULL,
    first_name VARCHAR,
    last_name VARCHAR,
    email CHECK(email LIKE '%_@_%._%'),
    phone_number VARCHAR CHECk(length(replace(phone_number,'','')) >= 10),
    position VARCHAR CHECK(position IN('Trainer', 'Manager', 'Receptionist', 'Maintenance')),
    hire_date DATE,
    location_id VARCHAR,
    FOREIGN KEY(location_id) REFERENCES locations(location_id)  ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS equipment;

CREATE TABLE equipment(
    equipment_id INTEGER PRIMARY KEY NOT NULL, 
    name VARCHAR,
    type VARCHAR CHECK(type IN('Cardio', 'Strength')),
    purchase_date DATE,
    last_maintenance_date DATE,
    next_maintenance_date DATE,
    location_id VARCHAR,
    FOREIGN KEY(location_id) REFERENCES locations(location_id)  ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS classes;

CREATE TABLE classes(
    class_id INTEGER PRIMARY KEY NOT NULL,
    name VARCHAR ,
    description VARCHAR,
    capacity INTEGER,
    duration INTEGER,
    location_id VARCHAR,
    FOREIGN KEY(location_id) REFERENCES locations(location_id)  ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS class_schedule;

CREATE TABLE class_schedule(
    schedule_id INTEGER PRIMARY KEY NOT NULL,
    class_id VARCHAR,
    staff_id VARCHAR,
    start_time TIME, 
    end_time TIME,
    FOREIGN KEY(staff_id) REFERENCES staff(staff_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(class_id) REFERENCES classes(class_id)  ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS memberships;

CREATE TABLE memberships(
    membership_id PRIMARY KEY NOT NULL,
    member_id VARCHAR,
    type VARCHAR,
    start_date DATE,
    end_date DATE,
    status VARCHAR CHECK(status IN('Active', 'Inactive')),
    FOREIGN KEY(member_id) REFERENCES members(member_id) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS attendance;

CREATE TABLE attendance(
    attendance_id INTEGER PRIMARY KEY NOT NULL,
    member_id VARCHAR,
    location_id VARCHAR, 
    check_in_time TIME, 
    check_out_time TIME,
    FOREIGN KEY(member_id) REFERENCES members(member_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(location_id) REFERENCES locations(location_id) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS class_attendance;

CREATE TABLE class_attendance(
    class_attendance_id INTEGER PRIMARY KEY NOT NULL, 
    schedule_id VARCHAR,
    member_id VARCHAR,
    attendance_status VARCHAR CHECK(attendance_status IN('Registered', 'Attended', 'Unattended')),
    FOREIGN KEY(member_id) REFERENCES members(member_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(schedule_id) REFERENCES class_schedule(schedule_id) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS payments;

CREATE TABLE payments(
    payment_id INTEGER PRIMARY KEY NOT NULL,
    member_id VARCHAR,
    amount REAL,
    payment_date TIME,
    payment_method VARCHAR CHECK(payment_method IN('Credit Card', 'Bank Transfer', 'PayPal', 'Cash')),
    payment_type VARCHAR CHECK(payment_type IN('Monthly membership fee','Day pass')),
    FOREIGN KEY(member_id) REFERENCES members(member_id) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS personal_training_sessions;

CREATE TABLE personal_training_sessions(
    session_id INTEGER PRIMARY KEY NOT NULL,
    member_id INTEGER,
    staff_id INTEGER,
    session_date DATE,
    start_time DATE,
    end_time DATE,
    notes VARCHAR,
    FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS member_health_metrics;

CREATE TABLE member_health_metrics(
    metric_id INTEGER PRIMARY KEY NOT NULL,
    member_id INTEGER,
    measurement_date DATE,
    weight REAL,
    body_fat_percentage REAL,
    muscle_mass REAL,
    bmi REAL,
    FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS equipment_maintenance_log;

CREATE TABLE equipment_maintenance_log(
    log_id INTEGER PRIMARY KEY NOT NULL,
    equipment_id INTEGER,
    maintenance_date DATE,
    description VARCHAR,
    staff_id INTEGER,
    FOREIGN KEY (equipment_id) REFERENCES equipment(equipment_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id) ON DELETE CASCADE ON UPDATE CASCADE
);