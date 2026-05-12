# Dataset: Online Retail II

## 📖 Context
This dataset contains all transactions occurring for a UK-based and registered, non-store online retail business between **01/12/2009** and **09/12/2011**.

- **Business Model:** The company primarily sells unique all-occasion gift-ware.
- **Customer Base:** A significant portion of the customers are **wholesalers**, which often results in bulk orders.

---

## Data Dictionary (Attribute Information)

The dataset consists of 8 main attributes. Below is a detailed breakdown of each column:

| Attribute | Type | Description |
| :--- | :--- | :--- |
| **`InvoiceNo`** | Nominal | A 6-digit integral number uniquely assigned to each transaction. **Note:** If this code starts with the letter **'c'**, it indicates a **cancellation**. |
| **`StockCode`** | Nominal | A 5-digit integral number uniquely assigned to each distinct product. |
| **`Description`** | Nominal | The name of the product/item. |
| **`Quantity`** | Numeric | The quantities of each product per transaction. |
| **`InvoiceDate`** | Numeric | The day and time when a transaction was generated. |
| **`UnitPrice`** | Numeric | Product price per unit in **Sterling (£)**. |
| **`CustomerID`** | Nominal | A 5-digit integral number uniquely assigned to each customer. |
| **`Country`** | Nominal | The name of the country where each customer resides. |
