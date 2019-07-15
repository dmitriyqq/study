use Aquapark;
declare @customer int = 1;
select b.time, s.displayname from Bills b 
inner join Services S on b.service = s.id
where b.customer = @customer
order by b.time;