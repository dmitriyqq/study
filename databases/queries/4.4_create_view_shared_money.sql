create view TotalSharedMoney as
select c.id as 'customer',  ISNULL(sum(d.amount), 0) as 'shared_amount'
from Deposits d
right join Customers c on d.[from] = c.id
group by c.id;