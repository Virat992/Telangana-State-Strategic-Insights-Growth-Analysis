SELECT 
    fact_transport$.dist_code as Dist_Code,
    dim_districts$.district as District,
    'FY 22-23' AS Fiscal_Year,
    SUM(vehicleClass_MotorCycle) AS Total_Sales_MotorCycle,
    SUM(vehicleClass_MotorCar) AS Total_Sales_MotorCar,
    SUM(vehicleClass_AutoRickshaw) AS Total_Sales_AutoRickshaw,
    SUM(vehicleClass_Agriculture) AS Total_Sales_Agriculture
FROM fact_transport$
JOIN dim_districts$ ON fact_transport$.dist_code = dim_districts$.dist_code
WHERE month BETWEEN '2022-04-01' AND '2023-03-01'
GROUP BY fact_transport$.dist_code, dim_districts$.district


