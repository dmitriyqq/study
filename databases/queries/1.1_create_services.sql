create table Services
(
  id bigint identity
    constraint Service_pk
      primary key nonclustered,
  seasonpass   bigint        not null,
  normalprice  bigint        not null,
  displayname  varchar(255)  not null,
  childallowed bit default 0 not null
);
create unique index Service_displayname_uindex
  on Services (displayname);
insert into Services(seasonpass, normalprice, displayname, childallowed)
values
(0,	0,	'coffee shop',	1),
(10000,	100, 'large swimming pool',	0),
(8000,	100, 'small swimming pool',	1),
(20000,	250, 'steam bath',	0),
(30000,	300, 'dry sauna',	0),
(25000, 	250, 'ekstremalus',	0),
(30000,	300, 'adrenalinas',	0),
(40000,	400, 'bermudai',	0),
(5000, 100, 'kid area',	0)