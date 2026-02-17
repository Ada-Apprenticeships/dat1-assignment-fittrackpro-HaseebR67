.open fittrackpro.db
.mode column

-- 5.1 
SELECT members.member_id, members.first_name, members.last_name, memberships.type AS membership_type, members.join_date
FROM memberships 
JOIN members ON memberships.member_id = members.member_id 
WHERE memberships.status = 'Active';


-- 5.2
SELECT memberships.type AS membership_type,
AVG(
    (strftime('%H', attendance.check_out_time) - strftime('%H', attendance.check_in_time)) * 60 
    +
    (strftime('%M', attendance.check_out_time) - strftime('%M', attendance.check_in_time))
) 
AS avg_visit_duration_minutes
FROM attendance 
JOIN memberships ON attendance.member_id = memberships.member_id
GROUP BY memberships.type;

-- 5.3 
SELECT members.member_id, members.first_name, members.last_name, members.email, memberships.end_date
FROM memberships 
JOIN members ON memberships.member_id = members.member_id
WHERE end_date >= '2025-01-01'
AND end_date <= '2025-12-31'

