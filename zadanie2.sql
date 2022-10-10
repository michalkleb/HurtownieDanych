with cte as(
SELECT od.[order_id]
      ,od.[pizza_id]
	  ,o.date as order_date
	  ,pt.ingredients as ingredients
  FROM [cwiczenia1].[dbo].[order_details] od
  JOIN pizzas p on p.pizza_id = od.pizza_id
  JOIN pizza_types pt  on pt.pizza_type_id = p.pizza_type_id
  JOIN orders o on o.order_id = od.order_id
  WHERE o.date LIKE '%2015-03%'
  )

  select order_id, STRING_AGG(ingredients,',') ingredients
  from cte
  where ingredients NOT LIKE '%Pineapple%'
  group by order_id

