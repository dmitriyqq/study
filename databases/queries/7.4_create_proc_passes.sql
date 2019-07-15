create procedure SpentMoneyPassesTimeTravel
  @lower datetime,
  @upper datetime,
  @id bigint,
  @money bigint output as
select @money = isnull(sum(s.seasonpass), 0)
from Passes p
inner join Services s on p.service = s.id
right join Customers c on p.customer = c.id
where p.time > @lower and p.time < @upper and p.customer = @id
group by c.id
return;
