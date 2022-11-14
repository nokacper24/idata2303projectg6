DROP TABLE IF EXISTS Project;
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Plan;
DROP TABLE IF EXISTS Activity;
DROP TABLE IF EXISTS EmployeeActivity;

CREATE TABLE IF NOT EXISTS Employee (
    employeeid INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    hourlycost FLOAT NOT NULL
);

CREATE TABLE IF NOT EXISTS Project (
    projectname INTEGER PRIMARY KEY,
    leaderid INTEGER NOT NULL,
    budget FLOAT NOT NULL,
    startdate DATE NOT NULL,
    enddate DATE NOT NULL,
    FOREIGN KEY (leaderid) REFERENCES Employee(employeeid)
);

CREATE TABLE IF NOT EXISTS Plan (
    planid INTEGER PRIMARY KEY,
    projectname INTEGER NOT NULL,
    startdate DATE NOT NULL,
    enddate DATE NOT NULL,
    FOREIGN KEY (projectname) REFERENCES Project(projectname)
);

CREATE TABLE IF NOT EXISTS Activity (
    activityid INTEGER PRIMARY KEY,
    planid INTEGER NOT NULL,
    activitytype TEXT NOT NULL,
    startdate DATE NOT NULL,
    enddate DATE NOT NULL,
    FOREIGN KEY (planid) REFERENCES Plan(planid)
);

CREATE TABLE IF NOT EXISTS EmployeeActivity (
    employeeid INTEGER NOT NULL,
    activityid INTEGER NOT NULL,
    hoursworked FLOAT NOT NULL,
    PRIMARY KEY (employeeid, activityid),
    FOREIGN KEY (employeeid) REFERENCES Employee(employeeid),
    FOREIGN KEY (activityid) REFERENCES Activity(activityid)
);