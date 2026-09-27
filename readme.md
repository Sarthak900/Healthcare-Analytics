# Healthcare Analytics

## 📌 Project Overview

This project is an end-to-end **Healthcare Analytics System** that demonstrates how healthcare data can be cleaned, stored, analyzed, and visualized using Python, Oracle SQL, SQL*Loader, and Power BI.

The project follows a complete data analytics workflow:

**Raw Dataset → Python Data Cleaning → Cleaned Dataset → SQL*Loader → Oracle Database → SQL KPI Analysis → Power BI Dashboard**

---

## 🎯 Project Objectives

* Clean and prepare raw healthcare data using Python.
* Design and create a relational database in Oracle.
* Load cleaned CSV data into Oracle using SQL*Loader.
* Perform healthcare and revenue analysis using Oracle SQL.
* Calculate important business KPIs.
* Build an interactive Power BI dashboard.
* Demonstrate an end-to-end data analytics workflow.

---

## 🛠️ Tools & Technologies

* **Python**
* **Pandas**
* **Oracle Database**
* **Oracle SQL**
* **SQL*Loader**
* **Oracle Client / ODAC**
* **Power BI Desktop**
* **GitHub**

---

## 📂 Project Structure

```text
Healthcare-Analytics/
│
├── Data/
│   ├── healthcare_dataset.csv
│   └── healthcare_dataset_cleaned.csv
│
├── Oracle SQL/
│   ├── 01_create_user.sql
│   ├── 02_schema.sql
│   ├── 03_data_loading.txt
│   ├── 04_kpi_queries.sql
│   │
│   └── ctl/
│       ├── doctors.ctl
│       ├── hospitals.ctl
│       ├── insurance_providers.ctl
│       ├── patients.ctl
│       └── admissions.ctl
│
├── Power BI/
│   └── Healthcare_Analytics.pbix
│
├── Python/
│   └── clean_data.py
│
├── screenshots/
│   ├── overview.png
│   ├── patient_analysis.png
│   ├── hospital_analysis.png
│   └── revenue_analysis.png
│
└── README.md
```

---

# 🐍 1. Python Data Cleaning

The raw healthcare dataset was cleaned and prepared using **Python and Pandas**.

### Cleaning Operations

* Standardized text values.
* Removed unnecessary leading/trailing spaces.
* Standardized text casing.
* Converted date columns into proper date format.
* Rounded billing amounts.
* Removed exact duplicate records.
* Calculated **Length of Stay**.
* Created an **Admission_ID**.
* Exported the cleaned dataset for database loading.

### Dataset Results

| Metric                    |  Count |
| ------------------------- | -----: |
| Raw Records               | 55,500 |
| Duplicate Records Removed |    534 |
| Clean Records             | 54,966 |

The cleaned dataset is available in:

```text
Data/healthcare_dataset_cleaned.csv
```

The Python cleaning script is available in:

```text
Python/clean_data.py
```

---

# 🗄️ 2. Oracle Database

Oracle Database is used as the relational database layer for the project.

The database contains the following major entities:

* Doctors
* Hospitals
* Insurance Providers
* Patients
* Admissions

The database schema includes:

* Primary Keys
* Foreign Keys
* Unique Constraints
* NOT NULL Constraints
* Sequences
* Triggers
* Indexes
* Referential Integrity

### Database Files

```text
Oracle SQL/
├── 01_create_user.sql
└── 02_schema.sql
```

### `01_create_user.sql`

Creates the Oracle database user and provides the required privileges for the project.

> Replace placeholder credentials with your own local Oracle credentials. 

### `02_schema.sql`

Creates the database tables, sequences, triggers, constraints, and indexes required for the healthcare analytics system.

---

# 📥 3. SQL*Loader Data Loading

**Oracle SQL*Loader** is used to load the cleaned CSV data into the Oracle database.

The SQL*Loader workflow uses **Control Files (`.ctl`)** to define how the CSV data should be mapped to the corresponding Oracle tables.

### Control Files

The `ctl/` directory contains the SQL*Loader control files:

```text
ctl/
├── doctors.ctl
├── hospitals.ctl
├── insurance_providers.ctl
├── patients.ctl
└── admissions.ctl
```

The control files define information such as:

* Source data file
* Target Oracle table
* Field delimiters
* Column mappings
* Data loading configuration

### Data Loading Commands

The SQL*Loader commands used for loading the data are documented in:

```text
Oracle SQL/03_data_loading.txt
```

The overall loading process is:

```text
Cleaned CSV Files
       ↓
SQL*Loader Control Files (.ctl)
       ↓
Oracle Database Tables
       ↓
SQL Analysis
```

---

# 📊 4. Oracle SQL KPI Analysis

After loading the data into Oracle, SQL queries are used to analyze healthcare operations, patient demographics, hospital performance, and revenue.

The KPI queries are available in:

```text
Oracle SQL/04_kpi_queries.sql
```

