with a as (
select start_date, end_date
from projects
where end_date not in (select start_date from projects))
, b as (
select start_date, end_date
from projects
where start_date not in (select end_date from projects))
, c as (
select b.start_date, min(a.end_date) as end_date
from a
cross join b
where a.end_date > b.start_date
group by b.start_date)
select *
from c
order by datediff(day, end_date, start_date) desc, start_date
