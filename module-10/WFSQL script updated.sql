
-- drop tables if they are present
DROP TABLE IF EXISTS clients;
DROP TABLE IF EXISTS bills;
DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS accounts;
DROP TABLE IF EXISTS services;
DROP TABLE IF EXISTS assets;

CREATE TABLE asset_types (
    asset_type_id INT NOT NULL AUTO_INCREMENT,
    asset_type VARCHAR(75) NOT NULL,
    PRIMARY KEY (asset_type_id)
    )

CREATE TABLE account_types (
    account_type_id INT NOT NULL AUTO_INCREMENT,
    account_type VARCHAR(75) NOT NULL,
    PRIMARY KEY (account_type_id)
    )

CREATE TABLE service_types (
    service_type_id INT NOT NULL AUTO_INCREMENT,
    service_type VARCHAR(75) NOT NULL,
    PRIMARY KEY (service_type_id)
    )

CREATE TABLE transaction_types (
    transaction_type_id INT NOT NULL AUTO_INCREMENT,
    transaction_type VARCHAR(75) NOT NULL,
    PRIMARY KEY (transaction_type_id)
    )

-- create the clients table 
CREATE TABLE clients (
    clients_id     INT             NOT NULL        AUTO_INCREMENT,
    clients_first_name   VARCHAR(75)     NOT NULL,
    clients_last_name VARCHAR(75) NOT NULL,
    clients_phone VARCHAR(75) NOT NULL,
    clients_email VARCHAR(75) NOT NULL,
    registration_date DATE NOT NULL,
    PRIMARY KEY (clients_id)
); 

-- create the accounts table 
CREATE TABLE accounts (
    accounts_id INT NOT NULL AUTO_INCREMENT,
    account_type_id INT NOT NULL,
    clients_id INT NOT NULL,
    PRIMARY KEY (accounts_id),
    FOREIGN KEY (clients_id) REFERENCES clients(clients_id),
    FOREIGN KEY (account_type_id) REFERENCES account_types(account_type_id)
); 

-- Create services table
CREATE TABLE services (
    services_id INT NOT NULL AUTO_INCREMENT,
    service_type_id INT NOT NULL,
    services_price INT NOT NULL,
    PRIMARY KEY (services_id),
    FOREIGN KEY (service_type_id) REFERENCES service_types(service_type_id)
);

-- create bills table
CREATE TABLE bills (
    bills_id INT NOT NULL AUTO_INCREMENT,
    bills_amount INT NOT NULL,
    bills_date DATE NOT NULL,
    services_id INT NOT NULL,
    clients_id INT NOT NULL,
    PRIMARY KEY (bills_id),
    FOREIGN KEY (clients_id) REFERENCES clients(clients_id),
    FOREIGN KEY (services_id) REFERENCES services(services_id)
);

--create assets table
CREATE TABLE assets (
    assets_id INT NOT NULL AUTO_INCREMENT,
    asset_type_id INT NOT NULL,
    assets_worth INT NOT NULL,
    assets_desc VARCHAR(255) NOT NULL,
    clients_id INT NOT NULL,
    PRIMARY KEY (assets_id),
    FOREIGN KEY (clients_id) REFERENCES clients(clients_id),
    FOREIGN KEY (asset_type_id) REFERENCES asset_types(asset_type_id)
    );

-- create transactions table
CREATE TABLE transactions (
        transaction_id INT NOT NULL AUTO_INCREMENT,
        transaction_type_id INT NOT NULL,
        transaction_amount INT NOT NULL,
        transaction_date DATE NOT NULL,
        account_id INT NOT NULL,
        PRIMARY KEY (transaction_id),
        FOREIGN KEY (account_id) REFERENCES accounts(accounts_id),
        FOREIGN KEY (transaction_type_id) REFERENCES transaction_types(transaction_type_id)

    );

INSERT INTO account_types (account_type) VALUES
    ('Traditional Savings'),
    ('Checking'),
    ('Business'),
    ('Health Savings'),
    ('Retirement Fund'),
    ('Education Fund'),

