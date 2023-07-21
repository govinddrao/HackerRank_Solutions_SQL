select n, 'Leaf' as type
from bst
where n not in (select p from bst where p is not null)
UNION
select n, 'Root' as type
from bst
where p is null
UNION
select n, 'Inner' as type
from bst
where n in (select p from bst where p is not null)
and n not in (select n from bst where p is null)