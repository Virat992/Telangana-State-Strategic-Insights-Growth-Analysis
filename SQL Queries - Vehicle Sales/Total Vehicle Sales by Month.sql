SELECT
    fts.dist_code as Dist_Code,
	dds.district as District,
    CAST(month AS DATE) as Month,
    SUM(fuel_type_petrol + fuel_type_diesel + fuel_type_electric + fuel_type_others) AS Total_Sales_by_Fuel_Type
FROM
    fact_transport$ fts
join dim_districts$ dds on fts.dist_code = dds.dist_code
GROUP BY
    fts.dist_code, dds.district,
  CAST(month AS DATE)
