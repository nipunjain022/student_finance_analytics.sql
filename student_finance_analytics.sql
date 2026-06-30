-- Create the Programs Table
CREATE TABLE Programs (
	program_id INT PRIMARY KEY,
    name VARCHAR(250) NOT NULL,
    university VARCHAR(250) NOT NULL,
    target_intake VARCHAR(75)
);

-- Create the Modules Table
CREATE TABLE Modules(
	module_id INT PRIMARY KEY,
    program_id INT,
    module_name VARCHAR(200) NOT NULL,
    credits	INT NOT NULL,
    semester_num INT NOT NULL,
    FOREIGN KEY (program_id) REFERENCES Programs(program_id)
    );
     
-- Create the Expenses Table (Living costs in AUD)
CREATE TABLE Expenses(
	expense_id INT PRIMARY KEY,
    expense_date DATE NOT NULL,
    category VARCHAR(100) NOT NULL,
    amount_aud DECIMAL(10,2) NOT NULL,
    notes TEXT
    );

-- Create the Exchange Rates Table (AUD to INR)
CREATE TABLE Exchange_Rates(
	rate_date DATE PRIMARY KEY,
    aud_to_inr DECIMAL(10,2) NOT NULL
    );

-- Inserting the core degree program
INSERT INTO Programs (program_id, name, university, target_intake) VALUES 
(1, 'Master of Data Science and Innovation (MDSI)', 'University of Technology Sydney', 'July 2026');

-- Inserting the subjects linked to the MDSI program
INSERT INTO Modules(module_id, program_id, module_name, credits, semester_num) VALUES 
(101, 1, 'Statistical Thinking for Data Science', 6, 1),
(102, 1, 'Data Science for Innovation', 6, 1),
(103, 1, 'Machine Learning Algoritham', 6, 2),
(104, 1, 'Data Visualization and Narratives', 6, 2);

-- Inserting realistic Sydney living expenses in AUD
INSERT INTO Expenses(expense_id, expense_date, category, amount_aud, notes) VALUES
(1, '2026-07-15', 'Rent', 350.00, 'Weekly student accommdation rent'),
(2, '2026-07-16', 'Groceries', 85.50, 'Weekly pure veg groceries and high protien items'),
(3, '2026-07-17', 'Transport', 50.00, 'Opal card top-up'),
(4, '2026-07-18', 'Fitness', 22.00, 'Weekly gym membership'),
(5, '2026-07-19', 'Tech', 39.00, 'Monthly Mobile data plan');

-- Inserting the AUD to INR exchange rate for the matching dates
INSERT INTO Exchange_Rates(rate_date, aud_to_inr) VALUES
('2026-06-22', 66.18),
('2026-06-23', 65.46),
('2026-06-24', 65.26),
('2026-06-25', 65.08),
('2026-06-26', 65.00);

-- Query 1: The Currency Converter (Testing the Date-Join) 
SELECT e.expense_id, 
		e.expense_date, 
        e.category, e.amount_aud, 
        er.aud_to_inr, 
        ROUND(e.amount_aud * er.aud_to_inr,2) as amount_inr, e.notes
FROM Expenses e
JOIN Exchange_Rates er ON e.expense_date = er.rate_date;

-- Query 2: The Budget Summary (Aggregations)
SELECT e.category, 
		SUM(e.amount_aud) AS total_aud, 
		ROUND(SUM(e.amount_aud * er.aud_to_inr),2) as total_inr
FROM Expenses e
JOIN Exchange_Rates er ON e.expense_date = er.rate_date
GROUP BY e.category
ORDER BY total_inr DESC;

-- Query 3: Running Total / Cumulative Spend (The Intermediate/Advanced Test) 
SELECT e.expense_date, 
		e.category, 
        ROUND(e.amount_aud * er.aud_to_inr, 2) AS current_expense_inr, 
        ROUND(SUM(e.amount_aud * er.aud_to_inr) OVER(ORDER BY e.expense_date), 2) AS cumulative_spend_inr
FROM Expenses e
JOIN Exchange_Rates er ON e.expense_date = er.rate_date;

