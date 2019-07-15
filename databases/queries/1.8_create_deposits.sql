
create table Deposits
(
    amount bigint   not null,
    [time] datetime not null,
    [from] bigint
        constraint Deposits_Customers_from_id_fk
            references Customers,
    [to]   bigint   not null
        constraint Deposits_Customers_id_fk
            references Customers,
    constraint Deposits_pk
        unique ([from], [to], [time])
)
insert into Deposits([time], [to], amount, [from])
values
('2019-05-08 12:35:49.000',	1, 200000, null),
('2019-05-08 12:37:16.000',	2, 300000, null),
('2019-05-08 10:12:23.000',	3, 350000, null),
('2019-05-08 10:07:29.000',	4, 100000, null),
('2019-05-08 14:35:53.000',	4, 40000, 3),
('2019-05-08 12:50:14.000',	5, 30000, 1),
('2019-05-08 12:50:14.000',	5, 30000, 2)
