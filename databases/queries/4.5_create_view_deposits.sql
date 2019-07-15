create view IncomingDeposits as
select c.[id] as 'customer',  ISNULL(sum(d.amount), 0) as 'money'
from Deposits d
right join Customers c on c.[id] = d.[to]
group by c.[id];