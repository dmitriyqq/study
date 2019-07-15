create view Balance as
select id.customer,
       money,
       isnull(bills, 0) as 'bills',
       shared_amount,
       cafe_expenses,
       passes_expenses,
       (money - isnull(bills, 0) - shared_amount
            - cafe_expenses - passes_expenses) as 'balance'
from IncomingDeposits id
left join SpentMoneyBills mb on id.customer = mb.customer
inner join TotalSharedMoney sm on id.customer = sm.customer
inner join SpentMoneyCafe mc on id.customer = mc.customer
inner join SpentMoneyPasses mp on id.customer = mp.customer;