use Aquapark;
select c.id, c.handle,
    case
        -- rename co to co2 in subquery, because of linter
        when exists(select * from CafeOrders co2 where co2.id = c.id)
            then sum(oi.amount * ci.cost)
        else 0
    end as 'cost'
from OrderItems oi
inner join CafeOrders co on oi.[order] = co.id
inner join CafeItems ci on oi.item = ci.id
right join Customers c on co.customer = c.id
group by c.id, c.handle;