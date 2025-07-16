# retail_sale_project

#![Retail Sales Analysis]()


# 📊 Retail Sales SQL Project

A comprehensive SQL project focused on data cleaning, exploration, and business insights generation using a retail sales dataset.

---

## 📂 Table of Contents

- [Project Overview](#project-overview)
- [Database Schema](#database-schema)
- [Project Stages](#project-stages)
  - [1️⃣ Data Cleaning](#1️⃣-data-cleaning)
  - [2️⃣ Data Exploration](#2️⃣-data-exploration)
  - [3️⃣ Business Problem Solving](#3️⃣-business-problem-solving)
- [Key SQL Queries](#key-sql-queries)
- [Technologies Used](#technologies-used)

---

## 📌 Project Overview

This project simulates a retail store's sales transactions and analyzes:
- Daily sales
- Customer purchase patterns
- Category-wise sales
- Time-slot (shift) based sales trends
- Best-selling months

---

## 🏛️ Database Schema

Table Name: `retail_sales`

| Column Name       | Data Type     | Description                          |
|-------------------|--------------|--------------------------------------|
| transaction_id    | INT          | Unique transaction identifier        |
| sale_date         | DATE         | Date of the sale                     |
| sale_time         | TIME         | Time of the sale                     |
| customer_id       | INT          | Customer identifier                  |
| gender            | VARCHAR(15)  | Gender of the customer               |
| age               | INT          | Age of the customer                  |
| category          | VARCHAR(15)  | Product category                     |
| quantity          | INT          | Quantity sold                        |
| price_per_unit    | FLOAT        | Price per item                       |
| cogs              | FLOAT        | Cost of goods sold                   |
| total_sale        | FLOAT        | Total sale value per transaction     |

---

## 📊 Project Stages

### 1️⃣ Data Cleaning

```sql
SELECT * FROM retail_sales
WHERE transaction_id IS NULL
   OR sale_time IS NULL
   OR gender IS NULL
   OR category IS NULL
   OR quantity IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;

DELETE FROM retail_sales
WHERE transaction_id IS NULL
   OR sale_time IS NULL
   OR gender IS NULL
   OR category IS NULL
   OR quantity IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;



