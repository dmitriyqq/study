alter procedure BalanceTimeTravel
  @lower datetime,
  @upper datetime,
  @id bigint,
  @balance bigint output as
begin
    exec IncomingDepositsTimeTravel @lower, @upper, @id
    exec SpentMoneyBillsTimeTravel @lower, @upper, @id
    exec SpentMoneyPassesTimeTravel @lower, @upper, @id
    exec SpentMoneyCafeTimeTravel @lower, @upper, @id
    exec TotalSharedMoneyTimeTravel @lower, @upper, @id
end
go

