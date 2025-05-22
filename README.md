# 💰 SmartSaverDB

SmartSaverDB is a SQL Server-based project that simulates the core database structure for a personal savings and withdrawal application. It contains structured tables for users, savings accounts, savings plans, and withdrawal tracking. This project is designed for SQL proficiency assessment, learning, and portfolio demonstration purposes.

---

## 📁 Project Structure

This repository includes:

- `SmartSaverDB.sql`: Full SQL Server-compatible script to:
  - Create the database and tables
  - Define primary and foreign keys
  - Insert sample data

---

## 🧠 Database Schema
users_customuser
├── id (PK)
├── email
├── full_name
├── date_joined

savings_savingsaccount
├── id (PK)
├── user_id (FK → users_customuser.id)
├── balance
├── created_at

plans_plan
├── id (PK)
├── user_id (FK → users_customuser.id)
├── title
├── target_amount
├── frequency
├── start_date
├── end_date

withdrawals_withdrawal
├── id (PK)
├── savings_account_id (FK → savings_savingsaccount.id)
├── amount
├── withdrawal_date



---

## 📦 Sample Data

The script inserts sample records for:

- **3 users** with names and emails
- **3 savings accounts**, one per user
- **3 savings plans** with weekly, monthly, and one-time goals
- **3 withdrawals**, one per account

---

## ⚙️ How to Use

### 🖥️ Requirements

- SQL Server (2019+ recommended)
- SQL Server Management Studio (SSMS) or Azure Data Studio

### 🚀 Setup Steps

1. **Clone this repository**

```bash
git clone https://github.com/your-username/SmartSaverDB.git
cd SmartSaverDB


🙋‍♂️ Author

Chibuzo Valentine Akana
📄 License

This project is licensed for personal or educational use. Feel free to fork, modify, or use it in portfolios. No warranties provided.

