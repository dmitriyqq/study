
create table CafeItems
(
  id     bigint identity,
  [name] varchar(255)   not null,
  cost   bigint         not null,
  constraint CafeItem_pk
    primary key nonclustered (id)
);
create unique index CafeItem_name_uindex
  on CafeItems ([name]);
insert into CafeItems(cost, [name])
values
(10000, 'Fresh Strawberry Cheesecake'),
(15000, 'Lemon Meringue Cheesecake'),
(20000, 'White Chocolate Raspberry Truffle'),
(13000, 'Biscuit Cake'),
(75000, 'Cafe Latte'),
(10000, 'Cappuccino'),
(10000, 'Espresso'),
(12000, 'Macchiato'),
(13000, 'Mochaccino'),
(14000, 'Irish Coffee')

