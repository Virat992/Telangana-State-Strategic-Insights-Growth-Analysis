WITH DistrictCollection AS (
    SELECT 
        ds.dist_code as Dist_Code,
        dd.district as District,
        SUM(total_collection) AS Total_Revenue_EStamps_Challans
    FROM 
    (
        SELECT 
            dist_code as Dist_Code, 
            formatted_month,
            SUM(estamps_challans_rev) AS total_collection
        FROM 
        (
            SELECT 
                dist_code as Dist_Code, 
                FORMAT(month, 'yyyy-MM-dd') AS formatted_month, 
                estamps_challans_rev
            FROM 
                fact_stamps$
            WHERE 
                month BETWEEN '2021-04-01' AND '2023-03-01'
        ) AS subquery
        GROUP BY 
            dist_code, 
            formatted_month
    ) AS ds
    JOIN
        dim_districts$ dd ON ds.dist_code = dd.dist_code
    GROUP BY 
        ds.dist_code, dd.district
)

SELECT 
    dist_code as Dist_Code,
	'FY 21-22' as Fiscal_Year,
    district as District,
    Total_Revenue_EStamps_Challans,
    CASE 
        WHEN Total_Revenue_EStamps_Challans <= PERCENTILE_CONT(0.33) WITHIN GROUP (ORDER BY Total_Revenue_EStamps_Challans) OVER () THEN 'Low'
        WHEN Total_Revenue_EStamps_Challans <= PERCENTILE_CONT(0.67) WITHIN GROUP (ORDER BY Total_Revenue_EStamps_Challans) OVER () THEN 'Medium'
        ELSE 'High'
    END AS Collection_Segment
FROM DistrictCollection
ORDER BY Total_Revenue_EStamps_Challans DESC;

