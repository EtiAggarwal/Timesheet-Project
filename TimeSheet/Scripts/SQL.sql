-- TABLE SCHEMA

CREATE TABLE TIMESHEET
(
ID BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
EMPLOYEE_ID VARCHAR(255) NOT NULL,
PROJECT_ID NUMERIC(18,0) NOT NULL,
PROJECT_NAME VARCHAR(255) NOT NULL,
TASK_JIRA_ISSUE_PROXY_KEY VARCHAR(255) NOT NULL,
TIMESHEET_DATE DATETIME NOT NULL,
HOURS_PER_DAY NUMERIC(7,5) NOT NULL  CHECK(HOURS_PER_DAY > 0 AND HOURS_PER_DAY <=24),
COMMENTS VARCHAR(2000),
ENTRY_ADD_DATE DATETIME,
LAST_MODIFIED_DATE DATETIME
);

--TABLE USER_LOGIN

CREATE TABLE USER_LOGIN
(
ID BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
EMPLOYEE_ID VARCHAR(255) NOT NULL UNIQUE,
FIRST_NAME VARCHAR(255) NOT NULL,
LAST_NAME VARCHAR(255) NOT NULL,
EMAIL_ID VARCHAR(255) NOT NULL,
PASS VARCHAR(255) NOT NULL,
USER_GUID UNIQUEIDENTIFIER NULL,
IS_ADMIN BIT NOT NULL DEFAULT 0, -- 0 = not admin 1 = admin
SIGN_UP_DATE DATETIME,
LAST_LOGIN_DATE DATETIME,
LAST_MODIFIED_DATE DATETIME
)


IF ( OBJECT_ID('SP_INSERT_TIMESHEET_ENTRY') IS NOT NULL ) 
   DROP PROCEDURE SP_INSERT_TIMESHEET_ENTRY
GO

CREATE PROCEDURE SP_INSERT_TIMESHEET_ENTRY
       @EMPLOYEE_ID VARCHAR(255),
       @PROJECT_ID NUMERIC(18,0),
       @PROJECT_NAME VARCHAR(255),
       @TASK_JIRA_ISSUE_PROXY_KEY VARCHAR(255),
       @TIMESHEET_DATE VARCHAR(10),
       @HOURS_PER_DAY NUMERIC(7,5),
       @COMMENTS VARCHAR(2000)
AS
BEGIN 
	DECLARE 
	@TOTAL_HOURS NUMERIC,
	@FOR_DATE DATETIME;
-- Check the total number of hours already submitted for the date
		
	SELECT @FOR_DATE = CONVERT(DATETIME,@TIMESHEET_DATE,101);
	SELECT @TOTAL_HOURS = SUM(HOURS_PER_DAY) FROM TIMESHEET WHERE EMPLOYEE_ID = @EMPLOYEE_ID AND TIMESHEET_DATE = @FOR_DATE;
    
    IF @TOTAL_HOURS = 24
	-- already 24 hours submitted
		RETURN -2 ;
	ELSE
	BEGIN 
		-- sum of submitted plus this entry is > 24
		IF (@TOTAL_HOURS+@HOURS_PER_DAY) > 24
		RETURN -1;
		ELSE
		BEGIN
			INSERT INTO TIMESHEET VALUES(@EMPLOYEE_ID, @PROJECT_ID, @PROJECT_NAME, @TASK_JIRA_ISSUE_PROXY_KEY,@FOR_DATE,@HOURS_PER_DAY,@COMMENTS,CURRENT_TIMESTAMP,NULL);
			IF @@ROWCOUNT = 1
				RETURN 1;
			ELSE
				RETURN 0;
		END
	END
END 

--Procedure to update the timesheet entry

IF ( OBJECT_ID('SP_UPDATE_TIMESHEET_ENTRY') IS NOT NULL ) 
   DROP PROCEDURE SP_UPDATE_TIMESHEET_ENTRY
GO

