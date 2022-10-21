select count(order_id) as order_count, date, DATEPART(hh,time) as hour
	from orders
	where date='2015-01-01'
	group by DATEPART(hh,time),date;