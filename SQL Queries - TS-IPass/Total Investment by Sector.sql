SELECT top 10
    sector as Sector,
    SUM([investment in cr]) as Total_Investment_In_Sector
FROM fact_TS_iPASS$
WHERE month BETWEEN '2022-04-01' AND '2023-03-01'
GROUP BY sector
order by total_investment_In_Sector desc


