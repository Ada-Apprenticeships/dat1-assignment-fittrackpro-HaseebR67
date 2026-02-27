.open fittrackpro.db
.mode column

-- 1.1
SELECT member_id,first_name,last_name,email,join_date
FROM members;

-- 1.2
UPDATE members
SET phone_number = '07000 100005', email = 'emily.jones.updated@email.com'
WHERE member_id = 5;

-- 1.3
SELECT COUNT(*)
FROM members; 


-- 1.4
SELECT members.member_id,first_name,last_name, COUNT(class_attendance.member_id) as registration_count
FROM class_attendance
JOIN members
ON class_attendance.member_id = members.member_id
GROUP BY members.member_id
ORDER BY registration_count DESC
LIMIT 1;

-- 1.5
SELECT members.member_id,first_name,last_name, COUNT(class_attendance.member_id) as registration_count
FROM class_attendance
JOIN members
ON class_attendance.member_id = members.member_id
GROUP BY members.member_id
ORDER BY registration_count ASC
LIMIT 1;

-- 1.6
SELECT COUNT(*) AS Count
FROM (
    SELECT member_id
    FROM class_attendance
    WHERE attendance_status = 'Attended'
    GROUP BY member_id
    HAVING COUNT(*) >= 2
) AS attended_twice;