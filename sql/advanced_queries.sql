SELECT 
    ProductDescription,
    SUM(Revenue) AS total_revenue
FROM retail_sales
GROUP BY ProductDescription
HAVING SUM(Revenue) > 50000;


SELECT *
FROM (
    SELECT
        Country,
        ProductDescription,
        SUM(Revenue) AS total_revenue,
        RANK() OVER (
            PARTITION BY Country
            ORDER BY SUM(Revenue) DESC
        ) AS revenue_rank
    FROM retail_sales
    GROUP BY Country, ProductDescription
) ranked_products
WHERE revenue_rank <= 3;


SELECT
    CustomerID,
    SUM(Revenue) AS total_spent,
    RANK() OVER (
        ORDER BY SUM(Revenue) DESC
    ) AS customer_rank
FROM retail_sales
GROUP BY CustomerID;


WITH monthly_revenue AS (
    SELECT
        Year,
        Month,
        SUM(Revenue) AS revenue
    FROM retail_sales
    GROUP BY Year, Month
)
SELECT
    Year,
    Month,
    revenue,
    revenue - LAG(revenue) OVER (ORDER BY Year, Month) AS revenue_change,
    ROUND(
        (revenue - LAG(revenue) OVER (ORDER BY Year, Month)) 
        / LAG(revenue) OVER (ORDER BY Year, Month) * 100, 2
    ) AS growth_percentage
FROM monthly_revenue;


SELECT
    ProductDescription,
    SUM(Revenue) AS product_revenue,
    ROUND(
        SUM(Revenue) / SUM(SUM(Revenue)) OVER () * 100, 2
    ) AS revenue_percentage
FROM retail_sales
GROUP BY ProductDescription
ORDER BY revenue_percentage DESC;


SELECT
    CustomerID,
    MAX(InvoiceDate) AS last_purchase_date
FROM retail_sales
GROUP BY CustomerID
HAVING MAX(InvoiceDate) < DATE_SUB(
    (SELECT MAX(InvoiceDate) FROM retail_sales),
    INTERVAL 90 DAY
);