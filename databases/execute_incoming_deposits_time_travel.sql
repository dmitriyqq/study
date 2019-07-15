select * from Deposits;
declare @firstMoney bigint;
exec IncomingDepositsTimeTravel '2019-05-08 12:35:49.000', '2019-05-08 14:35:53.000', 1, @firstMoney;
print 'First customer had ' + CONVERT(VARCHAR, @firstMoney) + ' in his account';
go;