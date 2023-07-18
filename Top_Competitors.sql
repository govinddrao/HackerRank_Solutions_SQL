with a as (
select submissions.*, name
from submissions
left join hackers
on submissions.hacker_id = hackers.hacker_id)
, b as (
select a.*, difficulty_level
from a
left join challenges
on a.challenge_id = challenges.challenge_id)
, c as (
select b.*, difficulty.score as total_score
from b
left join difficulty
on b.difficulty_level = difficulty.difficulty_level)
, d as (
select c.*, case when score = total_score then 1 else 0 end as flag
from c)
, e as (select hacker_id, name, sum(flag) as total_full_scores
from d
group by hacker_id, name)
select hacker_id, name
from e
where total_full_scores > 1
order by total_full_scores  desc , hacker_id asc
