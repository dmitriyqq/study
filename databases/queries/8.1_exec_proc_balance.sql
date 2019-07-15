declare @mybalance bigint;
exec CurrentBalance 4, @balance = @mybalance output
print 'Balance = ' + CONVERT(VARCHAR(50), @mybalance)