INSERT INTO service_types(service_type) VALUES
    ('Consultation'),
    ('Financial Planning'),
    ('Investment Advisory'),
    ('Insurance'),
    ('Tax Preparation'),
    ('Loan Services');

INSERT INTO transaction_types ( transaction_type) VALUES
    ('Deposit'),
    ('Withdrawal'),
    ('Transfer');

-- insert values into clients
INSERT INTO clients (clients_first_name, clients_last_name, clients_phone, clients_email, registration_date) VALUES
    ('Olivia', 'Anderson', '555-2783', 'oliviaanderson23@gmail.com', '2023-05-12'),
    ('Liam', 'Carter', '555-9147', 'liamcarter39@gmail.com', '2022-03-18'),
    ('Ethan', 'Thompson', '937-5555', 'ethanthompson@gmail.com', '2021-07-12'),
    ('Sarah', 'Evans', '843-5555', 'sarahevans42@gmail.com', '2023-06-10'),
    ('Brandon', 'Washington', '555-2604', 'brandonwashington555@gmail.com', '2021-04-30'),
    ('Tina', 'Scott', '555-6502', 'tinascott42@gmail.com', '2023-02-02');

-- insert values into accounts
INSERT INTO accounts(account_type_id, clients_id)
    VALUES
    (1, 1),
    (2, 1),
    (3, 2),
    (2, 2),
    (3, 3),
    (4, 3),
    (4, 4),
    (5, 4),
    (5, 5),
    (6, 5),
    (6, 6)

-- insert values into services
INSERT INTO services (service_type_id, services_price)
    VALUES
    (1, 150),
    (2, 300),
    (3, 250),
    (4, 180),
    (5, 200),
    (6, 500);

-- insert values into assets
INSERT INTO assets (asset_type_id, assets_worth, assets_desc, clients_id)
    VALUES
    (1, 500000, '4-bedroom house in suburb', 1),
    (2, 25000, '2018 Honda Accord', 2),
    (3, 1000000, 'Small manufacturing business', 3),
    (4, 800000, 'Commercial building', 4),
    (5, 150000, 'Portfolio of stocks', 5),
    (6, 200000, '5 acres of agricultural land', 6);

--insert values into bills
INSERT INTO bills (bills_amount, bills_date, services_id, clients_id)
    VALUES
    (150, '2023-06-01', 1, 1),
    (300, '2023-07-15', 2, 2),
    (250, '2023-08-10', 3, 3),
    (180, '2023-06-20', 4, 4),
    (200, '2023-07-20', 5, 5),
    (500, '2023-08-15', 1, 2),
    (150, '2022-07-07', 1, 2),
    (250, '2021-09-05', 3, 5),
    (250, '2023-07-06', 3, 1),
    (300, '2022-01-08', 2, 3), 
    (180, '2023-06-20', 4, 6),
    (150, '2023-08-10', 1, 6),
    (500, '2022-06-20', 6, 2),
    (500, '2021-05-10', 6, 5),
    (200, '2022-07-07', 5, 2);

