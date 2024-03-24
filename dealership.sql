-- Create Customer table
CREATE TABLE IF NOT EXISTS Customer (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    cust_email VARCHAR(30)NOT NULL UNIQUE,
    address_id INTEGER
);

-- Create Address table
CREATE TABLE IF NOT EXISTS Address (
    address_id SERIAL PRIMARY KEY NOT NULL,
    address VARCHAR(30) NOT NULL,
    address_2 VARCHAR(30),
    city VARCHAR(15) NOT NULL,
    state VARCHAR(15) NOT NULL,
    zip_code INTEGER NOT NULL,
    country VARCHAR(20) NOT NULL,
    last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);



-- Create Employee table
CREATE TABLE IF NOT EXISTS Employee (
    employee_id SERIAL PRIMARY KEY,
    emp_first_name VARCHAR(20) NOT NULL,
    emp_last_name VARCHAR(20) NOT NULL,
    emp_email VARCHAR(30) NOT NULL UNIQUE,
    phone_number VARCHAR(20),
    role VARCHAR(30) NOT NULL,
    salary INTEGER,
    year_started TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    department VARCHAR(20) NOT NULL,
    address_id INTEGER
);


-- Create Invoice table
CREATE TABLE IF NOT EXISTS Invoice (
    invoice_id SERIAL PRIMARY KEY,
    purchase_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    description VARCHAR(250) NOT NULL,
    employee_id INTEGER,
    customer_id INTEGER,
    car_id INTEGER,
    service_id INTEGER,
    quantity INTEGER,
    total_price NUMERIC
);

-- Create Car table
CREATE TABLE IF NOT EXISTS Car (
    car_id SERIAL PRIMARY KEY,
    unit_price NUMERIC,
    model VARCHAR(15),
    color VARCHAR(15),
    make VARCHAR(15),
    year INTEGER,
    new BOOL,
    used BOOL,
    warranty_id INTEGER,
    warranty_active BOOL
);

-- Create Service table
CREATE TABLE IF NOT EXISTS Service (
    service_id SERIAL PRIMARY KEY,
    car_id INTEGER,
    service BOOL,
    employee_id INTEGER,
    repair BOOL,
    warranty_covered BOOL,
    part_replacement BOOL,
    service_description VARCHAR(250)
);

-- Create Payment table
CREATE TABLE IF NOT EXISTS Payment (
    payment_id SERIAL PRIMARY KEY,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    amount NUMERIC NOT NULL,
    payment_method VARCHAR(20),
    transaction_id INTEGER,
    refund_status VARCHAR(20),
    invoice_id INTEGER
);


-- Alter Customer table to add foreign key constraint
ALTER TABLE Customer
ADD CONSTRAINT fk_customer_address
FOREIGN KEY (address_id) REFERENCES Address(address_id);

-- Alter Employee table to add foreign key constraint
ALTER TABLE Employee
ADD CONSTRAINT fk_employee_address
FOREIGN KEY (address_id) REFERENCES Address(address_id);

-- Alter Invoice table to add foreign key constraints
ALTER TABLE Invoice
ADD CONSTRAINT fk_invoice_employee
FOREIGN KEY (employee_id) REFERENCES Employee(employee_id),
ADD CONSTRAINT fk_invoice_customer
FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
ADD CONSTRAINT fk_invoice_car
FOREIGN KEY (car_id) REFERENCES Car(car_id),
ADD CONSTRAINT fk_invoice_service
FOREIGN KEY (service_id) REFERENCES Service(service_id);


-- Alter Payment table to add foreign key constraint 
ALTER TABLE payment
ADD CONSTRAINT fk_payment_invoice
FOREIGN KEY (invoice_id) REFERENCES Invoice(invoice_id);


-- Alter Service table to add foreign key constraints
ALTER TABLE Service
ADD CONSTRAINT fk_service_car
FOREIGN KEY (car_id) REFERENCES Car(car_id),
ADD CONSTRAINT fk_service_employee
FOREIGN KEY (employee_id) REFERENCES Employee(employee_id);

-- Inserting data into the Address table
INSERT INTO Address (address, city, state, zip_code, country)
VALUES ('789 Second St', 'Anytown', 'NY', 12795, 'USA'),
       ('739 Oak St', 'Sometown', 'CA', 67321, 'USA');


