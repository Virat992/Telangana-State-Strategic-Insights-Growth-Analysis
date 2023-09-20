Select
	fs.dist_code as Dist_Code, 
	dds.district as District, 
	SUM(documents_registered_rev) AS Total_Revenue_Documents_Registered,
SUM(estamps_challans_rev) AS Total_Revenue_EStamps_Challans
FROM fact_stamps$ fs
join dim_districts$ dds on dds.dist_code = fs.dist_code
GROUP BY fs.dist_code, dds.district
order by dist_code, dds.district

Select distinct 
	ft.dist_code as Dist_Code, 
	dds.district as District,
	cast(month as date) as Month , 
	SUM(ft.estamps_challans_rev) AS Total_Revenue_EStamps_Challans,
	SUM(ft.documents_registered_rev) AS Total_Revenue_Documents_Registered,
	SUM(ft.estamps_challans_rev)-SUM(ft.documents_registered_rev) as Differenc
FROM fact_stamps$ ft
join dim_districts$ dds on ft.dist_code = dds.dist_code
where month between '2022-04-01' AND '2023-03-01'
GROUP BY ft.dist_code, ft.month, dds.district
order by Differenc desc