--insert values into transactions
INSERT INTO transactions (transaction_type_id, transaction_amount, transaction_date, account_id)
    VALUES
    (1, 2000, '2023-06-01', 1),
    (2, 500, '2023-07-10', 2),
    (3, 1000, '2023-08-01', 3),
    (1, 1200, '2024-01-10', 4),
    (2, 300, '2023-12-15', 5),
    (1, 1500, '2023-11-25', 6),
    (1, 1000, '2023-06-05', 1),
    (2, 150, '2023-06-06', 1),
    (1, 500, '2023-06-07', 1),
    (3, 200, '2023-06-08', 1),
    (1, 1000, '2023-06-10', 1),
    (2, 200, '2023-06-12', 1),
    (3, 150, '2023-06-14', 1),
    (1, 1200, '2023-06-16', 1),
    (3, 500, '2023-06-18', 1),
    (1, 700, '2023-06-20', 1),
    (2, 300, '2023-06-22', 1),
    (3, 800, '2023-06-25', 1),
    (1, 1500, '2023-06-27', 1),
    (2, 600, '2023-06-29', 1),
    (1, 1200, '2023-07-05', 1),
    (2, 250, '2023-07-07', 1),
    (3, 300, '2023-07-10', 1),
    (1, 700, '2023-07-12', 1),
    (2, 100, '2023-07-14', 1),
    (3, 250, '2023-07-16', 1),
    (1, 1500, '2023-07-18', 1),
    (2, 400, '2023-07-20', 1),
    (3, 600, '2023-07-22', 1),
    (1, 500, '2023-07-25', 1),
    (2, 100, '2023-07-27', 1),
    (3, 400, '2023-07-29', 1),
    (1, 1000, '2023-08-01', 1),
    (2, 150, '2023-08-02', 1),
    (3, 200, '2023-08-03', 1),
    (1, 1200, '2023-08-04', 1),
    (2, 300, '2023-08-06', 1),
    (3, 500, '2023-08-07', 1),
    (1, 1500, '2023-08-08', 1),
    (2, 200, '2023-08-10', 1),
    (3, 1000, '2023-08-12', 1),
    (1, 800, '2023-08-14', 1),
    (2, 600, '2023-08-16', 1),
    (3, 250, '2023-08-18', 1),
    (1, 2000, '2023-06-01', 2),
    (2, 500, '2023-06-02', 2),
    (1, 1000, '2023-06-03', 2),
    (3, 500, '2023-06-05', 2),
    (1, 1200, '2023-06-07', 2),
    (2, 200, '2023-06-08', 2),
    (3, 250, '2023-06-10', 2),
    (1, 700, '2023-06-11', 2),
    (2, 100, '2023-06-12', 2),
    (3, 500, '2023-06-13', 2),
    (1, 800, '2023-06-15', 2),
    (2, 300, '2023-06-17', 2),
    (3, 600, '2023-06-18', 2),
    (1, 1500, '2023-06-20', 2),
    (1, 1000, '2023-07-02', 2),
    (2, 200, '2023-07-04', 2),
    (3, 300, '2023-07-06', 2),
    (1, 1200, '2023-07-08', 2),
    (2, 500, '2023-07-10', 2),
    (3, 400, '2023-07-12', 2),
    (1, 700, '2023-07-13', 2),
    (2, 100, '2023-07-14', 2),
    (3, 600, '2023-07-16', 2),
    (1, 1500, '2023-07-18', 2),
    (2, 200, '2023-07-20', 2),
    (3, 500, '2023-07-22', 2),
    (1, 1500, '2021-06-03', 3),
    (2, 300, '2021-06-05', 3),
    (3, 200, '2021-06-06', 3),
    (1, 1200, '2021-06-07', 3),
    (2, 150, '2021-06-08', 3),
    (3, 250, '2022-06-09', 3),
    (1, 800, '2022-06-10', 3),
    (2, 100, '2022-06-11', 3),
    (3, 500, '2022-06-12', 3),
    (1, 1500, '2022-06-14', 3),
    (2, 300, '2023-06-15', 3),
    (3, 400, '2023-06-17', 3),
    (1, 1200, '2023-06-19', 3),
    (2, 250, '2023-06-21', 3),
    (1, 1000, '2023-07-02', 3),
    (2, 300, '2023-07-04', 3),
    (3, 500, '2023-07-06', 3),
    (1, 1200, '2023-07-08', 3),
    (2, 150, '2023-07-09', 3),
    (3, 600, '2023-07-10', 3),
    (1, 700, '2023-07-12', 3),
    (2, 100, '2023-07-14', 3),
    (3, 500, '2023-07-16', 3),
    (1, 1500, '2023-07-18', 3),
    (2, 200, '2023-07-20', 3),
    (3, 400, '2023-07-22', 3);