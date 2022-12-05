CREATE TABLE app_user (
    id serial PRIMARY KEY,
    email_address varchar NOT NULL,
    first_name varchar NOT NULL,
    last_name varchar NOT NULL,
    password varchar NOT NULL,
    date_of_birth timestamp,
    created timestamp DEFAULT CURRENT_TIMESTAMP,
    last_modified timestamp DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE type (
    id serial PRIMARY KEY,
    description varchar NOT NULL
);

CREATE TABLE board (
    id serial PRIMARY KEY,
    name varchar NOT NULL,
    created timestamp DEFAULT CURRENT_TIMESTAMP,
    last_modified timestamp DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE user_board (
    id serial PRIMARY KEY,
    app_user integer,
    board integer,
    CONSTRAINT fk_user FOREIGN KEY (app_user)
        REFERENCES app_user(id),
    CONSTRAINT fk_board FOREIGN KEY (board)
        REFERENCES board(id)
);
CREATE TABLE user_board_type (
    user_board integer,
    type integer,
    CONSTRAINT fk_user_board FOREIGN KEY (user_board)
        REFERENCES user_board(id),
    CONSTRAINT fk_type FOREIGN KEY (type)
        REFERENCES type(id)
);

CREATE TABLE job (
    id serial PRIMARY KEY,
    board integer,
    title varchar NOT NULL,
    description varchar,
    status varchar,
    completion_date date,
    created timestamp DEFAULT CURRENT_TIMESTAMP,
    last_modified timestamp DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_board FOREIGN KEY (board)
        REFERENCES board(id)
);

CREATE TABLE project (
    id serial PRIMARY KEY,
    job integer,
    CONSTRAINT fk_job FOREIGN KEY (job)
        REFERENCES job(id)
);

CREATE TABLE tick (
    id serial PRIMARY KEY,
    job integer,
    CONSTRAINT fk_job FOREIGN KEY (job)
        REFERENCES job(id)
);

CREATE TABLE task (
    id serial PRIMARY KEY,
    job integer,
    project integer,
    CONSTRAINT fk_job FOREIGN KEY (job)
        REFERENCES job(id),
    CONSTRAINT fk_project FOREIGN KEY (project)
        REFERENCES project(id)
);
