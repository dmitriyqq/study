create table Customers
(
  id    bigint identity
    constraint Customers_pk
      primary key nonclustered,
  handle varchar(255)  not null,
  child  bit default 0 not null
);
insert into Customers(handle, child)
values
('@deangelo',	0),
('santina.mi1993',	0),
('sunnywout@yahoo.com',	0),
('@sandwichmitwurst',	0),
('ivy.howell',	1),
('demodata',	0)
