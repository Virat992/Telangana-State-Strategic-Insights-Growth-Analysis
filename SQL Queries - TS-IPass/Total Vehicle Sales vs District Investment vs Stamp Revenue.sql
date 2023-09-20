SELECT
    COALESCE(ts.dist_code, tr.dist_code, fs.dist_code) AS Dist_Code,
	'FY 21-22' as Fiscal_Year,
    dim_districts$.district AS District,
    ts.total_investment as District_Investment,
    tr.total_vehicle_sales as Total_Vehicle_Sales,
    fs.total_estmp_revenue as Total_Revenue_EStamps_Challans
FROM
    (SELECT
        dist_code,
        SUM([investment in cr]) AS total_investment
    FROM fact_TS_iPASS$
    WHERE month BETWEEN '2021-04-01' AND '2022-04-01'
    GROUP BY dist_code) AS ts

FULL JOIN
    (SELECT
        dist_code,
        SUM(seatCapacity_1_to_3 + seatCapacity_4_to_6 + seatCapacity_above_6) AS total_vehicle_sales
    FROM fact_transport$
    WHERE month BETWEEN '2021-04-01' AND '2022-04-01'
    GROUP BY dist_code) AS tr
ON ts.dist_code = tr.dist_code

FULL JOIN
    (SELECT
        dist_code,
        SUM(estamps_challans_rev) AS total_estmp_revenue
    FROM fact_stamps$
    WHERE month BETWEEN '2021-04-01' AND '2022-04-01'
    GROUP BY dist_code) AS fs
ON ts.dist_code = fs.dist_code OR tr.dist_code = fs.dist_code

LEFT JOIN dim_districts$ ON ts.dist_code = dim_districts$.dist_code

ORDER BY dist_code ASC;
