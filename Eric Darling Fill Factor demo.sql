select 
	schema_name = 
		s.name,
	table_name =
		t.name,
	index_name =
		i.name,
	ps.avg_fragmentation_in_percent,
	ps.avg_page_space_used_in_percent,
	ps.page_count,
	ps.index_depth,
	ps.index_level,
	ps.alloc_unit_type_desc
from 
	 sys.schemas as s
inner join
	 sys.tables as t
		on s.schema_id = t.schema_id
inner join
	 sys.indexes as i
		on t.object_id = i.object_id
cross apply sys.dm_db_index_physical_stats
(
	DB_ID(),
	t.object_id,
	i.index_id,
	null,
	N'DETAILED'
) as ps
where 
	s.name = N'dbo'
and t.name = N'Users' 
and ps.index_level = 0
and i.index_id = 2
order by 
	ps.index_id;