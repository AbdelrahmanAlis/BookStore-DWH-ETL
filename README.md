# BookStore Data Warehouse Project 📚📊

A comprehensive End-to-End Data Engineering project that transforms an Operational Database (OLTP) into a Dimensional Model (Star Schema) for analytical purposes.

## 🚀 Project Overview
This project demonstrates the transition from a normalized bookstore database to a specialized Data Warehouse (DWH). It handles complex data relationships and ensures data integrity for business intelligence reporting.

## 🏗️ Architecture & Design
The project follows a **Star Schema** architecture with a specialized **Bridge Table** to handle many-to-many relationships.

### Key Technical Features:
* **Dimensional Modeling**: Designed a Star Schema with Fact and Dimension tables.
* **Bridge Table Implementation**: Solved the "Multi-valued Dimension" problem where a book can have multiple authors, preventing row explosion in the Fact table.
* **Surrogate Keys**: Used system-generated keys (SKs) for all dimensions to ensure independence from source system changes.
* **Data Cleaning**: Implemented logic to handle missing data (e.g., city imputation via ZipCode) and Unknown members (SK=0).

### Data Warehouse Schema
![DWH Schema]("docs/diagrams/dwh_schema.png") 




## 🛠️ Tech Stack
* **Database**: SQL Server (T-SQL)
* **Language**: Python
* **Libraries**: Pandas, PyODBC
* **Environment**: Jupyter Notebooks

## 📂 Project Structure
* `sql/`: Contains DDL scripts for Source and DWH databases.
* `notebooks/`: Contains the ETL pipeline logic (Extract, Transform, Load).
* `docs/`: Includes mapping sheets and design diagrams.

## ⚙️ How to Run
1. Execute the SQL scripts in the `sql/` folder to set up the databases.
2. Install dependencies: `pip install -r requirements.txt`.
3. Run the `pipeline.ipynb` notebook to execute the ETL process.

---
