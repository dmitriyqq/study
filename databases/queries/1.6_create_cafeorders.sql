
create table CafeOrders
(
  id       bigint identity,
  customer bigint    not null,
  [time]   datetime  not null,
  constraint CafeOrders_pk
    primary key nonclustered (id),
  constraint CafeOrders_Customers_id_fk
    foreign key (customer) references Customers
      on update cascade on delete cascade
);
insert into CafeOrders(customer, [time])
values
(3,	'2019-05-08 12:36:44.000'),
(4,	'2019-05-08 12:37:33.000'),
(1,	'2019-05-08 18:34:42.000'),
(2,	'2019-05-08 18:35:26.000'),
(5,	'2019-05-08 18:37:33.000')
