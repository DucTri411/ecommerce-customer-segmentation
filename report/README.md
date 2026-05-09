# 📊 Power BI Dashboard: Online Retail II Analytics

## 📑 Project Overview
This project provides a comprehensive analysis of retail transactions, focusing on sales performance, customer retention, and behavioral segmentation. 

### ⚙️ Data Preparation & Feature Engineering
Beyond the raw dataset, I performed significant data enrichment to facilitate deeper analysis:
*   **Custom Revenue Calculation:** Created a calculated column `Revenue` within the `2009 - 2011` table to serve as the foundation for all monetary metrics.
*   **Calendar Intelligence:** Developed a dedicated `Date Table` to support Time Intelligence functions (YoY Growth, PM comparisons) and ensure accurate filtering across the schema.

---

## 📈 Key Performance Indicators (KPIs)
The following metrics were engineered using DAX to track business health:

### 1. Sales & Operational Metrics
*   **Total Revenue:** The sum of the custom-calculated Revenue column.
*   **Revenue PM (Previous Month):** Used to compare current performance against the prior period.
*   **Revenue Growth (%):** Percentage change in revenue to track scaling.
*   **AOV (Average Order Value):** Measures the average spend per transaction.
*   **Purchase Frequency:** Tracks how often customers interact with the brand.

### 2. Customer Lifecycle Analysis
I implemented a robust tracking system to monitor the flow of the customer base:
*   **New vs. Returning Customers:** Metrics and charts to identify the success of acquisition vs. retention strategies.
*   **Churn Analysis:** Advanced DAX logic used to identify **Churned Customers** (those who haven't purchased within a specific window) and calculate the **Churn Rate**.
    *   *Logic Note:* The Churn calculation utilizes a dynamic reference date to identify inactivity periods.

---

## 🎯 Advanced Analytics: RFM Segmentation
A core highlight of this project is the **RFM (Recency, Frequency, Monetary)** model. This allows for data-driven customer segmentation:

| Metric | Description |
| :--- | :--- |
| **Recency (R)** | Days since the last purchase. |
| **Frequency (F)** | Total number of unique transactions. |
| **Monetary (M)** | Total value contributed by the customer. |

**The RFM implementation includes:**
- Individual scoring for R, F, and M.
- A consolidated **RFM Score**.
- **Customer Segmentation:** Logic to group customers into categories (e.g., "Champions," "At Risk," "Loyal") to enable targeted marketing actions.

---

## 🏗️ Data Model
The report is built on a **Star Schema** to optimize performance:
- **Fact Table:** `2009 - 2011` (containing the custom `Revenue` field).
- **Dimension Tables:** `Date Table`, `Customer Analysis`, and `RFM`.