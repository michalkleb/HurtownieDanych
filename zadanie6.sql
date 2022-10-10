with cte as(
SELECT pt.[name]
	  ,pt.[category]
	  ,COUNT(od.[quantity]) as popularity
  FROM [cwiczenia1].[dbo].[order_details] od
  JOIN pizzas p on p.pizza_id = od.pizza_id
  JOIN pizza_types pt  on pt.pizza_type_id = p.pizza_type_id
  JOIN orders o on o.order_id = od.order_id
  WHERE o.date LIKE  '%2015-01%'
  group by pt.[name], pt.[category]
  )


  select * from cte order by  popularity DESC