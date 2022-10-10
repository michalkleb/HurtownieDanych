with
	cte2 as(
	  SELECT od.[order_id]
		  ,sum(p.price*od.quantity) as order_amount
		  ,o.date
		  ,month(o.date) as month
	  FROM [cwiczenia1].[dbo].[order_details] od
	  JOIN pizzas p on p.pizza_id = od.pizza_id
	  JOIN orders o on o.order_id = od.order_id
	  group by od.order_id, date
	),
	cte as (
		select month
			  ,avg(order_amount) as avg_month_amount  
		from cte2 group by month 
	)


	select order_id
		  ,order_amount
		  ,date
	      ,cte.avg_month_amount
	from cte2 
	JOIN cte on cte.month = cte2.month