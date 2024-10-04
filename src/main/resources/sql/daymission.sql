CREATE TABLE daymission (
    username VARCHAR(255),
    actNo_list VARCHAR(255),
    edate DATE,
    FOREIGN KEY (username) REFERENCES user(username)
);