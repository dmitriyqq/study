
create table Passes
(
  customer   bigint    not null,
  [service]  bigint    not null,
  [time]     datetime  not null,
  constraint Passes_pk
    primary key nonclustered (customer, [service], [time]),
  constraint Passes_Customers_id_fk
    foreign key (customer) references Customers
      on update cascade on delete cascade,
  constraint Passes_Service_id_fk
    foreign key ([service]) references Services
      on update cascade on delete cascade
);
insert into Passes(customer, [service], [time])
values
(1,	2, '2019-05-08 13:20:24.000'),
(3,	8, '2019-04-08 13:30:24.000'),
(3,	8, '2019-05-08 13:30:24.000'),
(4,	8, '2019-05-08 13:30:13.000'),
(4,	8, '2019-05-08 13:33:13.000')