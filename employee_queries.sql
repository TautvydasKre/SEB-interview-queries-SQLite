-- JOB1 Query: Retrieves the most recent active employment record for employee 102030
SELECT *
FROM JOB
WHERE "Employee ID" = 102030
  AND "Employment Status" = 'Active'
ORDER BY "Effective Date" DESC, "Effective Sequence" DESC
LIMIT 1;


-- JOB2 First Query: Retrieves the most recent active employment records for all employees.
-- One employee may have more than one active record.
-- The query selects only active employees and returns the following columns:
-- EMPLID, EMP_RCD, EFFDT, COMPANY, Birthdate, Current Age in years, Gender ('Female'/'Male'), and Preferred Phone.
WITH LatestRecords AS (
    SELECT 
        JOB.EMPLID, 
        JOB.EMP_RCD, 
        JOB.EFFDT, 
        JOB.Company,
        PERSONAL_DATA.Birthdate,
        PERSONAL_DATA.Gender,
        (SELECT Phone FROM PERSONAL_PHONE 
         WHERE PERSONAL_PHONE.EMPLID = JOB.EMPLID 
         AND PERSONAL_PHONE.Preferred = 'Y' 
         LIMIT 1) AS Preferred_Phone,
        ROW_NUMBER() OVER (PARTITION BY JOB.EMPLID ORDER BY JOB.EFFDT DESC, JOB.EFF_SEQ DESC) AS rn
    FROM JOB
    JOIN PERSONAL_DATA ON JOB.EMPLID = PERSONAL_DATA.EMPLID
    WHERE JOB.HR_STATUS = 'Active'
)
SELECT 
    EMPLID,
    EMP_RCD,
    EFFDT,
    Company,
    Birthdate,
    (strftime('%Y', 'now') - substr(Birthdate, 1, 4)) - 
    (strftime('%m%d', 'now') < substr(Birthdate, 5, 4)) AS Current_Age,
    CASE 
        WHEN Gender = 'M' THEN 'Male'
        WHEN Gender = 'F' THEN 'Female'
        ELSE 'Unknown' 
    END AS Gender,
    Preferred_Phone
FROM LatestRecords
WHERE rn = 1
ORDER BY EMPLID;


-- JOB2 Second Query: Retrieves each employee’s EMPLID along with all employment records they have/had in one column from the JOB table.
SELECT 
    EMPLID,
    GROUP_CONCAT(EMP_RCD, ',') AS RECORDS
FROM JOB
GROUP BY EMPLID
ORDER BY EMPLID;
