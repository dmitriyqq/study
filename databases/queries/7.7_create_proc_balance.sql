
create procedure CurrentBalance
  @customer bigint,
  @balance  bigint output as
begin
  declare @income bigint = 0;
  declare @cafe bigint = 0;
  declare @bills bigint = 0;
  declare @passes bigint = 0;
  declare @money bigint = 0;
  declare @now datetime = GETDATE();
  declare @lower datetime = '1901-01-01 00:00:00.000';
  exec IncomingDepositsTimeTravel @lower, @now, @customer,
    @money = @income output
  exec SpentMoneyCafeTimeTravel   @lower, @now, @customer,
    @money = @cafe output
  exec SpentMoneyBillsTimeTravel  @lower, @now, @customer,
    @money = @bills output
  exec SpentMoneyPassesTimeTravel @lower, @now, @customer,
    @money = @passes output
  exec TotalSharedMoneyTimeTravel @lower, @now, @customer,
    @money = @money output
select @balance = @income - @cafe - @bills - @passes - @money
end;
return;