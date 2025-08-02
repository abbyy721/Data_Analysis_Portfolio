# Getting Started with Google BigQuery

This guide walks you through setting up Google BigQuery using a free trial, creating a dataset and table, and uploading a CSV file for SQL practice.

---

## ✅ Step 1. Google Cloud Console & Project Setup

1. **Log in with your Google account**
2. Go to [Google Cloud Console](https://console.cloud.google.com/)
3. Click **Project Selector** (top bar) → **New Project**
4. **Set a Project Name**  
   - ⚠️ Project ID must be unique (can’t duplicate others)
5. Click **Create Project**  
   - May take a few minutes
6. Start Free Trial  
   - Click **Start Free**  
   - Get **$300 credits for 90 days**

> ✅ **Remember your Project ID** – you'll use it in BigQuery

---

## ✅ Step 2. Enter BigQuery

1. In the left sidebar, click the **hamburger menu (≡)**  
2. Go to **BigQuery**
3. If you see **“BigQuery sandbox”**, click **Upgrade**

---

## ✅ Step 3. Understanding BigQuery Structure

BigQuery is organized in 3 layers:
`Project → Dataset → Table`


- **Project**: The top-level container
- **Dataset**: Like a warehouse within the project (can contain multiple tables)
- **Table**: Like shelves inside the warehouse; holds structured data (rows/columns), similar to Excel

---

## ✅ Step 4. Create a Dataset

1. On the left panel, under your project, click **+ Add Dataset**
2. Set **Dataset ID** (example: `basic`)
3. Click **Create Dataset**

---

## ✅ Step 5. Create a Table (from CSV)

1. In the dataset panel, click the **3 dots next to your dataset name** → **Create Table**
2. **Table Source**: Upload
   - Click **Upload** and choose your `.csv` file
3. **File Format**: CSV
4. **Table Name**: Use the same as your file name (or change it)
5. **Schema**:
   - ✅ Check **Auto detect**
   - ❗ If unchecked, you must define schema manually or use query format
6. Click **Create Table**

> 💡 Advanced Options: You can add **partitioning**, **clustering**, etc. as needed

---

## ✅ You’re Done!

You can now run SQL queries in **BigQuery Studio**:
```sql
SELECT * FROM `your-project-id.basic.your_table_name`;
