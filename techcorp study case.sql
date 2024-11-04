-- 1. Top 3 customers based on orders
select
first_name, last_name,
sum(total_amount) as total_order_amount
from Customers as c
join Orders o ON o.customer_id = c.customer_id
group by c.customer_id
order by total_order_amount desc
limit 3
;

-- 2. average order value for each customer
select
c.first_name
,c.last_name
,avg(o.total_amount) average_order
from customers c
join orders o on c.customer_id = o.customer_id
group by c.customer_id;

-- 3. employees with >4 resolved ticket support
select
e.first_name, e.last_name,
count(s.ticket_id)
from employees e
join supporttickets s on e.employee_id = s.employee_id
where s.status= 'resolved'
group by e.employee_id
having count(s.ticket_id)>4
;

-- 4. product yang belum pernah dipesan
select
products.product_name
from products
left join orderdetails od on od.product_id= products.product_id
where od.order_id is null
;

-- 5. total revenue
select
sum(quantity*unit_price)
from orderdetails;

-- 6. harga rata-rata tiap kategori product
with cte_avg_price as (
select category, avg(price) average
from products
group by category
)
select * from cte_avg_price where average>500
;

-- 7. customers yang pernah order>1000
select*
from customers
where
customer_id in 
(select customer_id
from orders
where total_amount>1000
)
;
