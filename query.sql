/*Menggunakan syntax CREATE TABLE untuk membuat tabel analisa baru dengan nama kf_analysis_performance pada dataset kimia_farma

CREATE TABLE kimia_farma.kf_analysis_performance AS
/*syntax SELECT digunakan untuk mengambil informasi dari database
SELECT
    ft.transaction_id,
    ft.date,
    ft.branch_id,
    kc.branch_name,
    kc.kota,
    kc.provinsi,
    kc.rating AS rating_cabang,
    ft.customer_name,
    ft.product_id,
    p.product_name,
    p.price AS actual_price,
    ft.discount_percentage,
    CASE
        WHEN p.price <= 50000 THEN 0.10
        WHEN p.price > 50000 AND p.price <= 100000 THEN 0.15
        WHEN p.price > 100000 AND p.price <= 300000 THEN 0.20
        WHEN p.price > 300000 AND p.price <= 500000 THEN 0.25
        ELSE 0.30
    END AS persentase_gross_laba,
    (p.price * (1 - ft.discount_percentage )) AS nett_sales,
    (p.price * (1 - ft.discount_percentage )) * (CASE
                                                        WHEN p.price <= 50000 THEN 0.10
                                                        WHEN p.price >50000 AND p.price <= 100000 THEN 0.15
                                                        WHEN p.price > 100000 AND p.price <= 300000 THEN 0.20
                                                        WHEN p.price > 300000 AND p.price <= 500000 THEN 0.25
                                                        ELSE 0.30
                                                    END) AS nett_profit,
    ft.rating AS rating_transaksi
FROM
    kimia_farma.kf_final_transaction AS ft
/*syntax INNER JOIN digunakan untuk menggabungkan data dari dua atau lebih tabel
INNER JOIN 
    kimia_farma.kf_kantor_cabang AS kc
ON
    ft.branch_id = kc.branch_id
INNER JOIN 
    kimia_farma.kf_product AS p
ON
    ft.product_id = p.product_id
/*syntax ORDER BY DESC digunakan untuk mengurutkan data pada tabel dalam urutan menurun
ORDER BY date DESC;
