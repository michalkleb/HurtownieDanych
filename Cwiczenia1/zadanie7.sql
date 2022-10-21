with cte as(
SELECT p.[size]
	  ,COUNT(od.[quantity]) as popularity
  FROM [cwiczenia1].[dbo].[order_details] od
  JOIN pizzas p on p.pizza_id = od.pizza_id
  JOIN orders o on o.order_id = od.order_id
  WHERE o.date LIKE  '%2015-02%' OR o.date LIKE  '%2015-03%'
  group by p.[size]
  )


  select * from cte order by  popularity DESC