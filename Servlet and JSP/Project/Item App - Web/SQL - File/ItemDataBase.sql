DROP TABLE item_details CASCADE CONSTRAINTS;
DROP TABLE item CASCADE CONSTRAINTS;
DROP TABLE users CASCADE CONSTRAINTS;

DROP SEQUENCE item_seq;
DROP SEQUENCE users_seq;


CREATE SEQUENCE item_seq
	START WITH 1
	INCREMENT BY 1
	NOCACHE
	NOORDER;

CREATE TABLE item (
    id           NUMBER PRIMARY KEY NOT NULL,
    name         VARCHAR2(100) NOT NULL UNIQUE,
    price        NUMBER(10,2) NOT NULL CHECK (price > 0),
    total_number NUMBER NOT NULL CHECK (total_number >= 0),
    
    /*
     CONSTRAINT chk_item_name_length
     		CHECK (LENGTH(TRIM(name)) BETWEEN 1 AND 100)
     */
    
    CHECK (LENGTH(TRIM(name)) BETWEEN 1 AND 100)
);


CREATE TABLE item_details (
    item_id      NUMBER PRIMARY KEY,
    description  VARCHAR2(500),
    manufacturer VARCHAR2(100),
    CONSTRAINT fk_item_details_item
        FOREIGN KEY (item_id)
        REFERENCES item(id)
        ON DELETE CASCADE
);


CREATE OR REPLACE TRIGGER trg_item_id
	BEFORE INSERT ON item
	FOR EACH ROW
	WHEN (NEW.id IS NULL)
	BEGIN
	    :NEW.id := item_seq.NEXTVAL;
	END;
/

INSERT INTO item (name, price, total_number) VALUES ('Laptop', 15000, 10);
INSERT INTO item (name, price, total_number) VALUES ('Smartphone', 8000, 25);
INSERT INTO item (name, price, total_number) VALUES ('Headphones', 500, 50);
INSERT INTO item (name, price, total_number) VALUES ('Keyboard', 300, 40);
INSERT INTO item (name, price, total_number) VALUES ('Mouse', 150, 60);
INSERT INTO item (name, price, total_number) VALUES ('Monitor', 2500, 15);
INSERT INTO item (name, price, total_number) VALUES ('Printer', 2000, 8);
INSERT INTO item (name, price, total_number) VALUES ('Tablet', 6000, 12);
INSERT INTO item (name, price, total_number) VALUES ('USB Flash Drive', 100, 100);
INSERT INTO item (name, price, total_number) VALUES ('External Hard Drive', 1200, 20);
INSERT INTO item (name, price, total_number) VALUES ('Webcam', 800, 35);
INSERT INTO item (name, price, total_number) VALUES ('Speaker', 950, 20);
INSERT INTO item (name, price, total_number) VALUES ('Microphone', 1100, 18);
INSERT INTO item (name, price, total_number) VALUES ('Gaming Chair', 3500, 7);
INSERT INTO item (name, price, total_number) VALUES ('Desk Lamp', 200, 45);
INSERT INTO item (name, price, total_number) VALUES ('SSD Drive', 1800, 30);
INSERT INTO item (name, price, total_number) VALUES ('RAM Module', 700, 55);
INSERT INTO item (name, price, total_number) VALUES ('Graphics Card', 12000, 5);
INSERT INTO item (name, price, total_number) VALUES ('Power Bank', 450, 80);
INSERT INTO item (name, price, total_number) VALUES ('Smart Watch', 5000, 22);

INSERT INTO item_details (item_id, description, manufacturer) VALUES (1, 'Gaming Laptop', 'Dell');
INSERT INTO item_details (item_id, description, manufacturer) VALUES (2, 'Android Smartphone', 'Samsung');
INSERT INTO item_details (item_id, description, manufacturer) VALUES (3, 'Wireless Headphones', 'Sony');


SELECT * FROM item ORDER BY id ASC;
SELECT * FROM item_details;

SELECT
    i.id,
    i.name,
    i.price,
    d.description,
    d.manufacturer
FROM item i
JOIN item_details d ON i.id = d.item_id;








-- User Data 

CREATE TABLE users (
    id           NUMBER PRIMARY KEY,
    first_name   VARCHAR2(50) NOT NULL,
    last_name    VARCHAR2(50) NOT NULL,
    username     VARCHAR2(50) NOT NULL UNIQUE,
    email        VARCHAR2(100) NOT NULL UNIQUE,
    phone        VARCHAR2(20) NOT NULL ,
    password     VARCHAR2(255) NOT NULL,
    created_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE SEQUENCE users_seq
	START WITH 1
	INCREMENT BY 1
	NOCACHE
	NOORDER;

CREATE OR REPLACE TRIGGER trg_users_id
	BEFORE INSERT ON users
	FOR EACH ROW
	WHEN (NEW.id IS NULL)
	BEGIN
	    :NEW.id := users_seq.NEXTVAL;
	END;
/







