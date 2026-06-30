# 📊 International Student Academic & Living Cost Analyzer

## 🎯 The Problem
Moving abroad for a Master's degree requires serious financial and logistical planning. I built this custom SQL database to solve a very real problem: tracking international living expenses and academic progress in one unified system. 

When navigating a major transition—like relocating to Sydney for the Master of Data Science and Innovation (MDSI) program—dealing with daily budget constraints, currency fluctuations, and academic milestones can get incredibly chaotic. This project serves as a comprehensive tracker that maps out academic modules and semester credits while simultaneously logging daily living costs.

## 💡 The Solution
Instead of relying on a generic beginner dataset, I modeled a practical, real-world scenario to apply data science concepts. The core challenge this database solves is multi-currency tracking over time. It records daily expenses in the local currency (AUD) and dynamically maps them against historical daily exchange rates to calculate the precise, real-time cost in INR.

## 🛠️ Technical Skills Demonstrated
* **Time-Series Data Modeling:** Overcoming standard primary/foreign key limitations by joining expense tables with daily exchange rates based on specific transaction dates.
* **Advanced Analytics & Window Functions:** Utilizing functions like `SUM() OVER()` to calculate dynamic cumulative spending and running totals.
* **Robust Schema Design:** Ensuring strict referential integrity between academic programs and their respective modules.
* **Financial Data Integrity:** Enforcing exact decimal precision (`DECIMAL` instead of `FLOAT`) to prevent compounding rounding errors in financial data pipelines.

## 🗄️ Database Schema
The database consists of four core tables:
1. **`Programs`**: Tracks overarching degree information and target intakes.
2. **`Modules`**: Manages individual subjects, credit weights, and semester schedules.
3. **`Expenses`**: Logs day-to-day living costs (e.g., rent, groceries, transport, fitness) in AUD.
4. **`Exchange_Rates`**: A time-series table tracking the daily AUD to INR conversion rate.

## 🔍 Key SQL Queries Included
The project file contains the full schema creation, data insertion, and analytical queries, including:
* **The Currency Converter:** `JOIN` operations on date fields to calculate exact localized costs.
* **The Budget Summary:** Aggregations (`GROUP BY`) to track total spending per category.
* **Cumulative Spend Tracker:** Window functions to track exactly how a budget is consumed over a given period.

## 🚀 How to Use
1. Clone this repository or download the `.sql` file.
2. Run the script in your preferred SQL environment (PostgreSQL / MySQL).
3. Execute the analytical queries provided at the bottom of the script to view the generated insights.
