drop table user;

CREATE TABLE User (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL unique,
    password VARCHAR(255) NOT NULL,
    passwordConfirm VARCHAR(255),
    phoneNum VARCHAR(255),
    birthday DATE,
    zipCode VARCHAR(255),
    streetAddress VARCHAR(255),
    detailAddress VARCHAR(255),
    point INT,
    status INT,
    email VARCHAR(255),
    role  VARCHAR(255),                            
    provider VARCHAR(255),
    providerId VARCHAR(255),
    createDate TIMESTAMP
);

alter table user add constraint uq_username unique(username);