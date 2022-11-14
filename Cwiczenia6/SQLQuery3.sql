use [AdventureWorksDW2019]

-- ZADANIE 1
select OrderDateKey, sum(SalesAmount) as sum_sales  from FactInternetSales group by OrderDateKey

select p.OrderDateKey, avg(p.sum_sales) over (order by OrderDateKey rows between 2 preceding and current row) as rolling_avg from (select OrderDateKey, sum(SalesAmount) as sum_sales  from FactInternetSales group by OrderDateKey) as p order by OrderDateKey


--ZADANIE 2
SELECT  month_of_year ,  
    [0],[1], [2], [3], [4], [5],[6],[7],[8],[9],[10] 
FROM  
(select month(OrderDate) as month_of_year, SalesTerritoryKey, sum(SalesAmount) as sum_sales from FactInternetSales where Year(OrderDate) = 2011 group by SalesTerritoryKey, month(OrderDate)) p 
PIVOT
(
	sum(sum_sales)
	FOR SalesTerritoryKey IN ([0],[1], [2], [3], [4], [5],[6],[7],[8],[9],[10] ) 
)AS pvt
order by month(pvt.month_of_year)

--ZADANIE 3

select OrganizationKey, DepartmentGroupKey, sum(Amount) as amount from [dbo].[FactFinance] group by rollup( OrganizationKey, DepartmentGroupKey) order by OrganizationKey

-- ZADANIE 4
select OrganizationKey, DepartmentGroupKey, sum(Amount) as amount from [dbo].[FactFinance] group by cube( OrganizationKey, DepartmentGroupKey) order by OrganizationKey


--ZADANIE 5
with cte as (
select OrganizationKey,sum(Amount) as year_sum from [dbo].[FactFinance] where year(Date) = 2012 group by OrganizationKey 
)

select 
	cte.OrganizationKey,
	do.OrganizationName,
	cte.year_sum,
	PERCENT_RANK() OVER (order by year_sum) as percentile
from cte
join [dbo].[DimOrganization] do on do.OrganizationKey = cte.OrganizationKey
 order by OrganizationKey

 -- ZADANIE 6
with cte as (
select OrganizationKey,sum(Amount) as year_sum from [dbo].[FactFinance] where year(Date) = 2012 group by OrganizationKey 
)
 select 
	cte.OrganizationKey,
	do.OrganizationName,
	cte.year_sum,
	PERCENT_RANK() OVER (order by year_sum) as percentile,	
	STDEV(year_sum) OVER (order by cte.OrganizationKey) as std

from cte
join [dbo].[DimOrganization] do on do.OrganizationKey = cte.OrganizationKey
order by OrganizationKey
