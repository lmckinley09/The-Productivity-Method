# The Productivity Method

## What is the application?

A digital interpretation of the Productivity Method by Grace Beverley. This productivity app will allow the user to track jobs to do under the 3 main categories.

- Quick Ticks => 5 minutes or less
- Tasks => 5-30 minutes
- Projects => collection of tasks 

By breaking up tasks onto a visual board rather than a single list, which can be daunting, this reduces the pressure to follow tasks in order and can allow for grouping or potentially sharing boards among other users. The user can choose to select 3 non-negotiable tasks they aim to complete in the day.

## Why

The aim is to provide accountabilty to users, with a variation on task management they may be familiar in other applications. Organising work into categories and prioritising work can aid in reducing the stress of users.

## MVP

- User account creation/login
- Create Ticks/Tasks/Projects
- Track status of tasks
- Users can share/view other users boards
- Filter tasks by project
- Simple view with 3 ticks/tasks to complete (updates on completion of task)

## Stretch Goals

- Progress Bar
- Read/Write permissions for shared boards
- Mind Mapping (Mermaid js experimental)
- View completed (inactive) tasks

## Domain Model

```mermaid
erDiagram
 USER ||--o{ BOARD : ""
 BOARD ||--o{ TICKS : ""
 BOARD ||--o{ TASKS : ""
 BOARD ||--o{ PROJECTS : ""
 PROJECTS ||--o{ TASKS : ""
```

# Entity Relationship Diagram
```mermaid
erDiagram
 user ||--o{ user_board_access : ""
 access_type ||--o{ user_board_access : ""
 board ||--o{ user_board_access : ""
 board ||--o{ job : ""
 job ||--|| job_type : ""
 job ||--o{ project_job : ""

    user {
        serial id PK
        varchar email
        varchar first_name
        varchar last_name
        varchar password
        timestamp created
        timestamp last_modified
    }
    
    access_type {
        serial id PK
        varchar description 
    }
    
    user_board_access {
        serial id PK
        integer user_id FK
        integer board_id FK
        integer type_id FK
    }
        
    board {
        serial id PK
        varchar name
        timestamp created
        timestamp last_modified
    }
    
    job_type {
        serial id PK
        varchar type_description 
    }
    
    job {
        serial id PK
        integer board_id FK
        integer type_id FK
        varchar title
        varchar description
        varchar status
        date completion_date
        timestamp created
        timestamp last_modified
    }
    
     project_job {
        serial id PK
        integer project_id FK
        integer job_id FK
    }

```
# API Specification

#### USERS
`GET /users`
Return a list of all users

Response 200
```json
[
  {
    "id": 1,
    "email": "lorna@lorna.com",
    "first_name": "Lorna",
    "last_name": "McKinley",
    "created": "2022-12-12 14:29:20.012024",
    "last_modified": "2022-12-12 14:29:20.012024"
  },
  {
    "id": 2,
    "email": "jane@jane.com",
    "first_name": "Jane",
    "last_name": "McKinley",
    "created": "2022-12-14 14:29:20.012024",
    "last_modified": "2022-12-14 14:29:20.012024"
  }
]
```

---

`GET /users/{user_id}`
Return a user

Response 200
```json
  {
    "id": 1,
    "email": "lorna@lorna.com",
    "first_name": "Lorna",
    "last_name": "McKinley",
    "created": "2022-12-12 14:29:20.012024",
    "last_modified": "2022-12-12 14:29:20.012024"
  }
```

---

`POST /users`
Create a user

Request
```json
{
  "email": "pat@pat.com",
    "first_name": "Patrick",
    "last_name": "Tazz",
    "password": "password3",
    "created": "2022-12-18 14:29:20.012024",
    "last_modified": "2022-12-18 14:29:20.012024"
}
```
Response - `201 Created`

---

`PATCH /users/{user_id}`
Update a user by id

Request
```json
{
"password": "password2"
}
```
Response - `200 OK`

---

`DELETE /users/{user_id}`
Delete a user by id

Response - `204 No Content`

---

#### BOARDS
`GET /boards/user/{user_id}`
Return all boards for a user

Response 200
```json
[
  {
    "id": 5,
    "name": "Lorna's Board",
    "last_modified": "2022-11-12 14:29:20.012024"
  },
 {
    "id": 6,
    "name": "Christmas Party",
    "last_modified": "2022-12-12 14:29:20.012024"
  }
]
```

---

`GET /boards/{board_id}`
Return a board by id

Response 200
```json
{
"board":{
  "id": 5,
  "name": "Lorna's Board",
  "owner_id": 1
  "created": "2022-12-12 14:29:20.012024",
  "last_modified": "2022-11-12 14:29:20.012024",
  "ticks": [
    {
    "id": 123,
    "title": "aTitle",
    "description": "aDescription"
    },
     {
    "id": 126,
    "title": "aTitle2",
    "description": "aDescription2"
    }
  ],
  "tasks": [
    {
    "id": 124,
    "title": "aTitle3",
    "description": "aDescription3"
    }
  ],
  "projects": [
    {
    "id": 125,
    "title": "aTitle4",
    "description": "aDescription4"
    }
  ]
 }
}
```
---


`POST /boards`
Create a board

Request
```json
{
  "name": "Jane's Board",
}
```
Response - `201 Created`

---

`PATCH /boards/{board_id}`
Update a board by id

Request
```json
{
"name": "Halloween Party",
"last_modified": "2022-12-18 14:29:20.012024"
}
```
Response - `200 OK`

---

`DELETE /boards/{board_id}`
Delete a board by id

Response - `204 No Content`
