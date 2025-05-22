# SmartSaverDB

SmartSaverDB is a mock SQL Server database project designed to simulate a savings and withdrawal application. It features users, savings accounts, savings plans, and withdrawal records. This project is ideal for learning and assessing SQL proficiency in relational database design, data manipulation, and querying.

## 🧠 Features

- Normalized relational database schema
- Sample data for realistic analysis
- Views and stored procedures for business logic
- Queries to derive key insights

## 🏗️ Database Schema

- **users_customuser**: Contains user data
- **savings_savingsaccount**: Tracks savings balance and associated users
- **plans_plan**: Savings plans and expected contributions
- **withdrawals_withdrawal**: Records of user withdrawals

## 🚀 Getting Started

### Requirements

- SQL Server (2017+)
- SSMS or Azure Data Studio

### Setup

1. Open SQL Server Management Studio (SSMS)
2. Run the combined SQL script `SmartSaverDB.sql` to:
   - Create the database
   - Create tables
   - Insert sample data
   - Create views and stored procedures

## 🧪 Sample Queries

- View total savings and withdrawals by user
- Retrieve users on a specific savings plan
- Monitor account balances

## 🔄 Reset

To reset the database, you can re-run the script after deleting the existing database.

```sql
DROP DATABASE SmartSaverDB;


