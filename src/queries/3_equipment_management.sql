.open fittrackpro.db
.mode column

-- 3.1 
SELECT equipment_id, name, next_maintenance_date
FROM equipment
WHERE next_maintenance_date >= '2025-01-01'
AND next_maintenance_date < '2025-01-31';

-- 3.2 
SELECT type as equipment_type,
COUNT(*) AS count 
FROM equipment 
GROUP BY type; 

-- 3.3 
SELECT type as equipment_type
AVG((2025 - purchase_date) * 365) AS avg_age_days
FROM equipment
GROUP BY type; 
