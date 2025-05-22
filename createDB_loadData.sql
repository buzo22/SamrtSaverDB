-- 01_create_database.sql
DROP DATABASE IF EXISTS SmartSaverDB;
CREATE DATABASE SmartSaverDB;
GO
USE SmartSaverDB;
GO

-- 02_create_tables.sql
CREATE TABLE users_customuser (
    id INT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE savings_savingsaccount (
    id INT PRIMARY KEY,
    user_id INT NOT NULL,
    balance DECIMAL(18, 2) DEFAULT 0,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES users_customuser(id)
);

CREATE TABLE plans_plan (
    id INT PRIMARY KEY,
    user_id INT NOT NULL,
    title VARCHAR(100),
    target_amount DECIMAL(18, 2),
    start_date DATE,
    end_date DATE,
    FOREIGN KEY (user_id) REFERENCES users_customuser(id)
);

CREATE TABLE withdrawals_withdrawal (
    id INT PRIMARY KEY,
    user_id INT NOT NULL,
    amount DECIMAL(18, 2) NOT NULL,
    reason VARCHAR(255),
    withdrawal_date DATE,
    FOREIGN KEY (user_id) REFERENCES users_customuser(id)
);

-- 03_insert_sample_data.sql
INSERT INTO users_customuser (id, username, email) VALUES
(1, 'alice', 'alice@example.com'),
(2, 'bob', 'bob@example.com');

INSERT INTO savings_savingsaccount (id, user_id, balance) VALUES
(1, 1, 1000.00),
(2, 2, 2500.00);

INSERT INTO plans_plan (id, user_id, title, target_amount, start_date, end_date) VALUES
(1, 1, 'Vacation Plan', 3000.00, '2025-01-01', '2025-12-31'),
(2, 2, 'New Car', 5000.00, '2025-03-01', '2025-12-31');

INSERT INTO withdrawals_withdrawal (id, user_id, amount, reason, withdrawal_date) VALUES
(1, 1, 200.00, 'Emergency', '2025-04-01'),
(2, 2, 500.00, 'Car Repairs', '2025-05-01');

-- 04_stored_procedures.sql
CREATE PROCEDURE MakeWithdrawal
    @userId INT,
    @amount DECIMAL(18,2),
    @reason VARCHAR(255)
AS
BEGIN
    DECLARE @balance DECIMAL(18,2);
    SELECT @balance = balance FROM savings_savingsaccount WHERE user_id = @userId;

    IF @balance >= @amount
    BEGIN
        UPDATE savings_savingsaccount
        SET balance = balance - @amount
        WHERE user_id = @userId;

        INSERT INTO withdrawals_withdrawal (id, user_id, amount, reason, withdrawal_date)
        VALUES ((SELECT ISNULL(MAX(id), 0) + 1 FROM withdrawals_withdrawal), @userId, @amount, @reason, GETDATE());
    END
    ELSE
    BEGIN
        RAISERROR ('Insufficient balance.', 16, 1);
    END
END;

-- 05_views.sql
CREATE VIEW vw_user_savings_summary AS
SELECT
    u.username,
    u.email,
    sa.balance,
    COUNT(w.id) AS withdrawal_count,
    SUM(w.amount) AS total_withdrawn
FROM users_customuser u
LEFT JOIN savings_savingsaccount sa ON u.id = sa.user_id
LEFT JOIN withdrawals_withdrawal w ON u.id = w.user_id
GROUP BY u.username, u.email, sa.balance;

-- 06_sample_queries.sql
-- List users and their savings balance
SELECT * FROM vw_user_savings_summary;

-- List all plans for a user
SELECT * FROM plans_plan WHERE user_id = 1;

-- Show all withdrawals
SELECT * FROM withdrawals_withdrawal ORDER BY withdrawal_date DESC;
