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
    total_price NUMERIC,
    payment_id INTEGER
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
    refund_status VARCHAR(20)
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
FOREIGN KEY (service_id) REFERENCES Service(service_id),
ADD CONSTRAINT fk_invoice_payment
FOREIGN KEY (payment_id) REFERENCES Payment(payment_id);

-- Alter Service table to add foreign key constraints
ALTER TABLE Service
ADD CONSTRAINT fk_service_car
FOREIGN KEY (car_id) REFERENCES Car(car_id),
ADD CONSTRAINT fk_service_employee
FOREIGN KEY (employee_id) REFERENCES Employee(employee_id);


