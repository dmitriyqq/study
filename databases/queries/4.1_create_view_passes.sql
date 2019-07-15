create view SpentMoneyPasses as
select c.id as 'customer', 
    isnull(sum(s.seasonpass), 0) as 'passes_expenses'
from Passes p
inner join Services s on p.service = s.id
right join Customers c on p.customer = c.id
group by c.id;