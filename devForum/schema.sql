DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS question;
DROP TABLE IF EXISTS reply;
DROP TABLE IF EXISTS social;

CREATE TABLE user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT UNIQUE NOT NULL,
    password TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL
);

CREATE TABLE question(
    q_id INTEGER PRIMARY KEY AUTOINCREMENT,
    author_id INTEGER NOT NULL,
    created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    title TEXT NOT NULL,
    body TEXT NOT NULL,
    FOREIGN KEY (author_id) REFERENCES user (id)
);

CREATE TABLE reply(
    r_id  INTEGER PRIMARY KEY AUTOINCREMENT,
    parent_id INTEGER NOT NULL,
    created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    body TEXT NOT NULL,
    vote INTEGER NOT NULL DEFAULT 0,
    FOREIGN KEY (parent_id) REFERENCES question (q_id)
);

CREATE TABLE social(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    person_id INTEGER NOT NULL,
    following_id INTEGER NOT NULL,
    FOREIGN KEY (person_id) REFERENCES user (id),
    FOREIGN KEY (following_id) REFERENCES user (id) 
);