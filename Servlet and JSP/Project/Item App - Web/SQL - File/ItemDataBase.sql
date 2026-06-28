DROP TABLE item CASCADE CONSTRAINTS;
DROP SEQUENCE item_seq;

CREATE SEQUENCE item_seq
START WITH 1
INCREMENT BY 1;

CREATE TABLE item (
    id NUMBER PRIMARY KEY NOT NULL,

    name VARCHAR2(100) NOT NULL UNIQUE,
    
    price NUMBER(10,2) NOT NULL
        CHECK (price > 0),

    total_number NUMBER NOT NULL
        CHECK (total_number >= 0),

    CHECK (LENGTH(TRIM(name)) BETWEEN 1 AND 100)
);

CREATE OR REPLACE TRIGGER trg_item_id
BEFORE INSERT ON item
	FOR EACH ROW
	WHEN (NEW.id IS NULL)
	BEGIN
	    :NEW.id := item_seq.NEXTVAL;
	END;

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

SELECT * FROM item;




SELECT MAX(id) FROM item;







