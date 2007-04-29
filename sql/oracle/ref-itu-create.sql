-- packages/ref-itu/sql/postgresql/ref-itu-create.sql
--
-- @author jon@jongriffin.com.com
-- @creation-date 2003-02-25
-- @cvs-id $Id$

create table itu_notes (
    note_id     char(3)
                constraint itu_notes_id_pk
                    primary key,
    note        varchar(1024)
                constraint itu_notes_note_nn
                    not null
                constraint itu_notes_note_uq
                    unique
);

create table itu_codes (
    itu_id      integer
                constraint itu_code_pk
                    primary key,
    code        char(6)
                constraint itu_code_nn
                    not null,
    country     varchar(100)
                constraint itu_country_nn
                    not null,
      note_id     char(3)
		constraint itu_codes_note_fk
                    references itu_notes (note_id)
);


comment on table itu_codes is '
    This is the ITU country dialing code list.
';

-- add this table into the reference repository

declare
    v_id integer;
begin
    v_id :=  acs_reference.new (
        table_name      => 'itu_codes',            
        last_update     => to_date('2002-05-01','YYYY-MM-DD'),
        source          => 'ITU',                  
        source_url      => 'http://www.itu.int/',  
        effective_date  => '2002-05-01'            
    );
commit;
end;
/
-- This is the translated mapping of country names
-- Need to see if ITU used the same country names as ISO and if so, we can use those for 
-- translated names, but they have some non-country names

@ '../common/ref-itu-data.sql'
