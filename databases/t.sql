create table CafeItems
(
  id   bigint identity,
  name varchar(255) not null,
  cost bigint       not null,
  constraint CafeItem_pk
    primary key nonclustered (id)
)
go

create unique index CafeItem_name_uindex
  on CafeItems (name)
go

create table Customers
(
  id      bigint identity,
  balance bigint not null,
  constraint Customers_pk
    primary key nonclustered (id)
)
go

create table CafeOrders
(
  id       bigint identity,
  customer bigint    not null,
  time     timestamp not null,
  constraint CafeOrders_pk
    primary key nonclustered (id),
  constraint CafeOrders_Customers_id_fk
    foreign key (customer) references Customers
      on update cascade on delete cascade
)
go

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
)
go

create table Services
(
  id          bigint identity,
  seasonpass  bigint       not null,
  normalprice bigint       not null,
  displayname varchar(255) not null,
  constraint Service_pk
    primary key nonclustered (id)
)
go

create table Bills
(
  time     timestamp not null,
  service  bigint    not null,
  customer bigint    not null,
  duration bigint    not null,
  constraint Bills_Customers_id_fk
    foreign key (customer) references Customers
      on update cascade on delete cascade,
  constraint Bills_Service_id_fk
    foreign key (service) references Services
      on update cascade on delete cascade
)
go

create table Passes
(
  customer bigint    not null,
  service  bigint    not null,
  time     timestamp not null,
  constraint Passes_pk
    primary key nonclustered (customer, service),
  constraint Passes_Customers_id_fk
    foreign key (customer) references Customers
      on update cascade on delete cascade,
  constraint Passes_Service_id_fk
    foreign key (service) references Services
      on update cascade on delete cascade
)
go

create unique index Service_displayname_uindex
  on Services (displayname)
go

