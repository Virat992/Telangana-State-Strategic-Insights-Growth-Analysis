SELECT
	cast(month as date) as Month,
    sector as Sector,
    SUM([investment in cr]) as Total_Investment_In_Sector
FROM fact_TS_iPASS$
where month between '2019-04-01' and '2023-03-01'
GROUP BY sector, cast(month as date)