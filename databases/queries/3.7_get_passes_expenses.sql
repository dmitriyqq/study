use Aquapark;
select c.id, c.handle, isnull(sum(s.seasonpass), 0)
from Passes p
inner join Services s on p.service = s.id
inner join Customers c on p.customer = c.id
group by c.id, c.handle;
