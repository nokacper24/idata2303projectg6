-- How many employees of for a project titled "A" are involved in its plan “B”?
<<<<<<< Updated upstream
SELECT COUNT(*) FROM EmployeeActivity WHERE activityid IN
    (SELECT activityid FROM Activity WHERE planname = "B")

-- Retrieve the names of plans made for project “A” with least cost.

-- For each employee retrieve the name, project name and plan name with the most working time.

-- Retrieve all the employee’s name and their least working time with respect to different project.

-- Retrieve all the plans for project with order of their working period.