CREATE PROCEDURE SP_UPDATE_TIMESHEET_ENTRY
       @ID BIGINT,
       @EMPLOYEE_ID VARCHAR(255),
       @TIMESHEET_DATE VARCHAR(10),
       @HOURS_PER_DAY NUMERIC(7,5),
       @COMMENTS VARCHAR(2000)
AS
BEGIN 
	DECLARE 
	@TOTAL_HOURS NUMERIC,
	@FOR_DATE DATETIME
-- Check the total number of hours already submitted for the date
	
	SELECT @FOR_DATE = CONVERT(DATETIME,@TIMESHEET_DATE,101);
	SELECT @TOTAL_HOURS = SUM(HOURS_PER_DAY) FROM TIMESHEET WHERE EMPLOYEE_ID = @EMPLOYEE_ID AND TIMESHEET_DATE = @FOR_DATE AND ID <> @ID;
    
		-- sum of submitted plus this entry is > 24
		IF (@TOTAL_HOURS+@HOURS_PER_DAY) > 24
		RETURN -1;
		ELSE
		BEGIN
			UPDATE TIMESHEET SET HOURS_PER_DAY = @HOURS_PER_DAY , COMMENTS = @COMMENTS , LAST_MODIFIED_DATE = CURRENT_TIMESTAMP WHERE ID = @ID ;
			IF @@ROWCOUNT = 1
				RETURN 1;
			ELSE
				RETURN 0;
		END
END 

-- procedure to add new user on sign up

IF ( OBJECT_ID('SP_ADD_NEW_USER') IS NOT NULL ) 
   DROP PROCEDURE SP_ADD_NEW_USER
GO

CREATE PROCEDURE SP_ADD_NEW_USER
       @EMPLOYEE_ID VARCHAR(255),
       @FIRST_NAME VARCHAR(255),
       @LAST_NAME VARCHAR(255),
       @EMAIL_ID VARCHAR(255),
       @PASS VARCHAR(255),
       @USER_GUID UNIQUEIDENTIFIER
       
AS
BEGIN 
	DECLARE 
	@COUNT NUMERIC
	
-- Check if user already exists
	
	SELECT @COUNT = COUNT(EMPLOYEE_ID) FROM USER_LOGIN WHERE EMPLOYEE_ID = @EMPLOYEE_ID;
	
		-- if employee id already exists return -1
		IF @COUNT = 1
		RETURN -1;
		ELSE
		BEGIN
			INSERT INTO USER_LOGIN VALUES(@EMPLOYEE_ID,@FIRST_NAME,@LAST_NAME,@EMAIL_ID,@PASS,@USER_GUID,0,CURRENT_TIMESTAMP,NULL,NULL) ;
			IF @@ROWCOUNT = 1
				RETURN 1;
			ELSE
				RETURN 0;
		END
END 


-- procedure to validate user login

IF ( OBJECT_ID('SP_ADD_NEW_USER') IS NOT NULL ) 
   DROP PROCEDURE SP_ADD_NEW_USER
GO

CREATE PROCEDURE SP_ADD_NEW_USER
       @EMPLOYEE_ID VARCHAR(255),
       @FIRST_NAME VARCHAR(255),
       @LAST_NAME VARCHAR(255),
       @EMAIL_ID VARCHAR(255),
       @PASS VARCHAR(255),
       @USER_GUID UNIQUEIDENTIFIER
       
AS
BEGIN 
	DECLARE 
	@COUNT NUMERIC
	
-- Check if user already exists
	
	SELECT @COUNT = COUNT(EMPLOYEE_ID) FROM USER_LOGIN WHERE EMPLOYEE_ID = @EMPLOYEE_ID;
	
		-- if employee id already exists return -1
		IF @COUNT = 1
		RETURN -1;
		ELSE
		BEGIN
			INSERT INTO USER_LOGIN VALUES(@EMPLOYEE_ID,@FIRST_NAME,@LAST_NAME,@EMAIL_ID,@PASS,@USER_GUID,0,CURRENT_TIMESTAMP,NULL,NULL) ;
			IF @@ROWCOUNT = 1
				RETURN 1;
			ELSE
				RETURN 0;
		END
END 


select * from user_login