create view SpentMoneyCafe as
select c.id as 'customer',
    ISNULL(sum(oi.amount * ci.cost), 0) as 'cafe_expenses'
from OrderItems oi
inner join CafeOrders co on oi.[order] = co.id
inner join CafeItems ci on oi.item = ci.id
right join Customers c on co.customer = c.id
group by c.id;