
create procedure SpentMoneyCafeTimeTravel
  @lower datetime,
  @upper datetime,
  @id bigint,
  @money bigint output as
select @money = isnull(sum(oi.amount * ci.cost), 0)
from OrderItems oi
inner join CafeOrders co on oi.[order] = co.id
inner join CafeItems ci on oi.item = ci.id
right join Customers c on co.customer = c.id
where co.time > @lower and co.time < @upper and co.customer = @id
group by c.id
return;