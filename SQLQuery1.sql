WITH RevenueData AS (
    SELECT
        fs.dist_code as Dist_Code,
        'FY 19-22' as Fiscal_Year,
        dds.district as District,
        SUM(documents_registered_rev) AS Total_Revenue_Documents_Registered
    FROM
        fact_stamps$ fs
    JOIN
        dim_districts$ dds ON dds.dist_code = fs.dist_code
    WHERE
        month BETWEEN '2019-04-01' AND '2023-03-01'
    GROUP BY
        dds.district, fs.dist_code
)

SELECT
    rd.*,
    CASE
        WHEN Total_Revenue_Documents_Registered <= PERCENTILE_CONT(0.33) WITHIN GROUP (ORDER BY Total_Revenue_Documents_Registered) OVER () THEN 'Low'
        WHEN Total_Revenue_Documents_Registered <= PERCENTILE_CONT(0.67) WITHIN GROUP (ORDER BY Total_Revenue_Documents_Registered) OVER () THEN 'Medium'
        ELSE 'High'
    END AS Revenue_Segment
FROM
    RevenueData rd
ORDER BY
    rd.District, rd.Dist_Code;



SELECT TOP 5
    dds.dist_code as Dist_Code,
	'FY 19-22' as Fiscal_Year,
    dds.district as District,
    SUM(fs.documents_registered_rev) AS Total_Revenue_Documents_Registered
FROM
    fact_stamps$ fs
JOIN
    dim_districts$ dds ON dds.dist_code = fs.dist_code
WHERE
    fs.month BETWEEN '2019-04-01' AND '2023-03-01'
GROUP BY
    dds.dist_code, dds.district
ORDER BY
   Total_Revenue_Documents_Registered DESC;


