.open fittrackpro.db
.mode column

-- 4.1 
SELECT DISTINCT classes.class_id, classes.name AS class_name,  staff.first_name || ' ' || staff.last_name AS instructor_name
FROM classes 
JOIN class_schedule ON classes.class_id = class_schedule.class_id
JOIN staff ON class_schedule.staff_id = staff.staff_id; 


-- 4.2 
SELECT class_schedule.class_id, classes.name, class_schedule.start_time, class_schedule.end_time, classes.capacity - IFNULL(COUNT(DISTINCT class_attendance.member_id), 0) AS available_spots
FROM class_schedule
JOIN classes ON class_schedule.class_id = classes.class_id
LEFT JOIN class_attendance ON class_schedule.schedule_id = class_attendance.schedule_id 
WHERE DATE(class_schedule.start_time) = '2025-02-01'
GROUP BY class_schedule.schedule_id;

-- 4.3 
INSERT INTO class_attendance (schedule_id, member_id, attendance_status)
VALUES (1,11, 'Registered'); 

-- 4.4 
DELETE FROM class_attendance 
WHERE schedule_id = 7 AND member_id = 3; 

-- 4.5 
SELECT classes.class_id, classes.name AS class_name, COUNT( DISTINCT class_attendance.member_id) AS registration_count 
FROM class_attendance
JOIN class_schedule ON class_attendance.schedule_id = class_schedule.schedule_id 
JOIN classes ON class_schedule.class_id = classes.class_id 
WHERE class_attendance.attendance_status IN ('Registered', 'Attended')
GROUP BY classes.class_id, classes.name 
ORDER BY registration_count DESC 
LIMIT 1; 

-- 4.6 
SELECT 
CAST(COUNT(*) AS FLOAT) / COUNT(DISTINCT member_id) AS avg_classes_per_member 
FROM class_attendance 
WHERE class_attendance.attendance_status IN ('Registered', 'Attended')