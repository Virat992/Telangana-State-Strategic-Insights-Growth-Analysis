SELECT
    fact_TS_iPASS$.dist_code as Dist_Code,
	'FY 21-22' as Fiscal_Year,
    dim_districts$.district as District,
    sector as Sector,
    SUM([investment in cr]) as Total_Investment_Sector
FROM fact_TS_iPASS$
JOIN dim_districts$ on fact_TS_iPASS$.dist_code = dim_districts$.dist_code
WHERE month BETWEEN '2021-04-01' AND '2022-03-01'
GROUP BY sector, fact_TS_iPASS$.dist_code, dim_districts$.district 
ORDER BY Total_Investment_Sector DESC;

