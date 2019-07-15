create procedure IncomingDepositsTimeTravel
  @lower datetime,
  @upper datetime,
  @id bigint,
  @money bigint output as
select @money = ISNULL(sum(d.amount), 0)
from Deposits d
right join Customers c on c.[id] = d.[to]
where d.time > @lower and d.time < @upper
group by c.[id]
having  c.[id] = @id
return
