.open fittrackpro.db
.mode column

-- 8.1 
SELECT personal_training_sessions.session_id, staff.first_name || ' ' || staff.last_name AS member_name, personal_training_sessions.session_date, personal_training_sessions.start_time, personal_training_sessions.end_time 
FROM personal_training_sessions
JOIN staff ON personal_training_sessions.staff_id = staff.staff_id
WHERE personal_training_sessions.staff_id = 2; 
