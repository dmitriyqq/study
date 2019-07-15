declare @customer int = 4;
select time, 'Service charge' as type from Bills
    where customer = @customer
union
select time, 'Bought pass' as type from Passes
    where customer = @customer
union
select time, 'Made order in cafe' as type from CafeOrders
    where customer = @customer
union
select time, 'Shared money' as type from Deposits
    where [from] = @customer
union
select time, 'Incoming deposit' as type from Deposits
    where [to] = @customer
order by time;