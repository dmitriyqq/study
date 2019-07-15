create trigger CheckBalanceBeforeOrder on OrderItems after insert as
if exists(select c.id as 'customer'
  from inserted oi
  inner join CafeOrders co on oi.[order] = co.id
  inner join CafeItems ci on oi.item = ci.id
  right join Customers c on co.customer = c.id
  group by c.id
  having exists(select * from Balance b 
    where b.customer = c.id and b.balance < (case
        when exists(select * from CafeOrders co2 where co2.id = c.id)
            then sum(oi.amount * ci.cost)
        else 0
    end)))
begin
raiserror ('Can not purchase cafe item, check the balance.', 16, 1)
rollback transaction
return
end
