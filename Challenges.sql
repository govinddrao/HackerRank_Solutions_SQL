with a as (
select hacker_id, count(distinct challenge_id) as challenge_created
from challenges
group by hacker_id)
, b as (
select a.hacker_id, name, a.challenge_created, count(*) over(partition by challenge_created) as total_ppl_same, max(a.challenge_created) over() as max_challenges
from a
left join hackers
on a.hacker_id = hackers.hacker_id)
, c as (
select b.hacker_id, b.name, challenge_created
from b
where total_ppl_same > 1 and challenge_created < max_challenges)
select hacker_id, name, challenge_created
from b
where hacker_id not in (select hacker_id from c)
order by challenge_created desc, hacker_id asc
