use StackOverflow2013;
go
set nocount on;
exec dbo.DropIndexes;

/*
drop index whatever
on dbo.Users
*/

create index
	whatever
on dbo.Users
	(Reputation)
with 
	(sort_in_tempdb = on, data_compression = page);


set statistics time, io on;
go

select
	c = count_big(*)
from dbo.Users as u
where u.Reputation = 289
and	  1 = (select 1);
go

select
	c = count_big(*)
from dbo.Users as u
where u.Reputation 
		between 100
			and 450
and	  1 = (select 1);
go

select
	c = count_big(*)
from dbo.Users as u
where 1 = (select 1);
go

set statistics time, io off;
go


alter index whatever on dbo.Users rebuild with (fillfactor = 5);

alter index whatever on dbo.Users rebuild with (fillfactor = 50);

alter index whatever on dbo.Users rebuild with (fillfactor = 80);

alter index whatever on dbo.Users rebuild with (fillfactor = 100);