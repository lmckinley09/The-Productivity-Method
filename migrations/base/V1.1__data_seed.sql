DO $$

DECLARE USER_ID integer;
DECLARE BOARD_ID integer;
DECLARE TASK_JOB_ID integer;
DECLARE PROJECT_JOB_ID integer;

BEGIN

INSERT INTO app_user
(email, first_name, last_name, password, profile_picture, created, last_modified)
VALUES('lorna@email.com', 'Lorna', 'Mckinley', 'password','default_profile.png', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP) RETURNING id INTO USER_ID;
INSERT INTO app_user
(email, first_name, last_name, password, profile_picture, created, last_modified)
VALUES('jane@email.com', 'Jane', 'Mckinley', 'password','default_profile.png', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO access_type
(description)
VALUES('owner');
INSERT INTO access_type
(description)
VALUES('viewer');
INSERT INTO access_type
(description)
VALUES('editer');

INSERT INTO job_type
(description)
VALUES('tick');
INSERT INTO job_type
(description)
VALUES('task');
INSERT INTO job_type
(description)
VALUES('project');

INSERT INTO board
("name", created, last_modified)
VALUES('Lorna''s Board', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP) RETURNING id INTO BOARD_ID;

INSERT INTO user_board_access
(user_id, board_id, type_id)
VALUES( USER_ID, BOARD_ID,(select id from access_type where description = 'owner'));

INSERT INTO job
(board_id, title, description, status, completion_date, type_id, created, last_modified)
VALUES(
  BOARD_ID, 'Lorna''s First Task', '', 'Not Started',CURRENT_DATE, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
  RETURNING id INTO TASK_JOB_ID;

INSERT INTO job
  (board_id, title, description, status, completion_date, type_id, created, last_modified)
  VALUES(
    BOARD_ID, 'Lorna''s First Project', '', 'Not Started',CURRENT_DATE, 3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
    RETURNING id INTO PROJECT_JOB_ID;

INSERT INTO project_job
   (project_id,job_id)
   VALUES(PROJECT_JOB_ID,TASK_JOB_ID);

 END $$;
