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


-- 1.5


-- 1.6

