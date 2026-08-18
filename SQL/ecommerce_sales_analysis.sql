-- =====================================================
-- E-COMMERCE SALES ANALYSIS
-- PostgreSQL
-- =====================================================

-- 01. DATA OVERVIEW
-- Menampilkan jumlah transaksi, quantity, sales, profit,
-- dan rata-rata sales per transaksi.

SELECT
    COUNT(*) AS total_transaksi,
    SUM("Quantity") AS total_quantity,
    SUM("Sales") AS total_sales,
    SUM("Profit") AS total_profit,
    ROUND(AVG("Sales"), 0) AS average_sales
FROM public.data_mentah;

-- =====================================================
-- 02. SALES ANALYSIS
-- =====================================================

-- 02.1 Total Sales by City
-- Mengetahui kota dengan total sales terbesar.

SELECT
    "City",
    SUM("Sales") AS total_sales
FROM public.data_mentah
GROUP BY "City"
ORDER BY total_sales DESC;


-- 02.2 Total Sales by Product
-- Mengetahui produk dengan total sales terbesar.

SELECT
    "Product",
    SUM("Sales") AS total_sales
FROM public.data_mentah
GROUP BY "Product"
ORDER BY total_sales DESC;

-- =====================================================
-- 03. PRODUCT PERFORMANCE
-- =====================================================

-- Menganalisis performa setiap produk berdasarkan
-- quantity, sales, profit, dan profit margin.

SELECT
    "Product",
    SUM("Quantity") AS total_quantity,
    SUM("Sales") AS total_sales,
    SUM("Profit") AS total_profit,
    ROUND(
        (SUM("Profit")::numeric / NULLIF(SUM("Sales"), 0)) * 100,
        2
    ) AS profit_margin
FROM public.data_mentah
GROUP BY "Product"
ORDER BY total_sales DESC;

-- =====================================================
-- 04. CATEGORY PERFORMANCE
-- =====================================================

-- Menganalisis performa setiap kategori berdasarkan
-- quantity, sales, profit, dan profit margin.

SELECT
    "Category",
    SUM("Quantity") AS total_quantity,
    SUM("Sales") AS total_sales,
    SUM("Profit") AS total_profit,
    ROUND(
        (SUM("Profit")::numeric / NULLIF(SUM("Sales"), 0)) * 100,
        2
    ) AS profit_margin
FROM public.data_mentah
GROUP BY "Category"
ORDER BY total_profit DESC;

-- =====================================================
-- 05. CUSTOMER ANALYSIS
-- =====================================================

-- 05.1 Unique Customers
-- Menghitung jumlah customer unik.

SELECT
    COUNT(DISTINCT "Customer_Name") AS unique_customers
FROM public.data_mentah;


-- 05.2 Customer Sales Ranking
-- Memberikan ranking customer berdasarkan total sales.

SELECT
    "Customer_Name",
    COUNT(*) AS total_transaksi,
    SUM("Sales") AS total_sales,
    SUM("Profit") AS total_profit,
    RANK() OVER (
        ORDER BY SUM("Sales") DESC
    ) AS sales_rank
FROM public.data_mentah
GROUP BY "Customer_Name"
ORDER BY sales_rank;


-- 05.3 Customer Profitability
-- Menganalisis profit margin setiap customer.
-- Customer "Unknown" dikeluarkan dari analisis.

SELECT
    "Customer_Name",
    SUM("Sales") AS total_sales,
    SUM("Profit") AS total_profit,
    ROUND(
        (SUM("Profit")::numeric / NULLIF(SUM("Sales"), 0)) * 100,
        2
    ) AS profit_margin
FROM public.data_mentah
WHERE "Customer_Name" <> 'Unknown'
GROUP BY "Customer_Name"
ORDER BY profit_margin DESC;

-- =====================================================
-- 06. DATA QUALITY & VALIDATION
-- =====================================================

-- 06.1 Customer Unknown
-- Mengidentifikasi transaksi yang tidak memiliki
-- nama customer yang valid.

SELECT
    COUNT(*) AS unknown_transactions,
    SUM("Sales") AS unknown_sales,
    SUM("Profit") AS unknown_profit
FROM public.data_mentah
WHERE "Customer_Name" = 'Unknown';

-- 06.2 Missing Customer Name
-- Mengecek apakah terdapat Customer_Name yang NULL.

SELECT
    COUNT(*) AS missing_customer
FROM public.data_mentah
WHERE "Customer_Name" IS NULL;

-- 06.3 Duplicate Check
-- Mengecek kombinasi transaksi yang muncul lebih dari sekali.

SELECT
    "Customer_Name",
    "Product",
    "Sales",
    "Quantity",
    COUNT(*) AS duplicate_count
FROM public.data_mentah
GROUP BY
    "Customer_Name",
    "Product",
    "Sales",
    "Quantity"
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC;

-- =====================================================
-- 07. BUSINESS RECOMMENDATIONS
-- =====================================================

-- Key Findings:
--
-- 1. Laptop memiliki total sales dan profit nominal tertinggi.
--    Sales: Rp1.236.000.000
--    Profit: Rp310.491.699
--
-- 2. Smartphone memiliki quantity penjualan tertinggi
--    dengan 175 unit.
--
-- 3. Rak memiliki profit margin tertinggi sebesar 26,58%,
--    meskipun kontribusi sales dan profit nominalnya lebih kecil
--    dibandingkan Laptop.
--
-- 4. Electronics merupakan kategori dominan dengan:
--    Sales: Rp2.976.200.000
--    Profit: Rp746.936.063
--
-- 5. Surabaya merupakan kota dengan total sales terbesar:
--    Rp571.930.000
--
-- 6. Vina Maharani merupakan customer dengan total sales
--    tertinggi sebesar Rp307.327.500.
--
-- 7. Top 5 customers menyumbang sekitar 33,82% dari total sales.
--
-- 8. Ditemukan customer "Unknown" yang perlu diperbaiki
--    sebagai bagian dari data quality improvement.


-- Recommendations:
--
-- 1. Mempertahankan Laptop sebagai produk utama karena
--    menghasilkan sales dan profit nominal terbesar.
--
-- 2. Mengevaluasi strategi pricing dan promotion pada Rak
--    karena memiliki profit margin tertinggi.
--
-- 3. Memprioritaskan kategori Electronics dalam strategi
--    penjualan karena memberikan kontribusi terbesar terhadap
--    sales dan profit.
--
-- 4. Mengembangkan strategi customer retention untuk Top 5
--    customers karena memberikan kontribusi signifikan
--    terhadap total sales.
--
-- 5. Melakukan perbaikan data customer "Unknown" agar
--    analisis customer dan reporting menjadi lebih akurat.