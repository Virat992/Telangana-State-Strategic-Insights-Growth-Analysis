SELECT 
    fact_transport$.dist_code as Dist_Code,
	dim_districts$.district as District,
    'FY 22-23' as Fiscal_Year,
    SUM(fuel_type_petrol) as Total_Sales_Petrol,
    SUM(fuel_type_diesel) as Total_Sales_Diesel,
    SUM(fuel_type_electric) as Total_Sales_Electric
FROM fact_transport$
Join dim_districts$ on fact_transport$.dist_code = dim_districts$.dist_code
WHERE month BETWEEN '2022-04-01' AND '2023-03-01'
GROUP BY fact_transport$.dist_code, dim_districts$.district
ORDER BY dist_code;





