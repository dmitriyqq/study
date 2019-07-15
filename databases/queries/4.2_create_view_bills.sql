create view SpentMoneyOnBills as
select b.customer,
  sum(case
    when p.time is NULL then b.duration * s.normalprice
    when DATEDIFF(minute, p.time, b.time) >= 0 then 0
    when DATEDIFF(minute, p.time, b.time) < 0 then 
      ABS(DATEDIFF(minute, p.time, b.time)) * s.normalprice
   end) as 'bills'
from Bills b
inner join Services s on s.id = b.service
inner join Customers c on c.id = b.customer
left join Passes p on b.customer = p.customer
and CONVERT(date, b.time) = CONVERT(date, p.time)
and b.service = p.service
and DATEADD(mi, b.duration, b.time) > p.time
group by b.customer;