
create table Bills
(
  [time] datetime not null,
  [service] bigint    not null,
  customer bigint    not null,
  duration bigint    not null,
  constraint Bills_Customers_id_fk
    foreign key (customer) references Customers
      on update cascade on delete cascade,
  constraint Bills_Service_id_fk
    foreign key ([service]) references Services
      on update cascade on delete cascade
);
insert into Bills([time], [service], customer, duration)
values 
('2019-05-08 13:02:42.000',	1,	1,	79),
('2019-05-08 13:02:23.000',	1,	2,	80),
('2019-05-08 13:02:55.000',	1,	5,	79),
('2019-05-08 14:35:42.000',	6,	1,	209),
('2019-05-08 14:38:53.000',	6,	2,	181),
('2019-05-08 14:42:15.000',	9,	5,	219),
('2019-05-08 18:33:47.000',	6,	1,	59),
('2019-05-08 18:45:33.000',	6,	2,	62),
('2019-05-08 18:34:16.000',	9,	5,	64),
('2019-05-08 10:12:42.000',	2,	3,	129),
('2019-05-08 10:12:42.000',	2,	4,	129),
('2019-05-08 13:34:23.000',	8,	3,	276),
('2019-05-08 13:33:11.000',	8,	4,	264)