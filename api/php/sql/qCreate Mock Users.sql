/*
    Create some mock users to have some initial data to work with
*/

-- first names
select *
from first_names;

-- last names
select *
from last_names;

-- female first names
create or replace view V_female_first_names as
select `Female Name` as female_first_name, rand
from first_names;

-- male first names
create or replace view V_male_first_names as
select `Male Name` as male_first_name, rand
from first_names;


-- male names view to union on
create or replace view V_male_mock_users as
select f.male_first_name                  as first_name
     , l.`Last Name`                      as last_name
    /* manually create some field values */
     , case 1 when 1 then 'mock user' end as user_type
     , case 1 when 1 then 'male' end      as gender
from V_male_first_names f
         inner join last_names l on f.rand = l.rand;
-- male first last join
select *
from V_male_mock_users;


-- female names view to union on
create or replace view V_female_mock_users as
select f.female_first_name                as first_name
     , l.`Last Name`                      as last_name
    /* manually create some field values */
     , case 1 when 1 then 'mock user' end as user_type
     , case 1 when 1 then 'female' end    as gender
from V_female_first_names f
         inner join last_names l on f.rand = l.rand;
-- female first last join
select *
from V_female_mock_users;


-- create a users view
create or replace view V_mock_users as
select *
from V_female_mock_users
union all
select *
from V_male_mock_users;
-- mock users view
select *
from V_mock_users
order by first_name;


-- make a mock users table
create or replace table mock_users
select *
from V_mock_users
order by first_name;
-- check the table
select *
from mock_users;




# end of file