-- How many employees of for a project titled "A" are involved in its plan “B”?
SELECT COUNT(*) FROM EmployeeActivity WHERE activityid IN
    (SELECT activityid FROM Activity WHERE planname = "B")
