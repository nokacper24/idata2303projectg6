-- How many employees of for a project titled "A" are involved in its plan “B”?
SELECT COUNT(*) FROM EmployeeActivity WHERE activityid IN
    (SELECT activityid FROM Activity WHERE planname = "B");

-- Retrieve the names of plans made for project “A” with least cost.
WITH costsOfPlansInA AS
    (SELECT Plan.planname, SUM(EmployeeActivity.hoursworked * Employee.hourlycost) AS totalcost
    FROM Plan, Activity, EmployeeActivity, Employee
    WHERE Plan.planname = Activity.planname AND Activity.activityid = EmployeeActivity.activityid
    AND EmployeeActivity.employeeid = Employee.employeeid AND Plan.projectname = "A"
    GROUP BY Plan.planname),
leastCost AS
    (SELECT MIN(totalcost) AS mincost FROM costsOfPlansInA)

SELECT planname FROM costsOfPlansInA, leastCost
WHERE costsOfPlansInA.totalcost = leastCost.mincost;

-- For each employee retrieve the name, project name and plan name with the most working time.

-- Retrieve all the employee’s name and their least working time with respect to different project.

-- Retrieve all the plans for project with order of their working period.
SELECT * FROM Plan WHERE projectname = "A" ORDER BY julianday(startdate);
