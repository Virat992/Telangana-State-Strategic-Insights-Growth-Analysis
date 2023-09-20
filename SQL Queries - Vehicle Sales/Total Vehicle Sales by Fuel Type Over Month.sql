	SELECT
    fact_transport$.dist_code as Dist_Code,
	dim_districts$.district as District,
    CAST(month AS DATE) AS Month,
    SUM(fuel_type_petrol) AS Total_Sales_Petrol,
    SUM(fuel_type_diesel) AS Total_Sales_Diesel,
    SUM(fuel_type_electric) AS Total_Sales_electric,
    SUM(fuel_type_others) AS Total_Sales_others
FROM
    fact_transport$
JOIN dim_districts$ on dim_districts$.dist_code = fact_transport$.dist_code 
GROUP BY
    fact_transport$.dist_code,
    CAST(month AS DATE),
	dim_districts$.district;



	




