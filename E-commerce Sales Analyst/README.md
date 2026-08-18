# 📁 E-Commerce Sales Analysis

## Objective

Menganalisis performa penjualan, profitabilitas produk, kategori, kota, dan customer
untuk menghasilkan insight bisnis yang dapat mendukung pengambilan keputusan.

## Tools

- Excel
- PostgreSQL
- DBeaver
- SQL
- Power BI
- DAX

## Workflow

```
Raw Data → Excel (Cleaning & Preparation) → SQL Analysis → Data Validation → DAX → Power BI Dashboard → Business Insights → Recommendations
```

## Analysis yang Dilakukan

### 1. Excel (Data Cleaning & Exploration Awal)

- Data profiling untuk mengecek data kosong (Unknown)
- Filtering & pengecekan duplicate data, lalu remove duplicate
- Menghitung KPI utama: total transaksi, total sales, total profit, average sales
- Membuat pivot table untuk eksplorasi awal:
  - Sales by Product (sorted largest to smallest)
  - Sales by City
  - Category vs Profit
  - Category vs Profit vs Sales
  - Product vs Quantity
  - Product Performance (Product, Quantity, Sales, Profit)
- Menghitung Profit Margin (Profit / Sales)

### 2. SQL (PostgreSQL via DBeaver)

- Data overview: total transaksi, total quantity, total sales, total profit, average sales per transaksi
- Sales analysis: total sales by city, total sales by product
- Product performance: quantity, sales, profit, dan profit margin per produk
- Category performance: quantity, sales, profit, dan profit margin per kategori
- Customer analysis:
  - Menghitung jumlah unique customer
  - Customer sales ranking menggunakan window function (RANK)
  - Customer profitability & profit margin (customer "Unknown" dikecualikan)
- Data quality & validation:
  - Mengidentifikasi transaksi dengan Customer_Name "Unknown"
  - Mengecek Customer_Name yang NULL
  - Mengecek duplicate transaksi berdasarkan kombinasi Customer, Product, Sales, Quantity

## Key Findings

- Laptop memiliki total sales dan profit nominal tertinggi (Sales: Rp1.236.000.000, Profit: Rp310.491.699)
- Smartphone memiliki quantity penjualan tertinggi dengan 175 unit
- Rak memiliki profit margin tertinggi sebesar 26,58%, meskipun kontribusi sales dan profit nominalnya lebih kecil dibandingkan Laptop
- Electronics merupakan kategori dominan (Sales: Rp2.976.200.000, Profit: Rp746.936.063)
- Surabaya merupakan kota dengan total sales terbesar: Rp571.930.000
- Vina Maharani merupakan customer dengan total sales tertinggi: Rp307.327.500
- Top 5 customers menyumbang sekitar 33,82% dari total sales
- Ditemukan customer "Unknown" yang menjadi data quality issue dan perlu diperbaiki

## Business Recommendations

1. Mempertahankan Laptop sebagai produk utama karena menghasilkan sales dan profit nominal terbesar.
2. Mengevaluasi strategi pricing dan promotion pada Rak karena memiliki profit margin tertinggi.
3. Memprioritaskan kategori Electronics dalam strategi penjualan karena memberikan kontribusi terbesar terhadap sales dan profit.
4. Mengembangkan strategi customer retention untuk Top 5 customers karena memberikan kontribusi signifikan terhadap total sales.
5. Melakukan perbaikan data customer "Unknown" agar analisis customer dan reporting menjadi lebih akurat.

## Dashboard Preview

### Sales Overview

![Sales Overview](Image/Sales%20Overview.png)

### Customer Analysis

![Customer Analysis](Image/Customer%20Analysis.png)

### Business Insights

![Business Insights](Image/Business%20Insights.png)
