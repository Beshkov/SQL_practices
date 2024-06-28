use StackOverflow2013;
set nocount on;
exec dbo.DropIndexes;
go


drop table if exists
	dbo.DropMe;

create table
	dbo.DropMe
(
	id integer
);

insert
	dbo.DropMe
(
	id
)
values
	(138);

select 
	dm.*
from dbo.DropMe as dm;

declare 
	@DatabaseName sysname = N'S%''; DROP TABLE dbo.DropMe--';

declare 
	@sql nvarchar(max) = N'
select
	d.*
from sys.databases as d
where d.name like ''' + @DatabaseName + N''';
';

raiserror('%s', 0, 1, @sql) with nowait;

exec sys.sp_executesql
	@sql;

select 
	dm.*
from dbo.DropMe as dm;
go

create table
	dbo.DropMe
(
	id integer
);

insert
	dbo.DropMe
(
	id
)
values
	(138);

select 
	dm.*
from dbo.DropMe as dm;

declare 
	@DatabaseName sysname = N'S%''; DROP TABLE dbo.DropMe--';

declare 
	@sql nvarchar(max) = N'
select
	d.*
from sys.databases as d
where d.name like ''%@DatabaseName%'';
';

raiserror('%s', 0, 1, @DatabaseName) with nowait;
raiserror('%s', 0, 1, @sql) with nowait;

exec sys.sp_executesql
	@sql,
	N'@DatabaseName sysname',
	@DatabaseName;

select 
	dm.*
from dbo.DropMe as dm;
go


create or alter procedure
	dbo.SelectWhatever
(
	@SchemaName sysname,
	@TableName sysname,
	@ColumnNames nvarchar(MAX)
)
as
begin
	set nocount, xact_abort on;


	declare 
		@SafeSchema sysname = null,
		@SafeTable sysname = null,
		@SafeObject sysname = null,
		@SafeColumns nvarchar(max) = null,
		@SQL nvarchar(max) = N'';

		/*Look up shcema and table names*/
		select
			@SafeSchema = QUOTENAME(s.name),
			@SafeTable = QUOTENAME(t.name)
		from sys.tables as t
		inner join sys.schemas as s
			on s.schema_id = t.schema_id
		where s.name = @SchemaName
		and	  t.name = @TableName

		/*Constuct a fully qualified object name here*/
		select
			@SafeObject	= 
				@SchemaName +
				N'.' +
				@SafeTable; 

        /*Validate passed in columns here*/
		select
			@SafeColumns =
				STRING_AGG(QUOTENAME(c.name), ',')
		from sys.columns as c
		where c.object_id = OBJECT_ID(@SafeObject)
		and   c.name in
				(
					select 
						TRIM(ss.value)
					from STRING_SPLIT(@ColumnNames, ',') as ss
				);
 
		/*if any of these is NULL, we have a problem*/
		if (@SafeSchema is null)
		begin
			raiserror('invalid schema: %s', 0, 1, @SchemaName) with nowait;
			return;
		end;

		if (@SafeTable is null)
		begin
			raiserror('invalid table: %s', 0, 1, @SafeTable) with nowait;
			return;
		end;

		if (@SafeColumns is null)
		begin
			raiserror('invalid column list: %s', 0, 1, @SafeColumns) with nowait;
			return;
		end;

		set @SQL += N'
select top (100)
	' + @SafeColumns + N'
from ' + @SafeObject + N';';

		raiserror('%s', 0, 1, @sql) with nowait;

		exec sys.sp_executesql
			@sql;
end;
go
