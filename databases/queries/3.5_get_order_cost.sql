use Aquapark;
select co.time, c.id, c.handle, oi.[order], sum(oi.amount * ci.cost) as 'cost'
from OrderItems oi
inner join CafeOrders co on oi.[order] = co.id
inner join CafeItems ci on oi.item = ci.id
inner join Customers c on co.customer = c.id
group by oi.[order], c.id, c.handle, co.time;
