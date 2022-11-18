DROP TABLE IF EXISTS Project;
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Plan;
DROP TABLE IF EXISTS Activity;
DROP TABLE IF EXISTS EmployeeActivity;

CREATE TABLE IF NOT EXISTS Employee (
    employeeid INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    hourlycost FLOAT NOT NULL
    CHECK (hourlycost > 0)
);

CREATE TABLE IF NOT EXISTS Project (
    projectname TEXT PRIMARY KEY,
    leaderid INTEGER NOT NULL,
    budget FLOAT NOT NULL,
    startdate DATE NOT NULL,
    enddate DATE NOT NULL,
    FOREIGN KEY (leaderid) REFERENCES Employee(employeeid)
    CHECK (enddate > startdate AND budget > 0)
);

CREATE TABLE IF NOT EXISTS Plan (
    planname TEXT PRIMARY KEY,
    projectname TEXT NOT NULL,
    startdate DATE NOT NULL,
    enddate DATE NOT NULL,
    FOREIGN KEY (projectname) REFERENCES Project(projectname)
    CHECK (startdate <= enddate)
);

CREATE TRIGGER IF NOT EXISTS check_plan_dates
BEFORE INSERT ON Plan
FOR EACH ROW
BEGIN
    SELECT RAISE(ABORT, 'Plan dates are not within project dates')
    FROM Project
    WHERE Project.projectname = NEW.projectname
    AND (NEW.startdate < Project.startdate OR NEW.enddate > Project.enddate);
END;

CREATE TABLE IF NOT EXISTS Activity (
    activityid INTEGER PRIMARY KEY,
    planname TEXT NOT NULL,
    activitytype TEXT NOT NULL,
    startdate DATE NOT NULL,
    enddate DATE NOT NULL,
    FOREIGN KEY (planname) REFERENCES Plan(planname)
    CHECK (startdate <= enddate)
);

CREATE TRIGGER IF NOT EXISTS check_activity_dates
BEFORE INSERT ON Activity
FOR EACH ROW
BEGIN
    SELECT RAISE(ABORT, 'Activity dates are not within plan dates')
    FROM Plan
    WHERE Plan.planname = NEW.planname
    AND (NEW.startdate < Plan.startdate OR NEW.enddate > Plan.enddate);
END;

CREATE TABLE IF NOT EXISTS EmployeeActivity (
    employeeid INTEGER NOT NULL,
    activityid INTEGER NOT NULL,
    hoursworked FLOAT NOT NULL,
    PRIMARY KEY (employeeid, activityid),
    FOREIGN KEY (employeeid) REFERENCES Employee(employeeid),
    FOREIGN KEY (activityid) REFERENCES Activity(activityid)
    CHECK (hoursworked > 0)
);


-- QUERIES -----------------------------------------------------------------------

-- How many employees of for a project titled "A" are involved in its plan “B”?
SELECT COUNT(*)
FROM EmployeeActivity
WHERE activityid IN (SELECT activityid FROM Activity WHERE planname = "B");



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
