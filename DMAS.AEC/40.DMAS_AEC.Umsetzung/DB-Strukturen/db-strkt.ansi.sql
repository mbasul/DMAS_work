-- all current databases
select
       'DATABASE' as object_type
       , database_name as object_name
       , database_id as object_id
       , object_construct(*) as metadata
    from snowflake.account_usage.databases
    where deleted is null
union
-- all current schemas
select
       'SCHEMA' as object_type
       , schema_name as object_name
       , schema_id as object_id
       , object_construct(*) as metadata
    from snowflake.account_usage.schemata
    where deleted is null
union
-- all current tables
select
       'TABLE' as object_type
       , table_name as object_name
       , table_id as object_id
       , object_construct(*) as metadata
    from snowflake.account_usage.tables
    where deleted is null
       and table_type = 'BASE TABLE'
union
-- all current views
select
       'VIEW' as object_type
       , table_name as object_name
       , table_id as object_id
       , object_construct(*) as metadata
    from snowflake.account_usage.views
    where deleted is null
union
-- all current stages
select
       'STAGE' as object_type
       , stage_name as object_name
       , stage_id as object_id
       , object_construct(*) as metadata
    from snowflake.account_usage.stages
    where deleted is null
union
-- all current pipes
select
       'PIPE' as object_type
       , pipe_name as object_name
       , pipe_id as object_id
       , object_construct(*) as metadata
    from snowflake.account_usage.pipes
    where deleted is null
union
-- all current functions and procedures
select
       'FUNCTION_OR_SPROC' as object_type
       , function_name as object_name
       , function_id as object_id
       , object_construct(*) as metadata
    from snowflake.account_usage.functions
    where deleted is null
union
-- all current file formats
select
       'FILE_FORMAT' as object_type
       , file_format_name as object_name
       , file_format_id as object_id
       , object_construct(*) as metadata
    from snowflake.account_usage.file_formats
    where deleted is null
union
-- all current file formats
select
       'SEQUENCES' as object_type
       , sequence_name as object_name
       , sequence_id as object_id
       , object_construct(*) as metadata
    from snowflake.account_usage.sequences
    where deleted is null
union
-- all current masking policies (column)
select
       'MASKING_POLICY' as object_type
       , policy_name as object_name
       , policy_id as object_id
       , object_construct(*) as metadata
    from snowflake.account_usage.masking_policies
    where deleted is null
union
-- all current row access policies
select
       'ROW_ACCESS_POLICY' as object_type
       , policy_name as object_name
       , policy_id as object_id
       , object_construct(*) as metadata
    from snowflake.account_usage.row_access_policies
    where deleted is null
union
-- all current tags
select
       'TAG' as object_type
       , tag_name as object_name
       , tag_id as object_id
       , object_construct(*) as metadata
    from snowflake.account_usage.tags
    where deleted is null
union
-- all current views
select
       'ROLE' as object_type
       , name as object_name
       , null as object_id
       , object_construct(*) as metadata
    from snowflake.account_usage.roles
    where deleted_on is null;
-- all current users
select
       'USER' as object_type
       , name as object_name
       , null as object_id
       , object_construct(*) as metadata
    from snowflake.account_usage.users
    where deleted_on is null
    order by object_type
       , object_name
       , object_id
;

-- other objects
show warehouses;
show roles;
show users;
show streams in account;
show security integrations;
show storage integrations;
show materialized views in account;
