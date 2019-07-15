
create table OrderItems
(
  [order] bigint not null,
  amount  int    not null,
  item    bigint not null,
  constraint OrderItem_CafeItem_id_fk
    foreign key (item) references CafeItems
      on update cascade on delete cascade,
  constraint OrderItem_CafeOrders_id_fk
    foreign key ([order]) references CafeOrders
      on update cascade on delete cascade
);
insert into OrderItems([order], amount, item)
values
(1,	1,	2),
(1,	1,	5),
(2,	1,	3),
(2,	1,	7),
(3,	1,	2),
(3,	1,	5),
(4,	1,	3),
(4,	1,	7),
(4,	1,	1),
(4,	1,	9),
(2,	1,	3),
(2,	1,	7),
(5,	1,	1),
(5,	1,	9)