-- Inserting data into the Customer table
INSERT INTO Customer (first_name, last_name, phone_number, cust_email, address_id)
VALUES ('Max', 'Doger', '654-456-7890', 'maxn@example.com',1),
       ('Betsa', 'Brizu', '834-654-3210', 'betsa@example.com',2);


-- Inserting data into the Employee table
INSERT INTO Employee (emp_first_name, emp_last_name, emp_email, phone_number, role, salary, year_started, department)
VALUES ('Michael', 'Johnson', 'michael@example.com', '555-123-4567', 'Salesperson', 50000, '2020-01-01'::TIMESTAMP, 'Sales'),
       ('Emily', 'Brown', 'emily@example.com', '555-987-6543', 'Mechanic', 45000, '2020-02-01'::TIMESTAMP, 'Service');

-- Inserting data into the Invoice table (using function)
CREATE OR REPLACE FUNCTION InsertInvoice(description VARCHAR, employee_id INT, customer_id INT, car_id INT, quantity INT, total_price NUMERIC)
RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO Invoice (description, employee_id, customer_id, car_id, quantity, total_price)
    VALUES (description, employee_id, customer_id, car_id, quantity, total_price);
END;
$$;

SELECT InsertInvoice('First car', 2, 3, 1, 1, 45000.00);

-- Inserting data into the Car table
INSERT INTO Car (unit_price, model, color, make, year, new, used, warranty_id, warranty_active)
VALUES (25000.00, 'Civic', 'Black', 'Honda', 2023, TRUE, FALSE, NULL, FALSE),
       (18000.00, 'Corolla', 'White', 'Toyota', 2022, TRUE, FALSE, NULL, FALSE);

-- Inserting data into the Service table
INSERT INTO Service (car_id, service, employee_id, repair, warranty_covered, part_replacement, service_description)
VALUES (1, TRUE, 2, FALSE, FALSE, FALSE, 'Oil Change'),
       (2, TRUE, 2, FALSE, FALSE, TRUE, 'Brake Replacement');

-- Inserting data into the Payment table
INSERT INTO Payment (payment_date, amount, payment_method, transaction_id, refund_status)
VALUES ('2024-03-21'::TIMESTAMP, 25000.00, 'Credit Card', 12345, 'Pending'),
       ('2024-03-22'::TIMESTAMP, 18000.00, 'Debit Card', 54321, 'Pending');
      

INSERT INTO Invoice (description, employee_id, customer_id, car_id, quantity, total_price)
VALUES ('Second car', 1, 4, 2, 1, 35000.00);
      
      


INSERT INTO Customer (first_name, last_name, phone_number, cust_email, address_id)
VALUES ('Carolina', 'Santaella', '789-456-7888', 'caro@example.com'),
       ('Karla', 'Maxwell', '765-654-3299', 'keee@example.com');

      
INSERT INTO payment (amount, payment_method, transaction_id, invoice_id)
VALUES (45000, 'credit card', 1, 1),
	   (35000, 'debit card',2,2);
	  
	  
-- Inserting data into the Address table (using stored procedure)	  
	  
CREATE OR REPLACE PROCEDURE insert_address(address VARCHAR, city VARCHAR, state VARCHAR, zip_code INT, country VARCHAR)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO address(address, city, state, zip_code, country)
    VALUES (address, city, state, zip_code, country);
END;
$$;

CALL insert_address('788 Lincoln St', 'Sometown', 'IL', 60321, 'USA');

-- Inserting data into the Employee table (using stored procedure)	  
	  
CREATE OR REPLACE PROCEDURE insert_employee(emp_first_name VARCHAR, emp_last_name VARCHAR, emp_email VARCHAR, phone_number VARCHAR, role VARCHAR, salary INT, department VARCHAR, year_started TIMESTAMP)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO employee(emp_first_name, emp_last_name, emp_email, phone_number, role, salary, department, year_started)
	VALUES (emp_first_name, emp_last_name, emp_email, phone_number, role, salary, department, year_started);
END;
$$;

CALL insert_employee('Nataly', 'Smith', 'nata@example.com', '555-667-4567', 'Salesperson', 50000, 'Sales', '2022-03-01'::TIMESTAMP);
CALL insert_employee('Sergio', 'Araujo', 'betty@example.com', '675-987-9043', 'Mechanic', 45000, 'Service','2019-07-20'::TIMESTAMP);

SELECT *
FROM car;
