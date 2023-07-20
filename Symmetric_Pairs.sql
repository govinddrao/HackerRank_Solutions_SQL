with a as (
select f1.x as x, f1.y as y
from functions f1
join functions f2
on f1.x = f2.y and f1.y = f2.x
where f1.x != f1.y)
, b as (
select x, y, count(*) as num
from functions where x = y group by x, y)
, c as (
select x, y from a
UNION
select x, y from b where num != 1)
select x, y from c where x <= y order by x