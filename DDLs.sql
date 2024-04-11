use StackOverflow2013;
go

/* this is a test table to check how to use DDL (Data Definition Language)*/

drop table if exists alx.test_table_one;
drop schema if exists alx;
go

create schema alx;
go

create table alx.test_table_one
(
	id bigint identity(1,1) 
	Constraint PK_tst_tbl_one Primary key clustered 
	with(	fillfactor= 86 /*def = 0*/
		,	pad_index = on /*def = off*/
		,	ignore_dup_key = off /*def = off*/
		,	statistics_norecompute = off /*def = off*/
		,	allow_row_locks = on /*def = on*/
		,	allow_page_locks = on /*def = on*/
		,	optimize_for_sequential_key = on /*def = off*/
		)
,	datecreated datetime2(7) not null constraint DF_datecreated default (current_timestamp)
,	insertable int not null
);
go

insert into alx.test_table_one (insertable)
values (1),(2),(3);

select * from alx.test_table_one;
