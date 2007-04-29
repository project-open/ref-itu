-- packages/ref-itu/sql/postgresql/ref-itu-create.sql
--
-- @author jon@jongriffin.com.com
-- @creation-date 2003-02-25
-- @cvs-id $Id$

create table itu_notes (
    note_id     char(3)
                constraint itu_notes_id_pk
                    primary key,
    note        text
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

select acs_reference__new (
        'itu_codes',            -- table_name
        '2002-05-01',
        'ITU',                  -- source
        'http://www.itu.int/',  -- source_url
        to_date('2002-05-01','YYYY-MM-DD')       -- effective_date
    );

-- This is the translated mapping of country names
-- Need to see if ITU used the same country names as ISO and if so, we can use those for 
-- translated names, but they have some non-country names

begin;
\i ../common/ref-itu-data.sql
end;
