use Aquapark;

insert into Customers (handle) values ('@deangelo');
insert into Customers (handle) values ('santina.mi1993');
insert into Customers (handle) values ('sunnywout@yahoo.com');
insert into Customers (handle) values ('@sandwichmitwurst');
insert into Customers (handle) values ('ivy.howell');

insert into Services (displayname, seasonpass, normalprice, childallowed) values ('coffee shop', 0, 0, 1) -- coffee shop is free service
insert into Services (displayname, seasonpass, normalprice, childallowed) values ('large swimming pool', 10000, 100, 0) -- 100 rub, 1 rub/min
insert into Services (displayname, seasonpass, normalprice, childallowed) values ('small swimming pool', 8000, 100, 1) -- 80 rub, 1 rub/min
insert into Services (displayname, seasonpass, normalprice, childallowed) values ('steam bath', 20000, 250, 0) -- 200 rub, 2.5 rub/min
insert into Services (displayname, seasonpass, normalprice, childallowed) values ('dry sauna', 30000, 300, 0) -- 300 rub, 5 rub/min
insert into Services (displayname, seasonpass, normalprice, childallowed) values ('ekstremalus', 25000, 250, 0) -- 250 rub, 2.5 rub/min
insert into Services (displayname, seasonpass, normalprice, childallowed) values ('adrenalinas', 30000, 300, 0) -- 300 rub, 3 rub/min
insert into Services (displayname, seasonpass, normalprice, childallowed) values ('bermudai', 40000, 400, 0) -- 400 rub, 4 rub/min
insert into Services (displayname, seasonpass, normalprice, childallowed) values ('kid area', 5000, 100, 0) -- 50 rub, 1 rub/min

insert into CafeItems(name, cost) values ('Fresh Strawberry Cheesecake', 10000); -- 100 rub
insert into CafeItems(name, cost) values ('Lemon Meringue Cheesecake', 15000); -- 150 rub
insert into CafeItems(name, cost) values ('White Chocolate Raspberry Truffle', 20000); -- 200 rub
insert into CafeItems(name, cost) values ('Biscuit Cake', 13000); -- 130 rub

insert into CafeItems(name, cost) values ('Café Latte', 75000); -- 75 rub
insert into CafeItems(name, cost) values ('Cappuccino', 10000); -- 100 rub
insert into CafeItems(name, cost) values ('Espresso', 10000);  -- 100 rub
insert into CafeItems(name, cost) values ('Macchiato', 12000);  -- 120 rub
insert into CafeItems(name, cost) values ('Mochaccino', 13000);  -- 130 rub
insert into CafeItems(name, cost) values ('Irish Coffee', 14000);  -- 140 rub

-- starting deposits
insert into Deposits(amount, time, [from], [to]) values (200000, CONVERT(DATETIME, '2019-05-08 12:35:49'), NULL, 1); -- 2000 rub.
insert into Deposits(amount, time, [from], [to]) values (300000, CONVERT(DATETIME, '2019-05-08 12:37:16'), NULL, 2); -- 2000 rub.
insert into Deposits(amount, time, [from], [to]) values (350000, CONVERT(DATETIME, '2019-05-08 10:12:23'), NULL, 3); -- 2000 rub.
insert into Deposits(amount, time, [from], [to]) values (100000, CONVERT(DATETIME, '2019-05-08 10:07:29'), NULL, 4); -- 2000 rub.

-- sharing money
insert into Deposits(amount, time, [from], [to]) values (40000, CONVERT(DATETIME, '2019-05-08 14:35:53'), 3, 4); -- 400 rub.
insert into Deposits(amount, time, [from], [to]) values (30000, CONVERT(DATETIME, '2019-05-08 12:50:14'), 1, 5); -- 300 rub.

insert into Bills(service, customer, duration, time) values (2, 1, 79, CONVERT(DATETIME, '2019-05-08 13:02:42'));
insert into Bills(service, customer, duration, time) values (2, 2, 80, CONVERT(DATETIME, '2019-05-08 13:02:23'));
insert into Bills(service, customer, duration, time) values (2, 5, 79, CONVERT(DATETIME, '2019-05-08 13:02:55'));

insert into Bills(service, customer, duration, time) values (6, 1, 209, CONVERT(DATETIME, '2019-05-08 14:35:42'));
insert into Bills(service, customer, duration, time) values (6, 2, 181, CONVERT(DATETIME, '2019-05-08 14:38:53'));
insert into Bills(service, customer, duration, time) values (9, 5, 219, CONVERT(DATETIME, '2019-05-08 14:42:15'));

insert into Bills(service, customer, duration, time) values (1, 1, 59, CONVERT(DATETIME, '2019-05-08 18:33:47'));
insert into Bills(service, customer, duration, time) values (1, 2, 62, CONVERT(DATETIME, '2019-05-08 18:45:33'));
insert into Bills(service, customer, duration, time) values (1, 5, 64, CONVERT(DATETIME, '2019-05-08 18:34:16'));

insert into CafeOrders(customer, time) values  (1, CONVERT(DATETIME, '2019-05-08 18:34:42'));
insert into CafeOrders(customer, time) values  (2, CONVERT(DATETIME, '2019-05-08 18:35:26'));
insert into CafeOrders(customer, time) values  (5, CONVERT(DATETIME, '2019-05-08 18:37:33'));

insert into OrderItems([order], amount, item) values (3, 1, 2)
insert into OrderItems([order], amount, item) values (3, 1, 5)

insert into OrderItems([order], amount, item) values (4, 1, 3)
insert into OrderItems([order], amount, item) values (4, 1, 7)

insert into OrderItems([order], amount, item) values (4, 1, 1)
insert into OrderItems([order], amount, item) values (4, 1, 9)

insert into Bills(service, customer, duration, time) values (3, 3, 129, CONVERT(DATETIME, '2019-05-08 10:12:42'));
insert into Bills(service, customer, duration, time) values (3, 4, 129, CONVERT(DATETIME, '2019-05-08 10:13:35'));

insert into Bills(service, customer, duration, time) values (1, 3, 56, CONVERT(DATETIME, '2019-05-08 12:32:59'));
insert into Bills(service, customer, duration, time) values (1, 4, 54, CONVERT(DATETIME, '2019-05-08 12:33:43'));

insert into CafeOrders(customer, time) values  (3, CONVERT(DATETIME, '2019-05-08 12:36:44'));
insert into CafeOrders(customer, time) values  (4, CONVERT(DATETIME, '2019-05-08 12:37:33'));

insert into Passes(service, customer, time) values (2, 1, CONVERT(DATETIME, '2019-05-08 13:20:24')); -- to test negative diff

insert into OrderItems([order], amount, item) values (1, 1, 2)
insert into OrderItems([order], amount, item) values (1, 1, 5)

insert into OrderItems([order], amount, item) values (2, 1, 3)
insert into OrderItems([order], amount, item) values (2, 1, 7)

insert into Passes(service, customer, time) values (8, 3, CONVERT(DATETIME, '2019-05-08 13:30:24'));
insert into Passes(service, customer, time) values (8, 4, CONVERT(DATETIME, '2019-05-08 13:30:13'));

insert into Bills(service, customer, duration, time) values (8, 3, 276, CONVERT(DATETIME, '2019-05-08 13:34:23'));
insert into Bills(service, customer, duration, time) values (8, 4, 264, CONVERT(DATETIME, '2019-05-08 13:33:11'));
