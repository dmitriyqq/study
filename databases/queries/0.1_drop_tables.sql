drop trigger if exists CheckBalanceBeforeOrder;

drop procedure if exists IncomingDepositsTimeTravel;
drop procedure if exists SpentMoneyBillsTimeTravel;
drop procedure if exists SpentMoneyCafeTimeTravel;
drop procedure if exists SpentMoneyPassesTimeTravel;
drop procedure if exists TotalSharedMoneyTimeTravel;
drop procedure if exists UserHistory;
drop procedure if exists CurrentBalance;

drop view if exists Balance;
drop view if exists SpentMoneyPasses;
drop view if exists SpentMoneyOnBills;
drop view if exists IncomingDeposits;
drop view if exists TotalSharedMoney;
drop view if exists SpentMoneyCafe;

drop table if exists Deposits;
drop table if exists OrderItems;
drop table if exists CafeOrders;
drop table if exists CafeItems;
drop table if exists Bills;
drop table if exists Passes;
drop table if exists Services;
drop table if exists Customers;
