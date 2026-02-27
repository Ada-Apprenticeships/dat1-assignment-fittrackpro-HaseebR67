.open fittrackpro.db
.mode column

-- 6.1 
INSERT INTO attendance(
    member_id,
    location_id,
    check_in_time
)

VALUES(
    7,
    1,
    '2025-02-14 16:30:00'
);


-- 6.2 
SELECT DATE(check_in_time) AS visit_date, check_in_time, check_out_time 
FROM attendance 
WHERE member_id = 5;


-- 6.3 
SELECT 
CASE strftime('%w', check_in_time) 
    WHEN '0' THEN 'Sunday'
    WHEN '1' THEN 'Monday'
    WHEN '2' THEN 'Tuesday'
    WHEN '3' THEN 'Wednesday'
    WHEN '4' THEN 'Thursday'
    WHEN '5' THEN 'Friday'
    WHEN '6' THEN 'Saturday' 
END AS day_of_week, 
COUNT(*) AS visit_count
FROM attendance 
WHERE check_out_time IS NOT NULL 
GROUP BY day_of_week
ORDER BY visit_count DESC; 

-- 6.4 
SELECT 
    locations.name AS location_name,
    AVG(attendance_per_day) AS avg_daily_attendance
FROM (
    SELECT 
        attendance.location_id,
        DATE(attendance.check_in_time) AS day,
        COUNT(*) AS attendance_per_day
    FROM attendance 
    GROUP BY attendance.location_id, DATE(attendance.check_in_time)
) AS daily_counts
JOIN locations ON daily_counts.location_id = locations.location_id
GROUP BY locations.location_id;