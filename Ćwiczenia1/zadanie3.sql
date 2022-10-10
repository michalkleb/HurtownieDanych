with cte as(
SELECT od.[order_id]
	  ,sum(p.price*od.quantity) as order_amount
  FROM [cwiczenia1].[dbo].[order_details] od
  JOIN pizzas p on p.pizza_id = od.pizza_id
  JOIN orders o on o.order_id = od.order_id
  WHERE o.date LIKE '%2015-02%'
  group by od.order_id
  )

  select * from (
	  select order_id
			,order_amount
			,RANK () OVER ( 
				ORDER BY order_amount DESC
			) cost_rank 
	  from cte 
	) t
	where cost_rank <= 10
  


 



