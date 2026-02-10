.open fittrackpro.db
.mode column

-- 5.1 
SELECT members.member_id, members.first_name, members.last_name, memberships.type AS membership_type, members.join_date
FROM memberships 
INNER JOIN members ON memberships.member_id = members.member_id 
WHERE memberships.status = 'Active';


-- 5.2


-- 5.3 
SELECT members.member_id, members.first_name, members.last_name, members.email, memberships.end_date
FROM memberships 
INNER JOIN members ON memberships.member_id = members.member_id
WHERE end_date >= '2025-01-01'
AND end_date <= '2025-12-31'