### Analysis Areas

The project includes SQL analysis for:

1. Total Revenue
2. Total Admissions
3. Average Billing Amount
4. Monthly Revenue Trend
5. Revenue by Hospital
6. Revenue by Doctor
7. Average Length of Stay by Admission Type
8. Revenue by Admission Type
9. Insurance Provider Analysis
10. Medical Condition Analysis
11. Patient Demographics
12. Test Results Analysis
13. Room Utilization
14. Repeat Patients

The SQL analysis demonstrates the use of:

* Aggregate Functions
* `GROUP BY`
* `HAVING`
* `CASE`
* Joins
* Subqueries
* Analytic Functions
* `ROWNUM`
* Date Functions
* Percentage Calculations
* Ranking and Top-N Analysis

---

# 📈 5. Power BI Dashboard

Power BI is used to create an interactive healthcare analytics dashboard.

The dashboard is designed to provide insights into:

* Patient volume
* Revenue
* Hospital performance
* Medical conditions
* Admission types
* Patient demographics
* Insurance providers
* Length of stay
* Test results

The Power BI project file will be available in:

```text
Power BI/Healthcare_Analytics.pbix
```

### Power BI Data Connection

The dashboard uses the Oracle database as the analytical data source.

The local connection workflow is:

```text
Oracle Database
       ↓
Oracle Client / ODAC
       ↓
Power BI Desktop
       ↓
Interactive Dashboard
```

---

# 🔄 End-to-End Project Workflow

```text
                 RAW HEALTHCARE DATA
                         │
                         ▼
                ┌─────────────────┐
                │ Python + Pandas │
                │ Data Cleaning    │
                └────────┬────────┘
                         │
                         ▼
                 CLEANED CSV DATA
                         │
                         ▼
                ┌─────────────────┐
                │   SQL*Loader    │
                │   Control Files │
                │     (.ctl)      │
                └────────┬────────┘
                         │
                         ▼
                ┌─────────────────┐
                │ Oracle Database │
                │     Schema      │
                └────────┬────────┘
                         │
                         ▼
                ┌─────────────────┐
                │   Oracle SQL    │
                │ KPI & Analysis  │
                └────────┬────────┘
                         │
                         ▼
                ┌─────────────────┐
                │    Power BI     │
                │    Dashboard    │
                └─────────────────┘
```

---

# ▶️ How to Reproduce the Project

### Step 1 — Clean the Dataset

Run:

```bash
python Python/clean_data.py
```

This generates:

```text
Data/healthcare_dataset_cleaned.csv
```

---

### Step 2 — Create the Oracle User

Run:

```text
Oracle SQL/01_create_user.sql
```

Update the placeholder values according to your local Oracle environment.

---

### Step 3 — Create the Database Schema

Run:

```text
Oracle SQL/02_schema.sql
```

This creates the required tables, sequences, triggers, constraints, and indexes.

---

### Step 4 — Load Data Using SQL*Loader

Use the control files located in:

```text
Oracle SQL/ctl/
```

The SQL*Loader commands are documented in:

```text
Oracle SQL/03_data_loading.txt
```

---

### Step 5 — Run KPI Queries

Execute:

```text
Oracle SQL/04_kpi_queries.sql
```

to generate the required healthcare and revenue analysis.

---

### Step 6 — Open Power BI

Open:

```text
Power BI/Healthcare_Analytics.pbix
```

Configure the local Oracle connection if required and refresh the data.

---

# 📌 Key Skills Demonstrated

### Python

* Pandas
* Data Cleaning
* Data Transformation
* Date Handling
* Duplicate Detection
* Feature Creation

### Oracle SQL

* Database Design
* DDL
* DML
* Joins
* Subqueries
* Aggregate Functions
* Analytical Functions
* CASE Expressions
* Date Functions
* Top-N Queries
* KPI Analysis

### Database

* Relational Database Design
* Primary & Foreign Keys
* Constraints
* Sequences
* Triggers
* Indexes
* Referential Integrity
* SQL*Loader

### Power BI

* Data Connection
* Data Visualization
* KPI Dashboards
* Interactive Analysis
* Healthcare Analytics

---

# 📊 Project Status

| Component                | Status         |
| ------------------------ | -------------- |
| Python Data Cleaning     | ✅ Completed    |
| Oracle Database Design   | ✅ Completed    |
| Database Schema          | ✅ Completed    |
| SQL*Loader               | ✅ Completed    |
| SQL*Loader Control Files | ✅ Completed    |
| SQL KPI Analysis         | ✅ Completed    |
| Power BI Dashboard       | 🚧 In Progress |
| Dashboard Screenshots    | 🚧 To Be Added |

---

# 👤 Author

**Sarthak Pravin Pandit**

B.Tech — Electronics & Telecommunication Engineering

### Skills

* Python
* SQL / Oracle SQL
* Power BI
* Excel
* Data Analysis
* Database Design
