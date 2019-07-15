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

select * from Deposits;

declare @moneyFirst bigint;
exec IncomingDepositsTimeTravel '2019-05-08 10:35:53.000', '2019-05-08 15:35:53.000', 1, @money = @moneyFirst output
Print 'Money ' + CONVERT(VARCHAR(50), @moneyFirst);


create procedure SpentMoneyBillsTimeTravel
  @lower datetime,
  @upper datetime,
  @id bigint,
  @money bigint output as
select @money =
 sum(case
   when p.time is NULL then b.duration * s.normalprice
   when DATEDIFF(minute, p.time, b.time) >= 0 then 0
   when DATEDIFF(minute, p.time, b.time) < 0 then ABS(DATEDIFF(minute, p.time, b.time)) * s.normalprice
 end)
from Bills b
inner join Services s on s.id = b.service
inner join Customers c on c.id = b.customer
left join Passes p on b.customer = p.customer
and CONVERT(date, b.time) = CONVERT(date, p.time)
and b.service = p.service
and DATEADD(mi, b.duration, b.time) > p.time
where DATEADD(mi, b.duration, b.time) > @lower and DATEADD(mi, b.duration, b.time) < @upper and b.customer = @id
group by b.customer
return;

create procedure SpentMoneyCafeTimeTravel
  @lower datetime,
  @upper datetime,
  @id bigint,
  @money bigint output as
select @money = isnull(sum(oi.amount * ci.cost), 0)
from OrderItems oi
inner join CafeOrders co on oi.[order] = co.id
inner join CafeItems ci on oi.item = ci.id
right join Customers c on co.customer = c.id
where co.time > @lower and co.time < @upper and co.customer = @id
group by c.id
return;

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

create procedure TotalSharedMoneyTimeTravel
  @lower datetime,
  @upper datetime,
  @id bigint,
  @money bigint output as
@money = 0;
select @money = isnull(sum(d.amount), 0)
from Deposits d
right join Customers c on d.[from] = c.id
where d.time > @lower and d.time < @upper and d.[from] = @id
group by c.id
return;

select * from Deposits;

alter procedure CurrentBalance
  @customer bigint,
  @balance  bigint output as
begin
  declare @income bigint = 0;
  declare @cafe bigint = 0;
  declare @bills bigint = 0;
  declare @passes bigint = 0;
  declare @money bigint = 0;
  declare @now datetime = GETDATE();
  declare @lower datetime = '1901-01-01 00:00:00.000';
  exec IncomingDepositsTimeTravel @lower, @now, @customer, @money = @income output
  exec SpentMoneyCafeTimeTravel   @lower, @now, @customer, @money = @cafe output
  exec SpentMoneyBillsTimeTravel  @lower, @now, @customer, @money = @bills output
  exec SpentMoneyPassesTimeTravel @lower, @now, @customer, @money = @passes output
  exec TotalSharedMoneyTimeTravel @lower, @now, @customer, @money = @money output
select @balance = @income - @cafe - @bills - @passes - @money
end;
return;

declare @mybalance bigint;
exec CurrentBalance 4, @balance = @mybalance output
print 'Balance ' + CONVERT(VARCHAR(50), @mybalance)

  select * from Balance;

SELECT CONVERT (date, GETUTCDATE());


declare @moneyFirst bigint = 0;
exec TotalSharedMoneyTimeTravel '2019-05-08 10:35:53.000', '2019-05-08 15:35:53.000', 5, @money = @moneyFirst output
Print 'Money ' + CONVERT(VARCHAR(50), @moneyFirst);

create procedure UserHistory @customer int as
select time, 'Service charge' as type from Bills where customer = @customer
union
select time, 'Bought pass' as type from Passes where customer = @customer
union
select time, 'Made order in cafe' as type from CafeOrders where customer = @customer
union
select time, 'Shared money' as type from Deposits where [from] = @customer
union
select time, 'Incoming deposit' as type from Deposits where [to] = @customer
order by time;

create trigger CheckBalanceBeforeOrder on OrderItems after insert as
if exists(select c.id as 'customer'
  from inserted oi
  inner join CafeOrders co on oi.[order] = co.id
  inner join CafeItems ci on oi.item = ci.id
  right join Customers c on co.customer = c.id
  group by c.id
  having exists(select * from Balance b where b.customer = c.id and b.balance < (case
        when exists(select * from CafeOrders co2 where co2.id = c.id)
            then sum(oi.amount * ci.cost)
        else 0
    end)))
begin
raiserror ('Can not purchase cafe item, check the balance.', 16, 1)
rollback transaction
return
end

alter trigger CheckPass on Passes after insert as
if exists(select * from inserted ins where
      exists(select * from Passes p where p.customer = ins.customer
                                     and p.service = ins.service
                                     and convert(date, p.time) = convert(date, ins.time)))
begin
raiserror ('Pass already bought for this service', 16, 1)
rollback transaction
return
end

select convert(date, getdate())

select * from Passes;
insert into Passes(customer, [service], [time])
values
(2,	8, '2019-08-11 13:21:24.000')

Select * from Balance;
insert into OrderItems([order], amount, item)
values
(4,	1,	1);
select * from CafeItems;

declare @mybalance bigint;
exec CurrentBalance 1, @balance = @mybalance output
print 'Balance = ' + CONVERT(VARCHAR(50), @mybalance)