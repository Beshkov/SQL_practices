declare @p_sql varchar(max)
set statistics io, time on
set @p_sql = REPLICATE ('Imalo edno vreme edin ****grandpa**** i edna ****grandma**** , te si imali ****pet**** , ****pet**** umrqlo i te mu napravili ****statue**** na ****statue**** pishelo : ',45) 
select @p_sql +='<!--TzLFG-->'+ @p_sql 
select @p_sql +='<!--TzLFG-->'+ @p_sql 
select @p_sql +='<!--TzLFG-->'+ @p_sql 
--select @p_sql +='<!--TzLFG-->'+ @p_sql 
--select @p_sql +='<!--TzLFG-->'+ @p_sql 
--select @p_sql +='<!--TzLFG-->'+ @p_sql 
--select @p_sql +='<!--TzLFG-->'+ @p_sql 
--select @p_sql +='<!--TzLFG-->'+ @p_sql 
--select @p_sql +='<!--TzLFG-->'+ @p_sql 


declare @t_tbl table (input varchar(max))

while len(@p_sql) > 0
begin
	
	select len(@p_sql)
	declare @p_char_index int = 0
	set @p_char_index = CHARINDEX('<!--TzLFG-->', @p_sql, 0)+12 
	set @p_char_index = iif(@p_char_index = 12, len(@p_sql) + 1, @p_char_index)
	
	select @p_char_index
	
	insert into @t_tbl
	select left(@p_sql, @p_char_index)

	set @p_sql = substring(@p_sql, @p_char_index, len(@p_sql))
	--select * from @t_tbl
	select @p_sql
	select len(@p_sql)
	
end

while (select count(*) from @t_tbl) > 0
begin
declare @p_sql2 varchar(max)= '', @p_pesho varchar(max) = ''

select top 1 @p_pesho = input from @t_tbl

;WITH  q AS
        (
        SELECT TOP 1 *
        FROM    @t_tbl
        /* You may want to add ORDER BY here */
        )
DELETE
FROM    q

select @p_pesho = replace(@p_pesho , '****grandpa****', 'dyado') 
select @p_pesho = REPLACE(@p_pesho , '****grandma****', 'baba') 
select @p_pesho = REPLACE(@p_pesho , '****pet****', 'kuchence') 
select @p_pesho = REPLACE(@p_pesho , '****statue****', 'pametrnik') 

select @p_sql2 += isnull(@p_pesho, '')

select @p_pesho, @p_sql2

end

select @p_sql2 [test]