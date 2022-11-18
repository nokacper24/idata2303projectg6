-- How many employees of for a project titled "A" are involved in its plan “B”?
SELECT COUNT(*) FROM EmployeeActivity WHERE employeeid IN
    (SELECT employeeid FROM EmployeeActivity WHERE activityid IN
        (SELECT activityid FROM Activity WHERE planid IN
            (SELECT planid FROM Plan WHERE projectname = "A")
        )
    )
AND
activityid IN
    (SELECT activityid FROM Activity WHERE planid IN
        (SELECT planid FROM Plan WHERE projectname = "B")
    )
