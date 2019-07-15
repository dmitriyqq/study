create procedure TotalSharedMoneyTimeTravel
  @lower datetime,
  @upper datetime,
  @id bigint,
  @money bigint output as
select @money = isnull(sum(d.amount), 0)
from Deposits d
right join Customers c on d.[from] = c.id
where d.time > @lower and d.time < @upper and d.[from] = @id
group by c.id
return;