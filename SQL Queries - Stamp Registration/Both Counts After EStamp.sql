SELECT 
    cast(month as date) as Month, 
    SUM(documents_registered_cnt) AS Total_Count_Registered_Document,
    SUM(estamps_challans_cnt) AS Total_Count_Estamp_Challan
FROM fact_stamps$
WHERE month IN (
    SELECT DISTINCT month
    FROM fact_stamps$
    WHERE estamps_challans_cnt != 0
)
GROUP BY month
ORDER BY month;
